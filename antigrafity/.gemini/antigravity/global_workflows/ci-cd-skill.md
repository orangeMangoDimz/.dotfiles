---
description: Use this standard whenever the user asks for a "CI/CD Pipeline"
---

# GitLab CI/CD Generation Standard

## 0. Interaction Phase (MANDATORY)

**STOP!** Before generating or modifying any `.gitlab-ci.yml` file, you **MUST** pause and ask the user the following 3 questions. **Do not proceed** until the user has answered.

1.  **Test Workflow**: "Do you want to include the test workflow? (If no, I will exclude the test stage)."
2.  **Containerization**: "Do you want to use the Docker containerize workflow? (If no, I will focus only on code delivery via git/rsync)."
3.  **Variables**: "Do you have variables set up already? (If not, I will list the variable keys required, and you can provide the values)."

---

## 1. Pipeline Architecture

Once the user confirms the scope, generate the `.gitlab-ci.yml` following this specific structure derived from the project standard.

### Stages

Standard mpstages order:

1.  `build`
2.  `test` (Optional - based on Question 1)
3.  `deploy`

### Global Configuration

-   **Cache**: standard pip cache (or relevant language cache) configurations.
-   **Variables**: Define `PIP_CACHE_DIR` and other static vars.

---

## 2. Rules & Triggers

The pipeline **MUST** implement the following logic constraints:

| Event             | Target                | Job Action                                                                |
| :---------------- | :-------------------- | :------------------------------------------------------------------------ |
| **Merge Request** | `dev` branch          | **Build Check**: Run `docker build` (or code compile) to validate the MR. |
| **Merge Request** | `main` branch         | **Build Check**: Run `docker build` as a final pre-production check.      |
| **Git Tag**       | `v*` (e.g., `v1.0.0`) | **Production Deploy**: Trigger the deployment job.                        |

---

## 3. Implementation Details

### Docker containerize Workflow (If "Yes" to Q2)

If the user selects the Docker workflow, the `deploy` job **MUST**:

1.  **Login**: Authenticate with the Docker Registry (e.g., Docker Hub).
2.  **Build & Push**:
    -   Build the image.
    -   Tag it with the Git Tag: `$CI_COMMIT_TAG`.
    -   Push to the registry.
3.  **SSH Deployment**:
    -   SSH into the remote server.
    -   Login to Docker Registry on remote.
    -   Pull the specific tag (`$CI_COMMIT_TAG`).
    -   **Migrations**: Run database migrations (e.g., `alembic upgrade head`) via a temporary container.
    -   **Container Swap**:
        -   Stop and remove the old container.
        -   Start the new container (`--restart unless-stopped`).
        -   Inject environment variables (`DATABASE_URL`, `APP_ENV`, etc.).

### Standard Variable Keys

Ensure the configuration checks for these variables (or asks the user to set them if "No" to Q3):

-   `SSH_PRIVATE_KEY` / `SSH_USER` / `SSH_HOST`
-   `DOCKER_HUB_USER` / `DOCKER_HUB_PASSWORD`
-   `DOCKER_IMAGE_NAME`
-   `DATABASE_URL`

---

## 4. Formatting Checklist

-   Verify indentation is 2 or 4 spaces (consistent).
-   Use `rules:` syntax instead of the deprecated `only/except` where possible (though `only: - tags` is acceptable for deploy).
-   Comment explicitly on _why_ a job is running (e.g., "# Triggered ONLY when a new tag is pushed").
