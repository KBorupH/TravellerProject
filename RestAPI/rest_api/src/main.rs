mod endpoint;
use anyhow::Result;
use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
    routing::{get, post},
    Router,
};
use axum_server::tls_rustls::RustlsConfig;
use dotenv::dotenv;
use endpoint::prelude::*;
use sea_orm::{Database, DatabaseConnection};
use std::env;

const SERVER_CERT: &[u8] = include_bytes!("../keys/cert.pem");
const SERVER_KEY: &[u8] = include_bytes!("../keys/key.pem");

#[tokio::main]
async fn main() -> Result<()> {
    // let authority = construct_authority().await?;

    // let authorizer = Oauth2Authorizer::new()
    //     .with_claims::<CustomClaims>()
    //     .with_terse_error_handler();

    let db = setup_database().await?;

    let app = Router::new()
        .route("/routes/all", get(routes::get_routes))
        .route("/authenticate/login", post(login::obtain_token))
        .route("/authenticate/register", post(register::obtain_token))
        .with_state(db);
    // .layer(authorizer.jwt_layer(authority));

    let config = RustlsConfig::from_pem(SERVER_CERT.into(), SERVER_KEY.into()).await?;

    // binds the REST API  for usage later.
    axum_server::bind_rustls("10.108.149.13:3000".parse().unwrap(), config)
        .serve(app.into_make_service())
        .await?;

    Ok(())
}

async fn setup_database() -> Result<DatabaseConnection> {
    dotenv().ok();
    let db_url = env::var("TRAVELLER_DB_URL").expect("DATABASE_URL must be set");
    let db = Database::connect(&db_url).await?;
    Ok(db)
}

pub struct ApiError(anyhow::Error);

impl IntoResponse for ApiError {
    fn into_response(self) -> Response {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Something went wrong: {}", self.0),
        )
            .into_response()
    }
}

// This enables using `?` on functions that return `Result<_, anyhow::Error>` to turn them into
// `Result<_, AppError>`. That way you don't need to do that manually.
impl<E> From<E> for ApiError
where
    E: Into<anyhow::Error>,
{
    fn from(err: E) -> Self {
        Self(err.into())
    }
}
