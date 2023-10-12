use std::panic::catch_unwind;
use std::thread::Thread;
use anyhow::Result;
use chrono::{DateTime, Duration, Local, Utc};
use serde::{Deserialize, Serialize};
use sqlx::migrate::MigrateDatabase;
use sqlx::{Pool, Sqlite, SqlitePool, PgPool, Postgres, Row};
use uuid::Uuid;

use sqlx::sqlite::SqlitePoolOptions;

/// Sends and keeps track of all the notifications that we send to our clients.
pub struct UserHandler {
    sq_lite_db: Pool<Sqlite>,
    sq_pg_traveller_db: Pool<Postgres>,
    sq_pg_traveller_op_db: Pool<Postgres>,
}

const SQLITE_DB_URL: &str = "sqlite://traveller_rest.db";
const PG_TRAVELLER_DB_URL: &str = "host=localhost user=postgres";
const PG_TOPERATION_DB_URL: &str = "host=localhost user=postgres";

impl UserHandler {
    async fn start_up() -> UserHandler {
        if !Sqlite::database_exists(SQLITE_DB_URL).await.unwrap_or(false) {
            match Sqlite::create_database(SQLITE_DB_URL).await {
                Ok(_) => (),
                Err(error) => panic!("error: {}", error),
            }
        }

        UserHandler {
            sq_lite_db: SqlitePool::connect(SQLITE_DB_URL).await.unwrap(),
            sq_pg_traveller_db: PgPool::connect(PG_TRAVELLER_DB_URL).await.unwrap(),
            sq_pg_traveller_op_db: PgPool::connect(PG_TOPERATION_DB_URL).await.unwrap(),
        }
    }

    async fn get_routes() -> Vec<Route> {
        let u_handler: UserHandler = UserHandler::start_up();
        let rows = sqlx::query("SELECT * FROM route").fetch_all(&u_handler.sq_lite_db).await?;
        rows
            .iter()
            .map(|r| Route::new(r.get::<uuid, _>("id"), DateTime::parse_from_str(&*r.get::<String, _>("departure_times"), "").into()))
            .collect()
    }

    fn get_destinations() -> Vec<Destination> {
        let u_handler: UserHandler;

        vec![]
    }

    async fn get_route_notifications(route_id: uuid) -> Vec<RouteNotification> {
        let u_handler: UserHandler = UserHandler::start_up();
        let rows = sqlx::query("SELECT * FROM route_notifications WHERE route_id = " + route_id).fetch_all(&u_handler.sq_lite_db).await?;
        rows
            .iter()
            .map(|r| Route::new(r.get::<uuid, _>("route_id"), DateTime::parse_from_str(&*r.get::<String, _>("last_notif_time"), "").into()))
            .collect()
    }

    async fn setup_sqlite() {
        //setup sqlx
        let u_handler: UserHandler = UserHandler::start_up();
        sqlx::query(
            r#"
CREATE TABLE IF NOT EXISTS route (
  id Uuid,
  departure_time DateTime<Utc>
);"#,
        )
            .execute(&u_handler.sq_lite_db)
            .await?;

        sqlx::query(
            r#"
CREATE TABLE IF NOT EXISTS route_notifications (
  route_id Uuid,
  last_notif_time DateTime<Utc>
);"#,
        )
            .execute(&u_handler.sq_lite_db)
            .await?;

        UserHandler::update_route_notifier().await;
    }


