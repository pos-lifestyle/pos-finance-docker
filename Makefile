NAME = poslifestyle/pos-finance-docker
VERSION = 1.0.0

.PHONY: build

build:
	docker build -t poslifestyle/pos-finance-apache apache
	docker build -t poslifestyle/pos-finance-elasticsearch elasticsearch
	docker build -t poslifestyle/pos-finance-openssh-client openssh-client
	docker build -t poslifestyle/pos-finance-php-apache php-apache
	docker build -t poslifestyle/pos-finance-php-cli php-cli
	docker build -t poslifestyle/pos-finance-php-fpm php-fpm
	docker build -t poslifestyle/pos-finance-postgres postgres
