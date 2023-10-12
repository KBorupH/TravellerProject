CREATE EXTENSION IF NOT EXISTS "UUID-ossp";

CREATE TABLE person(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL
);

CREATE TABLE staff(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID,
    CONSTRAINT fk_person_id
        FOREIGN KEY(person_id) 
            REFERENCES person(id)    
);

CREATE TABLE passenger(
    id UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID NOT NULL,
    CONSTRAINT fk_person_id
        FOREIGN KEY(person_id) 
            REFERENCES person(id)
);

CREATE TABLE train(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4()
);

CREATE TABLE seat(
    id SERIAL NOT NULL,
    train_id UUID NOT NULL,
    reserved BOOL NOT NULL,
    CONSTRAINT pk_seat 
		PRIMARY KEY (id, train_id),
    CONSTRAINT fk_seat_train_id 
		FOREIGN KEY (train_id) 
			REFERENCES train(id)
);

CREATE TABLE ticket (
    passenger_id UUID,
    seat_id SERIAL,
    train_id UUID,
     CONSTRAINT pk_ticket 
        PRIMARY KEY (passenger_id, seat_id, train_id),
    CONSTRAINT fk_ticket_passenger 
        FOREIGN KEY (passenger_id)
            REFERENCES passenger("id"),
    CONSTRAINT fk_ticket_seat FOREIGN KEY (seat_id, train_id) 
        REFERENCES seat("id", train_id)
);

CREATE TABLE station (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    platforms int NOT NULL
);

CREATE TABLE roadmap (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    origin_id UUID NOT NULL,
    destination_id UUID NOT NULL,
    estimated_time integer NOT NULL,
	CONSTRAINT fk_origin_station_id
        FOREIGN KEY (origin_id)
            REFERENCES station(id),
    CONSTRAINT fk_destination_station_id
        FOREIGN KEY (destination_id) 
            REFERENCES station(id)
);

CREATE TABLE destination (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    departure timestamp  NOT NULL,
    arrival timestamp  NOT NULL,
    roadmap_id UUID NOT NULL,
    CONSTRAINT fk_roadmap_id 
        FOREIGN KEY (roadmap_id) 
            REFERENCES roadmap(id)
);

CREATE TABLE route (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    train_id UUID NOT NULL,
    CONSTRAINT fk_train_id
        FOREIGN KEY (train_id) 
            REFERENCES train(id)
);

CREATE TABLE route_destination(
    route_id UUID NOT NULL,
    destination_id UUID NOT NULL,
	destination_order real NOT NULL,
    CONSTRAINT pk_route_destination 
		PRIMARY KEY (route_id, destination_id),
    CONSTRAINT fk_route_destination_route 
		FOREIGN KEY (route_id) 
			REFERENCES route(id),
    CONSTRAINT fk_route_destination_destination 
		FOREIGN KEY (destination_id) 
			REFERENCES destination(id)
);

CREATE TABLE assigned_staff (
    train_id UUID NOT NULL,
    staff_id UUID NOT NULL,
    CONSTRAINT pk_assigned_staff 
		PRIMARY KEY (train_id, staff_id),
    CONSTRAINT fk_assigned_staff_train 
		FOREIGN KEY (train_id) 
			REFERENCES train(id),
    CONSTRAINT fk_assigned_staff_staff 
		FOREIGN KEY (staff_id) 
			REFERENCES staff(id)
);

CREATE TABLE route_notification(
    route_id UUID,
    last_notis_time timestamp,
	
	CONSTRAINT pk_route_notification
		PRIMARY KEY (route_id),
	CONSTRAINT fk_route_id
		FOREIGN KEY (route_id)
			REFERENCES route(id)
);


CREATE TABLE staff_creds(
    staff_id UUID,
    email bytea,
    password bytea,
    pass_salt bytea,
	
	CONSTRAINT pk_staff_creds
		PRIMARY KEY (staff_id),
	CONSTRAINT fk_staff_id
		FOREIGN KEY (staff_id)
			REFERENCES staff(id)
);

