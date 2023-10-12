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