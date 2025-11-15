# Laravel skeleton app 🚀

A lightweight skeleton project with Laravel, Octane (RoadRunner), RabbitMQ, Redis, and PostgreSQL, fully dockerized for rapid development.

## Key services 🛠️

- Laravel app with Octane & RoadRunner ⚡
- PostgreSQL database 🐘
- Redis cache 🧠
- RabbitMQ message broker 🐇
- Queue worker & scheduler ⏳

## Deployment locally

Copy the environment settings:

```shell
  cp .env.local .env
```

Build the image:

```shell
  docker compose build --no-cache
```

Then run containers in the background:

```shell
  docker compose up -d
```

Install dependencies via composer:

```shell
  docker compose exec app composer install
```

Set app encryption key:

```shell
  docker compose exec app ./artisan key:generate --ansi
```

Run migrations and seed database:

```shell
  docker compose exec app ./artisan migrate:fresh --seed
```

Visit your app [http://127.0.0.1:9001](http://127.0.0.1:9001)
