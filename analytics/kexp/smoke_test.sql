select *
from LANDING_ZONE.IMPORT_LOG;

----------------------------------------------------------- PIPE_IMPORT_SHOW

use schema LANDING_ZONE;
select parse_json(system$pipe_status('PIPE_IMPORT_SHOW'));

select to_date(START_TIME), max(START_TIME), count(*)
from LANDING_ZONE.IMPORT_SHOW
group by to_date(START_TIME)
order by to_date(START_TIME) desc;

select *
from LANDING_ZONE.IMPORT_SHOW
where SHOW_ID is not null
order by START_TIME DESC
limit 20;

----------------------------------------------------------- PIPE_IMPORT_PLAYLIST
select parse_json(system$pipe_status('PIPE_IMPORT_PLAYLIST'));

select to_date(airdate), max(AIRDATE), count(*)
from LANDING_ZONE.IMPORT_PLAYLIST
group by to_date(airdate)
order by to_date(airdate) desc;

select *
from LANDING_ZONE.IMPORT_PLAYLIST
order by AIRDATE DESC
limit 20;