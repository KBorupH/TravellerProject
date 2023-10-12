use crate::ApiError;
use axum::{extract::State, Json};
use hyper::{Body, Client, Request};
use hyper_tls::HttpsConnector;
use sea_orm::DatabaseConnection;
use serde::{Deserialize, Serialize};
use serde_json::json;
use tokio::runtime::Runtime;

#[derive(Serialize)]
struct TokenRequest {
    client_id: String,
    client_secret: String,
    audience: String,
    grant_type: String,
}

#[derive(Serialize, Deserialize)]
pub struct TokenResponse {
    access_token: String,
}

#[derive(Serialize)]
struct VerificationRequest {
    token: String,
}

#[derive(Deserialize)]
pub struct Credentials {
    email: String,
    password: String,
}

pub async fn obtain_token(
    State(state): State<DatabaseConnection>,
    Json(payload): Json<Credentials>,
) -> Result<Json<TokenResponse>, ApiError> {
    println!("/authenticate/login has been entered!");

    let token_request = TokenRequest {
        client_id: "EQUvFoiKGWJDCZTz6TE0MaJJsWTNi6du".to_string(),
        client_secret: "DPXtJHdjFmGEgvDjtkt9ryGMO36HlWMdJxWorXLabnquLsWwfmneqgackt3nKo4u"
            .to_string(),
        audience: "traveller".to_string(),
        grant_type: "client_credentials".to_string(),
    };

    let client = reqwest::Client::new();

    let res = client
        .post("https://dev-vtgjrzbo50ktq0do.us.auth0.com/oauth/token")
        .json(&token_request)
        .send()
        .await?;

    let token_response: TokenResponse = res.json().await?;

    Ok(Json(token_response))
}

// async fn verify_token(client: &Client, token: &str) -> Result<bool, reqwest::Error> {
//     // Your verification logic here
//     // ...
//     Ok(true) // Placeholder
// }