CREATE TABLE passenger_creds(
    passenger_id UUID,
    email bytea,
    password bytea,
    pass_salt bytea,
	
	CONSTRAINT pk_passenger_creds
		PRIMARY KEY (passenger_id),
	CONSTRAINT fk_passenger_id
		FOREIGN KEY (passenger_id)
			REFERENCES passenger(id)
);

create procedure NewPerson(_name VarChar(100))
LANGUAGE SQL
        AS $$
INSERT INTO person(name)
        VALUES(_name);
        $$;

create procedure NewStation(_name VarChar(255), _platforms Int)
LANGUAGE SQL
        AS $$
INSERT INTO station(name, platforms)
        VALUES(_name, _platforms);
        $$;

create procedure NewRoadmap(_destination_id uuid, _origin_id uuid, _estimated_time integer)
LANGUAGE SQL
        AS $$
INSERT INTO roadmap(destination_id, origin_id, estimated_time)
        VALUES(_destination_id, _origin_id, _estimated_time);
        $$;

create procedure NewPassenger(_id uuid)
LANGUAGE SQL
        AS $$
INSERT INTO passenger(person_id) SELECT "id" FROM person WHERE ("id" = _id);
        $$;

create procedure NewStaff(_id uuid)
LANGUAGE SQL
        AS $$
INSERT INTO staff(person_id) SELECT "id" FROM person WHERE ("id" = _id);
        $$;

create procedure UpdateStaffNameById(_id UUID, _name VarChar(100))
LANGUAGE SQL
        AS $$
UPDATE
person
set name = _name
FROM staff
WHERE (staff.id = _id
AND person.id = staff.person_id) ;
        $$;

create procedure DeleteStaffNameById(_id UUID)
LANGUAGE SQL
        AS $$
DELETE
FROM staff
WHERE (staff.id = _id) ;
        $$;


--Route
----route_id
----train_id

--StationStart
----station_start_id
----station_start_name
----station_start_platforms
----station_start_departure

--StationEnd
----station_end_id
----station_end_name
----station_end_platforms
----station_end_arrival

create or replace view view_route_destinations as
	select 	r.id as route_id,
			r.train_id,
			s_orig.id as station_id,
			s_orig.name as station_name, 
			s_orig.platforms as station_platforms
				from route_destination rd 
					join route r on rd.route_id = r.id
					join destination d on rd.destination_id = d.id
					join roadmap rm on d.roadmap_id = rm.id
					join station s_orig on rm.origin_id = s_orig.id;


-- Create a function that calls the view and returns the result
DROP FUNCTION IF EXISTS list_route_destinations();

CREATE FUNCTION list_route_destinations()
	RETURNS TABLE (
		route_id UUID,
		train_id UUID,
		station_id UUID,
		station_name VARCHAR(255),
		station_platforms INT) 
	AS 
	$func$
		SELECT * FROM view_route_destinations;
	$func$ 
	LANGUAGE SQL;

CREATE FUNCTION FindStaffByName(_name VarChar(100))
	RETURNS TABLE (person_name VarChar, staff_id uuid)
    AS 
	$func$
		SELECT person.name, staff.id
			FROM person, staff
			WHERE ("name" = _name) 
			AND (staff.person_id = person.id);
	$func$
	LANGUAGE SQL;

CREATE FUNCTION GetStaff()
	RETURNS TABLE (person_name VarChar, staff_id uuid)
    AS 
	$func$
		SELECT person.name, staff.id
			FROM person, staff
			WHERE (staff.person_id = person.id);
    $func$
	LANGUAGE SQL;

CREATE FUNCTION GetStaffCount()
	RETURNS INTEGER
    AS 
	$func$
		SELECT COUNT(*)
			FROM staff;
    $func$
	LANGUAGE SQL;

CREATE FUNCTION GetPassengersCount()
	RETURNS INTEGER
    AS 
	$func$
		SELECT COUNT(*)
			FROM passenger;
    $func$
	LANGUAGE SQL;

