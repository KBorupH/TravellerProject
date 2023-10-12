-- Inserting data into the station table
INSERT INTO station (name, platforms)
VALUES
('København H', 7),
('Helsingør', 5),
('Roskilde', 4),
('Odense', 6),
('Aarhus', 5),
('Aalborg', 4),
('Esbjerg', 3),
('Vejle', 3);

-- Inserting data into the person table
INSERT INTO person (name)
VALUES
('Anders Jensen'),
('Birthe Larsen'),
('Carsten Nielsen'),
('Dorte Poulsen'),
('Erik Mortensen'),
('Freja Christensen'),
('Gert Pedersen'),
('Helle Hansen');

-- Inserting data into the staff table
INSERT INTO staff (person_id)
VALUES
((SELECT id FROM person WHERE name = 'Anders Jensen')),
((SELECT id FROM person WHERE name = 'Birthe Larsen')),
((SELECT id FROM person WHERE name = 'Carsten Nielsen')),
((SELECT id FROM person WHERE name = 'Dorte Poulsen'));

-- Inserting data into the passenger table
INSERT INTO passenger (person_id)
VALUES
((SELECT id FROM person WHERE name = 'Erik Mortensen')),
((SELECT id FROM person WHERE name = 'Freja Christensen')),
((SELECT id FROM person WHERE name = 'Gert Pedersen')),
((SELECT id FROM person WHERE name = 'Helle Hansen'));

-- Inserting data into the train table
INSERT INTO train DEFAULT VALUES;
INSERT INTO train DEFAULT VALUES;
INSERT INTO train DEFAULT VALUES;

-- Inserting data into the seat table
INSERT INTO seat (train_id, reserved)
VALUES
((SELECT id FROM train LIMIT 1 OFFSET 0), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 0), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 0), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 1), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 1), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 1), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 2), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 2), FALSE),
((SELECT id FROM train LIMIT 1 OFFSET 2), FALSE);

-- Inserting data into the roadmap table
INSERT INTO roadmap (origin_id, destination_id, estimated_time)
VALUES
((SELECT id FROM station WHERE name = 'København H'), (SELECT id FROM station WHERE name = 'Roskilde'), 30),
((SELECT id FROM station WHERE name = 'Roskilde'), (SELECT id FROM station WHERE name = 'Odense'), 45),
((SELECT id FROM station WHERE name = 'Odense'), (SELECT id FROM station WHERE name = 'Aarhus'), 60),
((SELECT id FROM station WHERE name = 'Aarhus'), (SELECT id FROM station WHERE name = 'Aalborg'), 50);

-- Inserting data into the destination table
INSERT INTO destination (departure, arrival, roadmap_id)
VALUES
('2023-11-01 08:00:00', '2023-11-01 08:30:00', (SELECT id FROM roadmap LIMIT 1 OFFSET 0)),
('2023-11-01 09:00:00', '2023-11-01 09:45:00', (SELECT id FROM roadmap LIMIT 1 OFFSET 1)),
('2023-11-01 10:00:00', '2023-11-01 11:00:00', (SELECT id FROM roadmap LIMIT 1 OFFSET 2)),
('2023-11-01 12:00:00', '2023-11-01 12:50:00', (SELECT id FROM roadmap LIMIT 1 OFFSET 3));

-- Inserting data into the route table
INSERT INTO route (train_id)
VALUES
((SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM train LIMIT 1 OFFSET 1)),
((SELECT id FROM train LIMIT 1 OFFSET 2));

-- Inserting data into the route_destination table
INSERT INTO route_destination (route_id, destination_id, destination_order)
VALUES
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 0), 1),
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 1), 2),
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 2), 3),
((SELECT id FROM route LIMIT 1 OFFSET 0), (SELECT id FROM destination LIMIT 1 OFFSET 3), 4),
((SELECT id FROM route LIMIT 1 OFFSET 1), (SELECT id FROM destination LIMIT 1 OFFSET 0), 1),
((SELECT id FROM route LIMIT 1 OFFSET 1), (SELECT id FROM destination LIMIT 1 OFFSET 1), 2),
((SELECT id FROM route LIMIT 1 OFFSET 1), (SELECT id FROM destination LIMIT 1 OFFSET 2), 3),
((SELECT id FROM route LIMIT 1 OFFSET 2), (SELECT id FROM destination LIMIT 1 OFFSET 0), 1),
((SELECT id FROM route LIMIT 1 OFFSET 2), (SELECT id FROM destination LIMIT 1 OFFSET 3), 2);

-- Correcting the insertion data for the ticket table
INSERT INTO ticket (passenger_id, seat_id, train_id)
VALUES
((SELECT id FROM passenger LIMIT 1 OFFSET 0), 1, (SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM passenger LIMIT 1 OFFSET 1), 2, (SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM passenger LIMIT 1 OFFSET 2), 3, (SELECT id FROM train LIMIT 1 OFFSET 0)),
((SELECT id FROM passenger LIMIT 1 OFFSET 3), 4, (SELECT id FROM train LIMIT 1 OFFSET 1));

-- Inserting data into the assigned_staff table
INSERT INTO assigned_staff (train_id, staff_id)
VALUES
((SELECT id FROM train LIMIT 1 OFFSET 0), (SELECT id FROM staff LIMIT 1 OFFSET 0)),
((SELECT id FROM train LIMIT 1 OFFSET 0), (SELECT id FROM staff LIMIT 1 OFFSET 1)),
((SELECT id FROM train LIMIT 1 OFFSET 1), (SELECT id FROM staff LIMIT 1 OFFSET 2)),
((SELECT id FROM train LIMIT 1 OFFSET 2), (SELECT id FROM staff LIMIT 1 OFFSET 3));



