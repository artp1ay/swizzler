# Swizzler

REST api template based on Flask with peewee as ORM.
Currently works only with SQLite.
Easy 1-click deploy with Docker and bash scripts for managing Nginx, Certbot, etc.

## Quick Start

Clone this repo

``` bash
git clone https://github.com/artp1ay/swizzler yourapp
```

Rename .env file

```bash
mv example.env .env
```

Run it

```bash
docker-compose up -d

```


## Roadmap
- [ ] PostgreSQL support
- [ ] Authorization
- [ ] Task queues support
- [ ] Automatic TUI script to construct your own service.
- [ ] Automatic docs like Swagger
- [ ] Data Validation
