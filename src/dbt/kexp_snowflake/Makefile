create-show:
	dbt run-operation create_s3_pipe \
		--args '${shell cat ../../../domain/kexp/radio_show_kexp_pipe.json | sed "s/&ENVIRONMENT/${ENVIRONMENT}/g;s/&PREFIX/${PREFIX}/g" }'

destroy-show:
	dbt run-operation destroy_s3_pipe \
		--args '${shell cat ../../../domain/kexp/radio_show_kexp_pipe.json | sed "s/&ENVIRONMENT/${ENVIRONMENT}/g;s/&PREFIX/${PREFIX}/g" }'

create-playlist:
	dbt run-operation create_s3_pipe \
		--args '${shell cat ../../../domain/kexp/radio_playlist_kexp_pipe.json | sed "s/&ENVIRONMENT/${ENVIRONMENT}/g;s/&PREFIX/${PREFIX}/g" }'

destroy-playlist:
	dbt run-operation destroy_s3_pipe  \
		--args '${shell cat ../../../domain/kexp/radio_playlist_kexp_pipe.json | sed "s/&ENVIRONMENT/${ENVIRONMENT}/g;s/&PREFIX/${PREFIX}/g" }'

