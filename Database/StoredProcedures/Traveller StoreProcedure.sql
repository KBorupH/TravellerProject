create procedure NewPerson(_name VarChar(100))
LANGUAGE SQL
        AS $$
INSERT INTO person(name)
        VALUES(_name);
        $$;

create procedure NewStation(_name VarChar(255), _platforms Int)
LANGUAGE SQL
        AS $$
INSERT INTO stations(name, platforms)
        VALUES(_name, _platforms);
        $$;

create procedure NewRoadmap(_destination VarChar(255), _start VarChar(255), _estimated_time interval)
LANGUAGE SQL
        AS $$
INSERT INTO roadmaps(destination, start, estimated_time)
        VALUES(_destination, _start, _estimated_time);
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
