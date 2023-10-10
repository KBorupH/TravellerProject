use std::panic::catch_unwind;
use std::thread::Thread;
use anyhow::Result;
use chrono::{DateTime, Duration, Local, Utc};
use serde::{Deserialize, Serialize};
use sqlx::migrate::MigrateDatabase;
use sqlx::{Pool, Sqlite, SqlitePool};
use uuid::Uuid;

use sqlx::sqlite::SqlitePoolOptions;

/// Sends and keeps track of all the notifications that we send to our clients.
pub struct UserHandler {
    sql_db: Pool<Sqlite>,
    routes: Route,
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
        //get and save all routes
        //get and save all routeNotifications

        let newid = Uuid::parse_str("a1a2a3a4b1b2c1c2d1d2d3d4d5d6d7d8")?;
        Self.routes : [Route; 1] = [Route::new(newid, Utc::now())];

        loop {
            //Continuosly check if a time on the route is getting close to current time.

            //Check if stored routes has a depature soon
            for route in Self.routes {
                let mut route_departure_state: RouteDepartureState;
                let mut route_last_notis_state: RouteLastNotisState;
                let departure_time: DateTime<Utc> = route.departure_times;
                let departure_time_left = departure_time - Utc::now();

                if departure_time_left.gt(&Duration::hours(1)) { continue }
                else if departure_time_left.gt(&Duration::minutes(45)) { route_departure_state = RouteDepartureState::Under60Min }
                else if departure_time_left.gt(&Duration::minutes(30)) { route_departure_state = RouteDepartureState::Under45Min }
                else if departure_time_left.gt(&Duration::minutes(15)) { route_departure_state = RouteDepartureState::Under30Min }
                else if departure_time_left.gt(&Duration::minutes(0)) { route_departure_state = RouteDepartureState::Under15Min }

                if Self.route_notifications.route_id == route.id {
                    let notis_time: DateTime<Utc> = Self.route_notifications.last_notif_time;
                    let notis_time_left = notis_time - Utc::now();
                    if notis_time_left.gt(&Duration::minutes(5)) { route_last_notis_state = RouteLastNotisState::Over10Min }
                    else if notis_time_left.gt(&Duration::minutes(1)) { route_last_notis_state = RouteLastNotisState::Over5Min }
                    else if notis_time_left.gt(&Duration::minutes(30)) { route_last_notis_state = RouteLastNotisState::Over1Min }
                    else if notis_time_left.gt(&Duration::seconds(0)) { route_last_notis_state = RouteLastNotisState::Over30Sec }
                    else if notis_time_left.lt(&Duration::seconds(0))
                }


                match route_departure_state  {
                    RouteDepartureState::Under60Min => {if route_last_notis_state == RouteLastNotisState::Over10Min {
                        //Notify
                        //Update sqlite and DB with new notification time
                    }}
                    RouteDepartureState::Under45Min => {if route_last_notis_state >= RouteLastNotisState::Over5Min {
                        //Notify
                        //Update sqlite and DB with new notification time
                    }}
                    RouteDepartureState::Under30Min => {if route_last_notis_state >= RouteLastNotisState::Over1Min {
                        //Notify
                        //Update sqlite and DB with new notification time
                    }}
                    RouteDepartureState::Under15Min => {if route_last_notis_state >= RouteLastNotisState::Over30Sec {
                        //Notify
                        //Update sqlite and DB with new notification time
                    }}
                }
            }


            Thread::sleep(30000);
        }
        Sqlite::drop_database(DB_URL);
    }

    pub fn update_route_notifier() {
        //update sqlx
    }

    async fn notify_users() {
        let client = fcm::Client::new();

        let mut notification_builder = fcm::NotificationBuilder::new();
        notification_builder.title("TitleFromRest");
        notification_builder.body("BodyFromRest");

        let notification = notification_builder.finalize();
        let mut message_builder = fcm::MessageBuilder::new("<FCM API Key>", "<registration id>");
        message_builder.notification(notification);

        let response = client.send(message_builder.finalize()).await?;
        println!("Sent: {:?}", response);
    }
}

enum RouteDepartureState {
    Under60Min,
    Under45Min,
    Under30Min,
    Under15Min
}

enum RouteLastNotisState {
    Over10Min,
    Over5Min,
    Over1Min,
    Over30Sec
}

#[derive(Debug, Serialize, Deserialize)]
struct Route {
    id: Uuid,
    //RouteDestination id -> Departure times
    departure_times: DateTime<Utc>,
}

impl Route {
    pub fn new(id: Uuid, time: DateTime<Utc>) -> Self {
        Self.id = id;
        Self.departure_times = time;
        Self
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
