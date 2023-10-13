use anyhow::Result;
use serde::{Deserialize, Serialize};
use serde_json::json;
use sqlx::{
    postgres::{PgPoolOptions, PgRow},
    Pool, Postgres,
};

pub struct UserHandler {
    database: Pool<Postgres>,
}

#[derive(Serialize)]
struct TokenRequest {
    client_id: String,
    client_secret: String,
    audience: String,
    grant_type: uuid::Uuid,
}

#[derive(Serialize, Deserialize)]
pub struct TokenResponse {
    access_token: String,
}

impl UserHandler {
    pub async fn new(connection: &str) -> Result<Self> {
        let database = PgPoolOptions::new().connect(connection).await?;

        Ok(Self { database })
    }

    pub async fn add_user(username: &str, password: &str) -> Result<()> {
        todo!()
    }

    pub async fn check_authentication(username: &str, password: &str) -> Result<()> {
        todo!()
    }
}

pub async fn obtain_token(user_id: uuid::Uuid) -> Result<TokenResponse> {
    let token_request = TokenRequest {
        client_id: "EQUvFoiKGWJDCZTz6TE0MaJJsWTNi6du".into(),
        client_secret: "DPXtJHdjFmGEgvDjtkt9ryGMO36HlWMdJxWorXLabnquLsWwfmneqgackt3nKo4u".into(),
        audience: "traveller".to_string(),
        grant_type: user_id,
    };

    let client = reqwest::Client::new();

    let res = client
        .post("https://dev-vtgjrzbo50ktq0do.us.auth0.com/oauth/token")
        .json(&token_request)
        .send()
        .await?;

    let token_response: TokenResponse = res.json().await?;

    Ok(token_response)
}
