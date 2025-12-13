---
description: Best practices and standards for Docker and Docker Compose configuration
---

# Docker & Docker Compose Standards

When asking the agent to work with Docker, or when performing Docker-related tasks, strictly follow these guidelines.

## 1. Environment Handling

**Reference**: `[.env.dev.example](file:///path/to/.env.dev.example)`

-   **NEVER Hardcode Secrets**: Passwords, API keys, and internal URLs must strictly come from environment variables.
-   **Use `.env` Files**:
    -   Create template files (e.g., `.env.dev.example`, `.env.prod.example`) containing 100% of required variables.
    -   Add strict `.env` files (e.g., `.env.dev`, `.env.prod`) to `.gitignore`.
-   **Docker Compose `env_file`**: Explicitly load the relevant environment file for each service.

```yaml
services:
    web-dev:
        env_file: [.env.dev]
```

## 2. Service Profiles (Dev vs Prod)

**Context**: Separate development and production configurations within the same `docker-compose.yml`.

-   **Use Profiles**: Assign `profiles: ["dev"]` or `profiles: ["prod"]` to every service.
-   **Distinct Service Names**: Suffix services to avoid ambiguity (e.g., `web-dev`, `db-prod`).
-   **Execution**:
    -   Dev: `docker compose --profile dev up`
    -   Prod: `docker compose --profile prod up`
-   **Avoid "Magic" Logic**: Do not rely on implicit overrides. Be explicit.

## 3. Dynamic Port Binding

**Goal**: Avoid port conflicts on host machines.

-   **Variable Ports**: Always use environment variables for host ports with a default fallback.

```yaml
ports:
    - "${APP_PORT:-8000}:8000"
    - "${DB_PORT:-5432}:5432"
```

## 4. Work Efficiently

-   **`.dockerignore`**: Always create a `.dockerignore` file. Exclude:
    -   `.git`, `.gitignore`
    -   `.env` files
    -   `venv`, `node_modules`
    -   `__pycache__`
-   **Healthchecks**: (Optional but recommended) Define healthchecks for critical services (DBs).

## 5. Security

-   **Least Privilege**: Do not run containers as root if possible (use `user: 1000:1000` or `USER` instruction in Dockerfile).
-   **Network Isolation**: Use internal networks for DBs if they don't need external access.
