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