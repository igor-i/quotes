.PHONY: test log
start:
	bin/rails server
test:
	bin/rails test
log:
	tail -f log/development.log
test-log:
	tail -f log/test.log
