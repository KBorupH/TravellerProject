pub mod login;
pub mod register;
pub mod ticket;
pub mod train_route;

pub mod prelude {
    pub use super::login;
    pub use super::register;
    pub use super::ticket;
    pub use super::train_route;
}
