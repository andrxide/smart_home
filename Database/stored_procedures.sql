use smartGarden
go

CREATE PROCEDURE pa_gardensUser
	@user_id int
as
	SELECT g_ID, g_createdAt, g_name, g_description from garden_user
	join gardens on gu_garden = g_ID
	where gu_user = @user_id;
go

CREATE PROCEDURE pa_sensorType
	@id varchar(3)
as
	SELECT st_ID, st_description, st_unit, st_icon FROM sensor_type
	where st_ID = @id;
go

CREATE PROCEDURE pa_sensor
	@id varchar(5)
as
	select s_ID, s_type, s_name from sensors
	where s_ID = @id;
go

ALTER PROCEDURE pa_garden_sensor
	@gardenId varchar(8)
as
	SELECT gs_sensor, gs_garden, gs_minValue, gs_maxValue FROM garden_sensor
	WHERE gs_garden = @gardenId
go

execute pa_garden_sensor 'SG21AA01';


ALTER PROCEDURE pa_getGardenSensor
	@gardenId varchar(8),
	@sensorId varchar(5)
as
	SELECT gs_sensor, gs_garden, gs_minValue, gs_maxValue FROM garden_sensor
	WHERE gs_garden = @gardenId AND
	gs_sensor = @sensorId
go

execute pa_getGardenSensor 'SG21AA01','SRTMP'

/*CREATE PROCEDURE pa_insertReadings
@jardin varcha(8)
	@ph float,
	@
as
	insert into readings (r_sensor, r_garden, r_timestamp, r_value) values
	('SRPHS',@jardin, CURRENT_TIMESTAMP, @ph),
	('SRTMP',@jardin, CURRENT_TIMESTAMP, @tmp),
	(),
	()
	()
go

execute pa_insertReadings '','','','','';*/

ALTER PROCEDURE pa_getReadings
	@sensorId varchar(5),
	@gardenId varchar(8),
	@range int
as
	select r_ID,r_timestamp,r_value 
	from readings where 
	r_sensor = @sensorId and 
	r_garden = @gardenId and
	r_timestamp >= DATEADD(day, -@range, CURRENT_TIMESTAMP)
	order by r_timestamp asc;
go

execute pa_getReadings 'SRTMP','SG21AA04', 5

execute pa_getGardenSensor 'SG21AA01','SRTMP'
