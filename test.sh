#!/bin/bash
SCRIPT=`readlink -f $0`
BASEDIR=`dirname "$SCRIPT"`

function mknet()
{
	docker network create --subnet '172.18.0.0/24' test-net
}

function rmnet()
{
	docker network rm test-net
}

function mksite()
{
	docker run -v "$BASEDIR:/data:z" --network test-net --ip '172.18.0.16' --name testsite --hostname testsite -td 'shinkou/python'
	docker exec -t testsite bash -c 'pip install --upgrade pip'
	docker exec -t testsite bash -c 'pip install flask'
}

function rmsite()
{
	docker rm testsite
}

function startsite()
{
	docker exec -d testsite bash -c 'python /data/test_site/app.py'
}

function stopsite()
{
	docker stop testsite
}

function mkcrawler()
{
	docker run -v "$BASEDIR:/data:z" --network test-net --ip '172.18.0.17' --name testjvm --hostname testjvm -td 'shinkou/jre'
	docker exec -t testjvm bash -c 'apt update && apt upgrade -y && apt-get install -y openjdk-8-jdk maven && apt-get clean -y'
	docker exec -t testjvm bash -c 'cd /data/test_crawler && mvn clean package'
}

function rmcrawler()
{
	docker rm testjvm
}

function startcrawler()
{
	docker exec -it testjvm bash -c 'java -jar /data/test_crawler/target/crawler4j_test-0.1.0.jar http://testsite:5000/'
}

function stopcrawler()
{
	docker stop testjvm
}

function printusage()
{
	echo 'Usage: test.sh GOAL'
	echo
	echo 'where'
	echo '  GOAL  "make", "start", "stop", or "destroy"'
	echo
}

if [[ $# -eq 0 ]]; then
	set -- --help
fi

for arg in "$@"; do
	case $arg in
		--help | -h)
			printusage
			;;
		make)
			mknet
			mksite
			mkcrawler
			;;
		destroy)
			rmcrawler
			rmsite
			rmnet
			;;
		start)
			startsite
			startcrawler
			;;
		stop)
			stopcrawler
			stopsite
			;;
		mknet)
			mknet
			;;
		mksite)
			mksite
			;;
		mkcrawler)
			mkcrawler
			;;
		rmcrawler)
			rmcrawler
			;;
		rmsite)
			rmsite
			;;
		rmnet)
			rmnet
			;;
		startsite)
			startsite
			;;
		startcrawler)
			startcrawler
			;;
		stopcrawler)
			stopcrawler
			;;
		stopsite)
			stopsite
			;;
		*)
			echo "Invalid argument \"$arg\"."
			exit 1
			;;
	esac
done
