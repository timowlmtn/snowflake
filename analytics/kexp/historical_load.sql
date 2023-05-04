use schema LANDING_ZONE;
show pipes;

copy into LANDING_ZONE.IMPORT_SHOW (SHOW_ID, PROGRAM_ID, PROGRAM_NAME, PROGRAM_TAGS, HOST_NAMES, TAGLINE, START_TIME,
                                    LANDING_ZONE_CREATE_DATE, LANDING_ZONE_CREATE_USER, LANDING_ZONE_UPDATE_DATE,
                                    LANDING_ZONE_UPDATE_USER, landing_zone_hidden, landing_zone_filename,
                                    landing_zone_file_row_number, landing_zone_raw
    )
    from ( select$1:id::NUMBER id,$1:program::NUMBER program,$1:program_name::TEXT program_name,$1:program_tags::TEXT program_tags,$1:host_names::VARIANT host_names,$1:tagline::TEXT tagline,$1: start_time::TIMESTAMP_LTZ start_time, CURRENT_TIMESTAMP () landing_zone_create_date
        , CURRENT_USER () landing_zone_create_user
        , CURRENT_TIMESTAMP () landing_zone_update_date
        , CURRENT_USER () landing_zone_update_user
        , FALSE landing_zone_hidden
        ,metadata$filename landing_zone_filename
        ,metadata$file_row_number landing_zone_file_row_number
        ,$1 landing_zone_raw
        from @LANDING_ZONE.STAGE_IMPORT_SHOW)
    FILE_FORMAT = (type = 'JSON')
    PATTERN = '.*.json';

copy into LANDING_ZONE.IMPORT_PLAYLIST (PLAYLIST_ID, PLAY_TYPE, AIRDATE, ALBUM, ARTIST, SONG, SHOW_ID, COMMENT,
                                        IMAGE_URI, LABELS, RELEASE_DATE, LANDING_ZONE_CREATE_DATE,
                                        LANDING_ZONE_CREATE_USER, LANDING_ZONE_UPDATE_DATE, LANDING_ZONE_UPDATE_USER,
                                        landing_zone_hidden, landing_zone_filename, landing_zone_file_row_number,
                                        landing_zone_raw
    )
    from ( select$1:id::NUMBER id,$1:play_type::TEXT play_type,$1:airdate::TIMESTAMP_LTZ airdate,$1:album::TEXT album,$1:artist::TEXT artist,$1:song::TEXT song,$1: show::NUMBER show,$1: comment::TEXT comment,$1:image_uri::TEXT image_uri,$1:labels::VARIANT labels,$1:release_date::TEXT release_date, CURRENT_TIMESTAMP () landing_zone_create_date
        , CURRENT_USER () landing_zone_create_user
        , CURRENT_TIMESTAMP () landing_zone_update_date
        , CURRENT_USER () landing_zone_update_user
        , FALSE landing_zone_hidden
        ,metadata$filename landing_zone_filename
        ,metadata$file_row_number landing_zone_file_row_number
        ,$1 landing_zone_raw
        from @LANDING_ZONE.STAGE_IMPORT_PLAYLIST)
    FILE_FORMAT = (type = 'JSON')
    PATTERN = '.*.json';

select to_date(airdate), count(*)
from LANDING_ZONE.IMPORT_PLAYLIST
group by to_date(airdate)
order by to_date(airdate) desc;