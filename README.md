# Laravel Skeleton App 🚀

A lightweight skeleton app with Laravel, Octane (RoadRunner), RabbitMQ, Redis, and PostgreSQL, fully dockerized for rapid development.

## 🛠 Tech Stack

- ⚡ Laravel with Octane & RoadRunner
- 🐘 PostgreSQL - relational database
- 🧠 Redis - caching and sessions
- 🐇 RabbitMQ - message broker
- ⏳ Queue Worker & Scheduler - background jobs and task scheduling

## Quick setup

```shell
  make install
```

## Manual Setup

Copy the environment settings:

```shell
  cp .env.example .env
```

Build the image:

```shell
  docker compose build
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
  docker compose exec app ./artisan key:generate
```

Run migrations and seed database:

```shell
  docker compose exec app ./artisan migrate
```

🎉 Your app is ready! Visit http://127.0.0.1:9001
