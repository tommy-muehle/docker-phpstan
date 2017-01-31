build: build-0.6 build-latest

test: build test-0.6 test-latest

build-latest:
	docker build -t phpstan:latest latest

build-0.6:
	docker build -t phpstan:0.6 0.6

test-0.6:
	@echo "Test 0.6"
	@docker run --rm phpstan:0.6 list

test-latest:
	@echo "Test dev-master"
	@docker run --rm phpstan:latest list
