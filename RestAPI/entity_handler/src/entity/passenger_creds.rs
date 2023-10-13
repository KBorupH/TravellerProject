//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.2

use sea_orm::entity::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq, Serialize, Deserialize)]
#[sea_orm(table_name = "passenger_creds")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub passenger_id: Uuid,
    #[sea_orm(column_type = "Binary(BlobSize::Blob(None))", nullable)]
    pub email: Option<Vec<u8>>,
    #[sea_orm(column_type = "Binary(BlobSize::Blob(None))", nullable)]
    pub password: Option<Vec<u8>>,
    #[sea_orm(column_type = "Binary(BlobSize::Blob(None))", nullable)]
    pub pass_salt: Option<Vec<u8>>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {
    #[sea_orm(
        belongs_to = "super::passenger::Entity",
        from = "Column::PassengerId",
        to = "super::passenger::Column::Id",
        on_update = "NoAction",
        on_delete = "NoAction"
    )]
    Passenger,
}

impl Related<super::passenger::Entity> for Entity {
    fn to() -> RelationDef {
        Relation::Passenger.def()
    }
}

impl ActiveModelBehavior for ActiveModel {}