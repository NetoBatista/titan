# Titan

Titan is a scheduled event execution application. The purpose of this system is to perform `requests` at configured time intervals. Currently, the supported methods are: `POST`, `PUT`, `GET`, `PATCH`, `DELETE`.

# Technologies

Titan is built with two technologies: `Flutter for the web` and `C# for the backend`.

In Flutter, the following resources are used:
* flutter_modular
* http
* localization

In C#, the following resources are used:
* Microsoft.EntityFrameworkCore
* Npgsql.EntityFrameworkCore.PostgreSQL
* SimpleAutoMapper

The API uses `migrations` with PostgreSQL, meaning that when executed, all tables and their relationships will be created automatically.

# How to Run

You need to have `Docker` installed beforehand, as the default configuration to run the project requires this application.

To run Titan locally, navigate to the folder containing the `docker-compose.yaml` file and execute the command `docker compose up`. All dependencies, including the PostgreSQL database, will be installed automatically, and the project can be run with default values. Once all services are running correctly, go to `http://localhost:8000`.

**(Optional)**

There is a Dockerfile for both the web application and the server. However, these files are connected with the main `docker-compose.yaml` file, which includes some configurations such as:

Client (Flutter Web)
* URL_API
  * This is the base URL of the API that will be running, by default, it is set to port 8001.

Server (C#)
* CONNECTION_STRING
  * This is the database configuration. By default, it is set to `host:localhost` and `database=titan`.

All values can be adjusted according to your needs.

# Preview

https://github.com/user-attachments/assets/dedde1df-100f-440a-952f-4e5791fbd301