CREATE FUNCTION GetTicketsCount()
	RETURNS INTEGER
    AS 
	$func$
		SELECT COUNT(*)
			FROM ticket;
    $func$
	LANGUAGE SQL;

CREATE FUNCTION GetTrainsCount()
	RETURNS INTEGER
    AS 
	$func$
		SELECT COUNT(*)
			FROM train;
    $func$
	LANGUAGE SQL;

-- CREATE FUNCTION GetPassengers()
-- 		RETURNS TABLE (passenger_id uuid)
--         AS 
-- 		$func$
-- 			SELECT person_id FROM passenger;
--         $func$
-- 		LANGUAGE SQL;

-- CREATE FUNCTION GetTickets()
-- 		RETURNS TABLE ()
--         AS 
-- 		$func$
-- 			SELECT * FROM ticket;
--         $func$
-- 		LANGUAGE SQL;

-- CREATE FUNCTION GetTrains()
--         AS 
-- 		$func$
-- 			SELECT * FROM train;
--         $func$
-- 		LANGUAGE SQL;



-- Inserting sample data

-- Person
INSERT INTO person (name) VALUES 
('John Doe'),
('Jane Smith'),
('Michael Johnson'),
('Emily Davis'),
('Robert Taylor'),
('Anders Jensen'), 
('Frederik Mortensen'), 
('Mathilde Nielsen'), 
('Sofie Larsen'), 
('Mikkel Christensen'), 
('Amalie Pedersen'), 
('Oscar Hansen');

-- Staff
INSERT INTO staff (person_id) SELECT id FROM person WHERE name IN ('Anders Jensen', 'Frederik Mortensen', 'John Doe', 'Jane Smith');

-- Passenger
INSERT INTO passenger (person_id) SELECT id FROM person WHERE name IN ('Mathilde Nielsen', 'Sofie Larsen', 'Mikkel Christensen', 'Amalie Pedersen', 'Oscar Hansen', 'Michael Johnson', 'Emily Davis', 'Robert Taylor');

-- Train
INSERT INTO train DEFAULT VALUES;
INSERT INTO train DEFAULT VALUES;
INSERT INTO train DEFAULT VALUES;
INSERT INTO train DEFAULT VALUES;

-- Seat
INSERT INTO seat (train_id, reserved) VALUES 
((SELECT id FROM train LIMIT 1 OFFSET 0), false), 
((SELECT id FROM train LIMIT 1 OFFSET 0), true), 
((SELECT id FROM train LIMIT 1 OFFSET 0), false), 
((SELECT id FROM train LIMIT 1 OFFSET 1), false), 
((SELECT id FROM train LIMIT 1 OFFSET 1), true),
((SELECT id FROM train LIMIT 1 OFFSET 2), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 2), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 3), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 3), FALSE);

-- Ticket
INSERT INTO ticket (passenger_id, seat_id, train_id) VALUES 
((SELECT id FROM passenger WHERE person_id = (SELECT id FROM person WHERE name = 'Mathilde Nielsen')), (SELECT id FROM seat LIMIT 1 OFFSET 0), (SELECT id FROM train LIMIT 1 OFFSET 0)), 
((SELECT id FROM passenger WHERE person_id = (SELECT id FROM person WHERE name = 'Sofie Larsen')), (SELECT id FROM seat LIMIT 1 OFFSET 1), (SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM passenger WHERE person_id = (SELECT id FROM person WHERE name = 'Michael Johnson')), (SELECT id FROM seat LIMIT 1 OFFSET 2), (SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM passenger WHERE person_id = (SELECT id FROM person WHERE name = 'Emily Davis')), (SELECT id FROM seat LIMIT 1 OFFSET 3), (SELECT id FROM train LIMIT 1 OFFSET 1)),
((SELECT id FROM passenger WHERE person_id = (SELECT id FROM person WHERE name = 'Robert Taylor')), (SELECT id FROM seat LIMIT 1 OFFSET 5), (SELECT id FROM train LIMIT 1 OFFSET 2));

