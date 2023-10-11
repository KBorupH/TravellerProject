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

create procedure FindStaffByName(_name VarChar(100))
LANGUAGE SQL
        AS $$
SELECT 
person.name, staff.id
FROM person, staff
WHERE ("name" = _name) 
AND (staff.person_id = person.id) ;
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

create procedure GetPassengers()
LANGUAGE SQL
        AS $$
SELECT * FROM passenger;
        $$;

create procedure GetTickets()
LANGUAGE SQL
        AS $$
SELECT * FROM ticket;
        $$;

create procedure GetTrains()
LANGUAGE SQL
        AS $$
SELECT * FROM train;
        $$;

create procedure GetStaff()
LANGUAGE SQL
        AS $$
SELECT * FROM staff;
        $$;