use anyhow::Result;

/// Sends and keeps track of all the notifications that we send to our clients.
pub struct MessageHandler {
    route_notifications: RouteNotifications,
    staff_credentials: StaffCredentials,
    passenger_credentials: PassengerCredentials,
}

impl MessageHandler {
    pub async fn new() -> Result<Self> {
        todo!()
    }

    pub async fn stream_database() {
        let config = deadpool_postgres::Config {
            user: Some("emil".into()),
            password: None,
            dbname: Some("postgres".into()),
            ..Default::default()
        };
        let pool = config.create_pool(None, tokio_postgres::NoTls).unwrap();

        // Get a client from the pool
        let mut client = pool.get().await.unwrap();

        // Set up LISTEN
        client
            .batch_execute("LISTEN route_changes; LISTEN staff_changes; LISTEN passenger_changes;")
            .await
            .unwrap();

        // Receive and process notifications
        loop {
            match client.prepare().recv().await {
                Ok(notification) => {
                    let payload: serde_json::Value =
                        serde_json::from_str(&notification.payload()).unwrap();
                    println!("{:#?}", payload);
                }
                Err(e) => eprintln!("notification error: {}", e),
            }
        }
    }
}

use chrono::{DateTime, Utc};
use uuid::Uuid;

#[derive(Debug)]
struct RouteNotifications {
    route_id: Uuid,
    last_notif_time: DateTime<Utc>,
}

#[derive(Debug)]
struct StaffCredentials {
    staff_id: Uuid,
    email: Vec<u8>,
    password: Vec<u8>,
    pass_salt: String,
}

#[derive(Debug)]
struct PassengerCredentials {
    passenger_id: Uuid,
    email: Vec<u8>,
    password: Vec<u8>,
    pass_salt: String,
}
