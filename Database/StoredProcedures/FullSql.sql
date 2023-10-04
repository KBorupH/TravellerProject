CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create table Person(
	Id UUID primary key DEFAULT uuid_generate_v4(),
	Name Varchar(100) not null,
	Email Bytea not null,
	Password bytea not null
);

create table Staff(
	Id UUID primary key Default uuid_generate_v4(),
	Person_id UUID,
	constraint FK_person_Id
		foreign key(Person_id) 
			references Person(Id)	
);
create table Passenger(
	Id uuid primary key Default uuid_generate_v4(),
	Person_Id uuid,
	constraint FK_person_Id
		foreign key(Person_id) 
			references Person(Id)
);
create table Seat(
	Id uuid primary key default uuid_generate_v4(),
	Reserved bool
);
create table Ticket(
	Passenger_Id uuid ,
	Seat_Id uuid ,
	constraint PK_Ticket primary key(Passenger_Id, Seat_Id),
	constraint FK_Ticket_Passenger foreign key (Passenger_Id) references Passenger(Id),
	constraint FK_Ticket_Seat foreign key (Seat_Id) references Seat(Id)
);
	
create table Trains(
	Id uuid primary key Default uuid_generate_v4(),
	Seat_Id uuid ,
	Staff_Id uuid ,
	constraint FK_Seat_Id
		foreign key(Seat_Id) 
			references Seat(Id),
	constraint FK_Staff_Id
		foreign key(Staff_id) 
			references Staff(Id)
);


create table stations (
	Id uuid primary key default uuid_generate_v4(),
	Name varchar(255) not null,
	Platforms int not null
);

create table Roadmaps (
	Id uuid primary key default uuid_generate_v4(),
	Destination varchar(255) not null,
	Start varchar(255) not null,
	Estimated_Time interval not null
);

create table Destinations (
	Id uuid primary key default uuid_generate_v4(),
	Departure varchar(255) not null,
	Arrival varchar(255) not null,
	Station_Id uuid not null,
	Roadmap_Id uuid not null ,
	constraint FK_Station_Id 
		foreign key (Station_Id)
			references Stations(Id),
	constraint FK_Roadmap_Id 
		foreign key (Roadmap_Id) 
			references Roadmaps(Id)
);


create table Routes (
	Id uuid primary key default uuid_generate_v4(),
	Destination_Id uuid references Destinations(Id),
	Train_Id uuid not null,
	constraint FK_Train_Id
		foreign key (Train_Id) 
			references Trains(Id)
);

--drop table trains, ticket, stations, staff, seat, routes, roadmaps, person, passenger, destinations
