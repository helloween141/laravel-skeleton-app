#!/usr/bin/make

SHELL = /bin/sh
DC_BIN := $(shell if docker compose version >/dev/null 2>&1; then echo 'docker compose'; \
	else if command -v docker-compose >/dev/null 2>&1; then echo 'docker-compose'; \
	else echo 'docker compose'; fi; fi)

.PHONY : pull build install \
         up down restart shell tinker \

.DEFAULT_GOAL : install

pull:
	$(DC_BIN) pull

build:
	$(DC_BIN) build

install:
	cp .env.example .env
	@make build
	@make up
	$(DC_BIN) exec app composer install -n --ansi --prefer-dist
	$(DC_BIN) exec app artisan migrate:fresh --seed --no-interaction
	$(DC_BIN) exec app artisan key:generate --force --ansi
	$(DC_BIN) exec app artisan storage:link
	@make restart
	@printf "\n   \e[30;42m %s \033[0m\n\n" 'Navigate your browser to: <http://127.0.0.1:9001>'

shell:
	$(DC_BIN) exec app sh

tinker:
	$(DC_BIN) exec app sh artisan ti

up:
	$(DC_BIN) up -d

down:
	$(DC_BIN) down -t 5

restart: down up
