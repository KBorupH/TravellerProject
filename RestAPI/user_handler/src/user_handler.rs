use std::panic::catch_unwind;
use std::thread::Thread;
use anyhow::Result;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::migrate::MigrateDatabase;
use sqlx::{Pool, Sqlite, SqlitePool};
use uuid::Uuid;

use sqlx::sqlite::SqlitePoolOptions;

/// Sends and keeps track of all the notifications that we send to our clients.
pub struct UserHandler {
    sql_db: Pool<Sqlite>,
    route_notifications: RouteNotifications,
    staff_credentials: StaffCredentials,
    passenger_credentials: PassengerCredentials,
}

const DB_URL: &str = "sqlite://traveller_rest.db";

impl UserHandler {
    pub async fn new(database_url: &str) -> Result<Self, sqlx::Error> {
        if !Sqlite::database_exists(DB_URL).await.unwrap_or(false) {
            match Sqlite::create_database(DB_URL).await {
                Ok(_) => (),
                Err(error) => panic!("error: {}", error),
            }
        }
        Self.sql_db = SqlitePool::connect(DB_URL).await.unwrap();
        Ok(Self)
    }


    pub fn start_route_notifier() {
        //setup sqlx

            loop {
                //Continuosly check if a time on the route is getting close to current time.
                Thread::sleep(30000);
            }
            Sqlite::drop_database(DB_URL);

    }

    pub fn update_route_notifier() {
        //update sqlx
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