    pub async fn start_route_notifier() {
        UserHandler::setup_sqlite().await;
        loop {
            let routes = UserHandler::get_routes();

            for route in routes {
                let mut route_departure_state: RouteDepartureState;
                let mut route_last_notis_state: RouteLastNotisState;
                let departure_time: DateTime<Utc> = route.departure_times;
                let departure_time_left = departure_time - Utc::now();

                if departure_time_left.gt(&Duration::hours(1)) { continue; } else if departure_time_left.gt(&Duration::minutes(45)) { route_departure_state = RouteDepartureState::Under60Min } else if departure_time_left.gt(&Duration::minutes(30)) { route_departure_state = RouteDepartureState::Under45Min } else if departure_time_left.gt(&Duration::minutes(15)) { route_departure_state = RouteDepartureState::Under30Min } else if departure_time_left.gt(&Duration::minutes(0)) { route_departure_state = RouteDepartureState::Under15Min }


                //for destination in (get all Destination connected to route.id)
                // For now just the first destination
                let mut route_notis: RouteNotification = UserHandler::get_route_notifications(route.id).next().into();

                let notis_time: DateTime<Utc> = route_notis.last_notif_time;
                let notis_time_left = notis_time - Utc::now();
                if notis_time_left.gt(&Duration::minutes(5)) { route_last_notis_state = RouteLastNotisState::Over10Min } else if notis_time_left.gt(&Duration::minutes(1)) { route_last_notis_state = RouteLastNotisState::Over5Min } else if notis_time_left.gt(&Duration::minutes(30)) { route_last_notis_state = RouteLastNotisState::Over1Min } else if notis_time_left.gt(&Duration::seconds(5)) { route_last_notis_state = RouteLastNotisState::Over30Sec } else if notis_time_left.lt(&Duration::seconds(5)) { continue; }

                match route_departure_state {
                    RouteDepartureState::Under60Min => {
                        if route_last_notis_state == RouteLastNotisState::Over10Min {
                            UserHandler::notify_users().await;
                            //Update sqlite and DB with new notification time
                        }
                    }
                    RouteDepartureState::Under45Min => {
                        if route_last_notis_state >= RouteLastNotisState::Over5Min {
                            UserHandler::notify_users().await;
                            //Update sqlite and DB with new notification time
                        }
                    }
                    RouteDepartureState::Under30Min => {
                        if route_last_notis_state >= RouteLastNotisState::Over1Min {
                            UserHandler::notify_users().await;
                            //Update sqlite and DB with new notification time
                        }
                    }
                    RouteDepartureState::Under15Min => {
                        if route_last_notis_state >= RouteLastNotisState::Over30Sec {
                            UserHandler::notify_users().await;
                            //Update sqlite and DB with new notification time
                        }
                    }
                }
            }


            Thread::sleep(30000);
        }
        // Sqlite::drop_database(DB_URL);
    }

    pub async fn update_route_notifier() {
        //update sqlx
        let u_handler: UserHandler = UserHandler::start_up();

        let routeRows = sqlx::query("SELECT * FROM route").fetch_all(&u_handler.sq_pg_traveller_db).await?;
        let routes: Vec<Route> = routeRows
            .iter()
            .map(|r| Route::new(r.get::<uuid, _>("id"), *r.get::<DateTime<Utc>, _>("departure_time").into()))
            .collect();

        for route in routes {
            //map to get correct values
            sqlx::query_as("insert into route (id, departure_time) values ($1, $2)")
                .bind(route.id)
                .bind(route.departure_time)
                .await?;
        }


        let routeNotisRows = sqlx::query("SELECT * FROM route_notification").fetch_all(&u_handler.sq_pg_traveller_op_db).await?;
        let route_notis: Vec<RouteNotification> = routeNotisRows
            .iter()
            .map(|r| Route::new(r.get::<uuid, _>("route_id"), *r.get::<DateTime<Utc>, _>("last_notif_time").into()))
            .collect();

        for notis in route_notis {
            sqlx::query_as("insert into route_notifications (route_id, last_notif_time) values ($1, $2)")
                .bind(notis.route_id)
                .bind(notis.last_notif_time)
                .await?;
        }
    }

    async fn notify_users() {
        let client = fcm::Client::new();

        let mut notification_builder = fcm::NotificationBuilder::new();
        notification_builder.title("TitleFromRest");
        notification_builder.body("BodyFromRest");

        let notification = notification_builder.finalize();
        let mut message_builder = fcm::MessageBuilder::new("AIzaSyCW6s_zYH-4imptp_JNxitdJll7kA_3uB4", "from the printed get token in flutter");
        message_builder.notification(notification);

        client.send(message_builder.finalize()).await?;
    }
}

enum RouteDepartureState {
    Under60Min,
    Under45Min,
    Under30Min,
    Under15Min,
}

enum RouteLastNotisState {
    Over10Min,
    Over5Min,
    Over1Min,
    Over30Sec,
}

#[derive(Debug, Serialize, Deserialize)]
struct Route {
    id: Uuid,
    //RouteDestination id -> Departure times
    departure_time: DateTime<Utc>,
}

impl Route {
    pub fn new(id: Uuid, time: DateTime<Utc>) -> Self {
        Self.id = id;
        Self.departure_time = time;
        Self
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct RouteNotification {
    route_id: Uuid,
    last_notif_time: DateTime<Utc>,
}

#[derive(Debug, Serialize, Deserialize)]
struct Destination {
    id: Uuid,
    roadmap_id: Uuid,
    departure: str,
    arrival: str,
}
