pub mod entity;
use entity::prelude::*;
use sea_orm::{Linked, RelationDef, RelationTrait};

pub struct PassengerToDestination;

impl Linked for PassengerToDestination {
    type FromEntity = Passenger;
    type ToEntity = Destination;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::ticket::Relation::Passenger.def().rev(),
            entity::ticket::Relation::Seat.def(),
            entity::seat::Relation::Train.def(),
            entity::route::Relation::Train.def(),
            entity::route_destination::Relation::Route.def(),
            entity::route_destination::Relation::Destination.def(),
        ]
    }
}

pub struct PassengerToRoadmap;

impl Linked for PassengerToRoadmap {
    type FromEntity = Passenger;
    type ToEntity = Roadmap;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::ticket::Relation::Passenger.def().rev(),
            entity::ticket::Relation::Seat.def(),
            entity::seat::Relation::Train.def(),
            entity::route::Relation::Train.def(),
            entity::route_destination::Relation::Route.def(),
            entity::route_destination::Relation::Destination.def(),
            entity::destination::Relation::Roadmap.def(),
        ]
    }
}

pub struct PersonToRoute;

impl Linked for PersonToRoute {
    type FromEntity = Person;
    type ToEntity = Route;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::passenger::Relation::Person.def().rev(),
            entity::ticket::Relation::Passenger.def().rev(),
            entity::ticket::Relation::Seat.def(),
            entity::seat::Relation::Train.def(),
            entity::route::Relation::Train.def().rev(),
        ]
    }
}

pub struct PassengerToRoute;

impl Linked for PassengerToRoute {
    type FromEntity = Passenger;
    type ToEntity = Route;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::ticket::Relation::Passenger.def().rev(),
            entity::ticket::Relation::Seat.def(),
            entity::seat::Relation::Train.def(),
            entity::route::Relation::Train.def().rev(),
        ]
    }
}

pub struct RouteToRoadmap;

impl Linked for RouteToRoadmap {
    type FromEntity = Route;

    type ToEntity = Roadmap;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::route_destination::Relation::Route.def(),
            entity::route_destination::Relation::Destination.def(),
            entity::destination::Relation::Roadmap.def(),
        ]
    }
}

pub struct RouteDestinationToRoadmap;

impl Linked for RouteDestinationToRoadmap {
    type FromEntity = RouteDestination;

    type ToEntity = Roadmap;

    fn link(&self) -> Vec<RelationDef> {
        vec![
            entity::route_destination::Relation::Destination.def(),
            entity::destination::Relation::Roadmap.def(),
        ]
    }
}
