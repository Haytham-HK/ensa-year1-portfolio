# TP01 — Oracle XE Environment

This practical lab (TP) sets up a local Oracle Database environment using Docker and executes basic PL/SQL scripts.

**Note:** Docker is used here because the standard Oracle Database XE installation did not work on an ubuntu machine (problems with rpm).

## Prerequisites

* Docker installed and running.
* VS Code with the Oracle SQL Developer Extension for VS Code installed (optional).

## Quick Start

### Start the Database

Run the following command in your terminal to download and start the Oracle XE container:

```bash
docker run -d --name oracle-xe \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PASSWORD=root \
  -e APP_USER=app \
  -e APP_USER_PASSWORD=root \
  gvenzl/oracle-xe:21-slim