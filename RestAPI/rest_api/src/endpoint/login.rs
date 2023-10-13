use crate::ApiError;
use axum::{extract::State, Json};
use hyper::{Body, Client, Request};
use hyper_tls::HttpsConnector;
use sea_orm::DatabaseConnection;
use serde::{Deserialize, Serialize};
use serde_json::json;
use tokio::runtime::Runtime;
use user_handler::user_handler;

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
) -> Result<Json<user_handler::TokenResponse>, ApiError> {
    Ok(Json(user_handler::obtain_token(
        payload.email,
        payload.password,
    ))?)
}

// async fn verify_token(client: &Client, token: &str) -> Result<bool, reqwest::Error> {
//     // Your verification logic here
//     // ...
//     Ok(true) // Placeholder
// }
