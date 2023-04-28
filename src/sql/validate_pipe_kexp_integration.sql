select min(JSON_OBJECT), max(JSON_OBJECT), count(*)
from LANDING_ZONE.IMPORT_PLAYLIST;

select min(JSON_OBJECT), max(JSON_OBJECT), count(*)
from LANDING_ZONE.IMPORT_SHOW;


use schema LANDING_ZONE;

show integrations ;

show stages;

show pipes;