-- Station
																INSERT INTO station (name, platforms) VALUES 
																('København H', 15), 
																('Aarhus St.', 10), 
																('Odense St.', 8), 
																('Aalborg St.', 7), 
																('Esbjerg St.', 5),
																('Ringsted St.', 3),
																('Køge St.', 4);

-- Roadmap
INSERT INTO roadmap (origin_id, destination_id, estimated_time) VALUES 
((SELECT id FROM station WHERE name = 'København H'), (SELECT id FROM station WHERE name = 'Aarhus St.'), 10800), 
((SELECT id FROM station WHERE name = 'Aarhus St.'), (SELECT id FROM station WHERE name = 'Odense St.'), 5400),
((SELECT id FROM station WHERE name = 'Ringsted St.'), (SELECT id FROM station WHERE name = 'Køge St.'), 5400),
((SELECT id FROM station WHERE name = 'Odense St.'), (SELECT id FROM station WHERE name = 'Ringsted St.'), 4300),
((SELECT id FROM station WHERE name = 'Køge St.'), (SELECT id FROM station WHERE name = 'København H'), 3360);

-- Destination
INSERT INTO destination (departure, arrival, roadmap_id) VALUES 
('2023-11-15 08:00:00', '2023-11-15 11:00:00', (SELECT id FROM roadmap WHERE origin_id = (SELECT id FROM station WHERE name = 'København H') AND destination_id = (SELECT id FROM station WHERE name = 'Aarhus St.'))), 
('2023-11-15 12:00:00', '2023-11-15 13:30:00', (SELECT id FROM roadmap WHERE origin_id = (SELECT id FROM station WHERE name = 'Aarhus St.') AND destination_id = (SELECT id FROM station WHERE name = 'Odense St.'))),
('2023-10-15 08:00:00', '2023-10-15 09:30:00', (SELECT id FROM roadmap WHERE origin_id = (SELECT id FROM station WHERE name = 'Odense St.') AND destination_id = (SELECT id FROM station WHERE name = 'Ringsted St.'))),
('2023-10-15 10:00:00', '2023-10-15 10:45:00', (SELECT id FROM roadmap WHERE origin_id = (SELECT id FROM station WHERE name = 'Ringsted St.') AND destination_id = (SELECT id FROM station WHERE name = 'Køge St.'))),
('2023-10-15 10:00:00', '2023-10-15 10:45:00', (SELECT id FROM roadmap WHERE origin_id = (SELECT id FROM station WHERE name = 'Køge St.') AND destination_id = (SELECT id FROM station WHERE name = 'København H')));

-- Route
INSERT INTO route (train_id) VALUES 
((SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM train LIMIT 1 OFFSET 1)),
((SELECT id FROM train LIMIT 1 OFFSET 2));

-- Route Destination
INSERT INTO route_destination (route_id, destination_id, destination_order) VALUES 
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 1), 1.0), 
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 2), 2.0),
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 3), 3.0), 
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 4), 4.0), 
((SELECT id FROM route LIMIT 1 OFFSET 1), (SELECT id FROM destination LIMIT 1 OFFSET 0), 1.0), 
((SELECT id FROM route LIMIT 1 OFFSET 1), (SELECT id FROM destination LIMIT 1 OFFSET 2), 2.0);

-- Assigned Staff
INSERT INTO assigned_staff (train_id, staff_id) VALUES 
((SELECT id FROM train LIMIT 1 OFFSET 0), (SELECT id FROM staff WHERE person_id = (SELECT id FROM person WHERE name = 'Anders Jensen'))), 
((SELECT id FROM train LIMIT 1 OFFSET 0), (SELECT id FROM staff WHERE person_id = (SELECT id FROM person WHERE name = 'Frederik Mortensen'))),
((SELECT id FROM train LIMIT 1 OFFSET 0), (SELECT id FROM staff WHERE person_id = (SELECT id FROM person WHERE name = 'John Doe'))),
((SELECT id FROM train LIMIT 1 OFFSET 1), (SELECT id FROM staff WHERE person_id = (SELECT id FROM person WHERE name = 'Jane Smith')));