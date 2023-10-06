
create or replace view view_route_destinations (
	select r.id as route_id,
	s.id as station_id,
	s.name as station_name, 
	s.platforms, 
	rm.orig_station_id, 
	rm.dest_station_id, 
	d.departure,
	d.arrival
	from route_destinations rd 
	join routes r on rd.route_id = r.id
	join destinations d on rd.destination_id = d.id
	join roadmaps rm on d.roadmap_id = rm.id
	join stations s on d.station_id = s.id
);

-- Create a stored procedure that calls the view and returns the result
CREATE OR REPLACE FUNCTION list_route_destinations()
RETURNS TABLE (
    route_id UUID,
    train_id UUID,
    station_name VARCHAR(255),
    platform INT,
    orig_station_id UUID,
    dest_station_id UUID,
    departure VARCHAR(255),
    arrival VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM view_route_destinations;
END;
$$ LANGUAGE plpgsql;


--select * from GetTrainRouteView();

