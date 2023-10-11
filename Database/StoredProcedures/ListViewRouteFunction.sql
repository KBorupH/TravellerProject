
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
    station_platforms INT
) AS $$
BEGIN
    RETURN QUERY
	SELECT * FROM view_route_destinations;
END;
$$ LANGUAGE plpgsql;