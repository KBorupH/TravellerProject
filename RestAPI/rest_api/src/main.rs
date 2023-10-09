mod entity;
mod hashing;
mod message_handler;
mod scope;

use crate::scope::CustomClaims;
use aliri::{
    jwa::Algorithm,
    jwt::{Audience, CoreValidator},
};
use aliri_oauth2::Authority;
use aliri_tower::Oauth2Authorizer;
use anyhow::Result;
use axum::{routing::get, Router};
use axum_server::tls_rustls::RustlsConfig;

const SERVER_CERT: &[u8] = include_bytes!("../keys/cert.pem");
const SERVER_KEY: &[u8] = include_bytes!("../keys/key.pem");

const AUDIENCE: &'static str = "0.0.0.0";

#[tokio::main]
async fn main() -> Result<()> {
    let authority = construct_authority().await?;

    let authorizer = Oauth2Authorizer::new()
        .with_claims::<CustomClaims>()
        .with_terse_error_handler();

    let app = Router::new()
        .route("/admin", get(admin_action))
        .layer(authorizer.jwt_layer(authority));

    let config = RustlsConfig::from_pem(SERVER_CERT.into(), SERVER_KEY.into()).await?;

    axum_server::bind_rustls("127.0.0.0:8080".parse().unwrap(), config)
        .serve(app.into_make_service())
        .await?;

    Ok(())
}

async fn construct_authority() -> Result<Authority> {
    let validator = CoreValidator::default()
        .add_approved_algorithm(Algorithm::RS256)
        .add_allowed_audience(Audience::from_static(AUDIENCE));

    let authority = Authority::new_from_url(
        "https://dev-vtgjrzbo50ktq0do.us.auth0.com".into(),
        validator,
    )
    .await?;

    authority.spawn_refresh(std::time::Duration::from_secs(600));

    Ok(authority)
}

async fn admin_action(_: scope::AdminOnly) -> &'static str {
    "You're an admin!"
}
