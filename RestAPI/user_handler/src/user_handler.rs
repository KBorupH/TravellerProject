use anyhow::Result;
use anyhow::Result;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

/// Sends and keeps track of all the notifications that we send to our clients.
pub struct UserHandler {
    route_notifications: RouteNotifications,
    staff_credentials: StaffCredentials,
    passenger_credentials: PassengerCredentials,
}

impl UserHandler {
    pub fn new() -> Result<Self> {
        pub async fn new(database_url: &str) -> Result<Self, sqlx::Error> {
            let pool = MySqlPool::connect(database_url).await?;
            Ok(Self { pool })
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct RouteNotifications {
    route_id: Uuid,
    last_notif_time: DateTime<Utc>,
}

#[derive(Debug, Serialize, Deserialize)]
struct StaffCredentials {
    staff_id: Uuid,
    email: Vec<u8>,
    password: Vec<u8>,
    pass_salt: String,
}

#[derive(Debug, Serialize, Deserialize)]
struct PassengerCredentials {
    passenger_id: Uuid,
    email: Vec<u8>,
    password: Vec<u8>,
    pass_salt: String,
}
