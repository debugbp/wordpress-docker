# wordpress-docker
run lighttpd, wordpress and mariadb in docker

Usage
--------------

	git clone https://github.com/debugbp/wordpress-docker
	cd wordpress-docker
	touch wordpress.sql
	curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
	docker build -t wordpress-docker .
	docker run -d -e PORT=80 wordpress-docker crond

If you add "crond" to the run command, the files and database will be exported to /opt every 15 minutes.
