use crate::ApiError;
use axum::{extract::State, Json};
use entity_handler::entity::prelude::*;
use entity_handler::entity::*;
use rayon::prelude::*;
use sea_orm::prelude::*;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Serialize, Deserialize)]
pub struct ReturnTicket {
    ticket_id: Uuid,
    seat_id: u32,
    train_id: Uuid,
    start_station: String,
    end_station: String,
    start_time: DateTime,
    end_time: DateTime,
    platform_nr: u32,
}

#[derive(Serialize, Deserialize)]
pub struct Arguments {
    user_id: Uuid,
}

pub async fn get_tickets(
    State(state): State<DatabaseConnection>,
    Json(user_id): Json<Arguments>,
) -> Result<Json<Vec<ReturnTicket>>, ApiError> {
    println!("/routes/all has been entered!");

    let tickets = Ticket::find()
        .filter(ticket::Column::PassengerId.eq(user_id.user_id))
        .all(&state)
        .await?;

    let mut seat: Vec<Seat> = Vec::new();

    for ticket in tickets.into_iter() {
        let seat = ticket.find_related(Seat).one(&state).await?.unwrap();
    }

    todo!()
}
// let tickets = Ticket::find()
//         .filter(<Ticket as EntityTrait>::Column::PassengerId.eq(user_id))
//         .all(&state)
//         .await?;

//     let mut return_tickets = Vec::new();

//     for ticket in tickets {
//         let seat = Seat::find_by_id((ticket.seat_id, ticket.train_id))
//             .one(&state)
//             .await?
//             .expect("Seat not found");

//         // Adjusting the join query
//         let destination = Destination::find()
//             .inner_join(Routes)
//             .filter(
//                 <Routes as EntityTrait>::Column::TrainId
//                     .eq(<Destination as EntityTrait>::Column::RoadmapId)
//                     .and(<Routes as EntityTrait>::Column::TrainId.eq(ticket.train_id)),
//             )
//             .one(&state)
//             .await?
//             .expect("Destination not found");

//         let roadmap = Roadmaps::find_by_id(destination.roadmap_id)
//             .one(&state)
//             .await?
//             .expect("Roadmap not found");

//         return_tickets.push(ReturnTicket {
//             ticket_id: ticket.passenger_id,
//             seat_id: Uuid::from_u128(seat.id as u128),
//             train_id: ticket.train_id,
//             start_station: destination.departure,
//             end_station: destination.arrival,
//             start_time: Utc::now(),
//             end_time: Utc::now() + chrono::Duration::minutes(roadmap.estimated_time.into()),
//             platform_nr: 1,
//             seat_nr: seat.id as u32,
//         });
//     }

//     Ok(Json(return_tickets))
// }
