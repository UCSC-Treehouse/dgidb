download:
	# Get the database and its structure
	mkdir -p dgidb
	wget -N -P dgidb/ https://raw.githubusercontent.com/griffithlab/dgi-db/master/db/structure.sql
	wget -N -P dgidb/ http://www.dgidb.org/data/data.sql

up:
	# Start up postgres with access to this directory under /data
	mkdir -p postgres
	docker run -d  --name postgres \
		-v `pwd`/postgres:/var/lib/postgresql/data \
		-v `pwd`/dgidb:/dgidb \
		-v `pwd`:/data \
		postgres

down:
	docker stop postgres && docker rm postgres

import:
	# Give the docker a moment to spin up
	sleep 10
	# Import the dgidb and the fda list into postrgres
	docker exec -it postgres psql -h localhost -U postgres -c "create database dgidb"
	docker exec -it postgres psql -h localhost -U postgres -d dgidb -f /dgidb/structure.sql
	docker exec -it postgres psql -h localhost -U postgres -d dgidb -f /dgidb/data.sql
	# docker exec -it postgres psql -h localhost -U postgres -d dgidb \
	# 	-c "create table fda_drugs (name character varying(255))"
	# docker exec -it postgres psql -h localhost -U postgres -d dgidb \
	# 	-c "copy fda_drugs from '/data/fda_drugs.csv'"
	
extract_fda:
	docker exec -it postgres psql -h localhost -U postgres -d dgidb \
		-t -A -F'	' -f /data/extract.sql -o /data/fda_drugs.gmt

extract:
	docker exec -it postgres psql -h localhost -U postgres -d dgidb \
		-t -A -F'	' -f /data/extract-druggable-genes.sql -o /data/druggable_genes.tsv
