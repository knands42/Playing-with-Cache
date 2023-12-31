SERVER_USE_CACHE ?= false
SERVER_USE_ETAGS ?= false

CLIENT_USE_CACHE ?= false

run-server:
	SERVER_USE_CACHE=${SERVER_USE_CACHE} SERVER_USE_ETAGS=${SERVER_USE_ETAGS} ./gradlew run

run-deps:
	docker rm -f $(docker ps -a -q) || true
	docker-compose up --build --force-recreate

products_run_perf_test:
	CLIENT_USE_CACHE=${CLIENT_USE_CACHE} CLIENT_USE_ETAGS=${CLIENT_USE_ETAGS} locust -f ./perf-test/products.py --users 100000 --spawn-rate 100 --run-time 10m -H http://localhost:8080

customers_run_perf_test:
	CLIENT_USE_CACHE=${CLIENT_USE_CACHE} CLIENT_USE_ETAGS=${CLIENT_USE_ETAGS} locust -f ./perf-test/customers.py --users 100000 --spawn-rate 100 --run-time 10m -H http://localhost:8080
