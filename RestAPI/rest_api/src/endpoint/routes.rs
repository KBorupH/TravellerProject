use anyhow::anyhow;
use axum::{extract::State, Json};
use entity_handler::{entity::prelude::*, RouteDestinationToRoadmap};
use itertools::Itertools;
use sea_orm::prelude::*;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::ApiError;

#[derive(Serialize)]
pub struct ReturnRoute {
    id: Uuid,
    start_station: Uuid,
    end_station: Uuid,
    start_time: DateTime,
    end_time: DateTime,
}

#[derive(Deserialize)]
pub struct Arguments {
    passenger_id: Uuid,
}
pub async fn get_routes(
    State(state): State<DatabaseConnection>,
    Json(payload): Json<Arguments>,
) -> Result<Json<Vec<ReturnRoute>>, ApiError> {
    println!("/routes/all has been entered!");

    let Some(passenger) = Passenger::find_by_id(payload.passenger_id)
        .one(&state)
        .await?
    else {
        return Err(ApiError(anyhow!(
            "Could not find you in the list of passengers."
        )));
    };

    let mut return_routes: Vec<ReturnRoute> = Vec::new();

    for route in passenger
        .find_linked(entity_handler::PassengerToRoute)
        .all(&state)
        .await?
        .iter()
    {
        let route_destinations = route.find_related(RouteDestination).all(&state).await?;

        let (first, last) = route_destinations
            .iter()
            .minmax_by(|a, b| {
                a.destination_order
                    .partial_cmp(&b.destination_order)
                    .unwrap()
            })
            .into_option()
            .unwrap();

        let first_id = first
            .find_linked(RouteDestinationToRoadmap)
            .one(&state)
            .await?
            .unwrap()
            .origin_id;

        let last_id = last
            .find_linked(RouteDestinationToRoadmap)
            .one(&state)
            .await?
            .unwrap()
            .destination_id;

        let first = first.find_related(Destination).one(&state).await?.unwrap();

        let last = last.find_related(Destination).one(&state).await?.unwrap();

        return_routes.push(ReturnRoute {
            id: route.id,
            start_station: first_id,
            end_station: last_id,
            start_time: first.departure,
            end_time: last.arrival,
        })
    }

    Ok(Json(return_routes))
}
