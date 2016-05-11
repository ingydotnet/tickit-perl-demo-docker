NAME := termui/tickit-perl-demo
VERSION := latest
TAG := $(NAME):$(VERSION)

build:
	docker build -t $(TAG) .

dev:
	docker build -t $(TAG) -f Dockerfile.dev .

push: clean build
	docker push $(TAG)

shell:
	docker run -it -v $$PWD:/src --entrypoint /bin/bash $(TAG)

clean:
	docker rmi -f $(TAG) || true
