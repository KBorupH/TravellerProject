use uuid::Uuid;

pub struct TrainRoute {
    id: uuid::Uuid,
    start_station: Uuid,
}
