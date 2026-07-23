start-project:
	# run project
	docker-compose -p mlops-nginx up -d --build
	@echo "Gateway:    https://localhost"
	@echo "Prometheus: http://localhost:9090"
	@echo "Grafana UI: http://localhost:3000"

test-api:
	curl -X POST "https://localhost/predict" \
     -H "Content-Type: application/json" \
     -d '{"sentence": "Oh yeah, that was soooo cool!"}' \
	 --user admin:admin \
     --cacert ./deployments/nginx/certs/nginx.crt;

stop-project:
	docker-compose -p mlops-nginx down

restart-project:
	make stop-project && make start-project

test:
	bash tests/run_tests.sh