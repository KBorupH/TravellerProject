create table Person(
	Id UUID primary key DEFAULT uuid_generate_v4(),
	Name Varchar(100) not null
);
create table Staff(
	Id UUID primary key Default uuid_generate_v4(),
	Person_id UUID,
	constraint fk_person
		foreign key(Person_id) 
			references Person(Id)	
);
create table Passenger(
	Id uuid primary key Default uuid_generate_v4(),
	Person_Id Default uuid_generate_v4(),
	constraint fk_person
		foreign key(Person_id) 
			references Person(Id)
);
create table Seat(
	Id uuid primary key default uuid_generate_v4(),
	Reserved bool,
);
create table Ticket(
	Passenger_Id uuid primary key Default uuid_generate_v4(),
	Seat_Id uuid primary key Default uuid_generate_v4(),
	constraint fk_person
		foreign key(Person_id) 
			references Person(Id)
	constraint fk_seat
		foreign key(Seat_id) 
			references Seat(Id)
);
create table Train(
	Id uuid primary key Default uuid_generate_v4(),
	Seat_Id uuid Default uuid_generate_v4(),
	Staff_Id uuid Default uuid_generate_v4(),
	constraint fk_Seat
		foreign key(Seat_Id) 
			references Seat(Id)
	constraint fk_Staff
		foreign key(Staff_id) 
			references Staff(Id)
	
);
