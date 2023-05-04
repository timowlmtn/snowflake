select *
from LANDING_ZONE.IMPORT_LOG;

select to_date(START_TIME), count(*)
from LANDING_ZONE.IMPORT_SHOW
group by to_date(START_TIME)
order by to_date(START_TIME) desc;

select to_date(airdate), count(*)
from LANDING_ZONE.IMPORT_PLAYLIST
group by to_date(airdate)
order by to_date(airdate) desc;
