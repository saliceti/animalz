start-db:
	/usr/local/opt/postgresql@12/bin/pg_ctl -D /usr/local/var/postgres start

stop-db:
	/usr/local/opt/postgresql@12/bin/pg_ctl -D /usr/local/var/postgres stop
