-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
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
	Station_Id uuid references Stations(Id),
	Roadmap_Id uuid references Roadmaps(Id)
);


create table Routes (
	Id uuid primary key default uuid_generate_v4(),
	Destination_Id References Destinations(Id),
	Train_Id references Trains(Id)
);
