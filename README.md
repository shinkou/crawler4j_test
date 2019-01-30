# crawler4j_test
This repo is to demonstrate the issue in crawler4j where relative links are
misinterpreted when the *base* tag presents.

## Requirements
- docker

## How to run
Simply compile and run the test script like this:
```
$ test.sh make
$ test.sh start
```
To stop and clean up docker containers after use:
```
$ test.sh stop
$ test.sh destroy
```
