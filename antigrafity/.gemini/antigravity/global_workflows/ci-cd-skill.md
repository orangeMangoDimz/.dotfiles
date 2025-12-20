---
description: Use this standard whenever the user asks for a "CI/CD Pipeline"
---

# GitLab CI/CD Generation Standard

## 0. Interaction Phase (MANDATORY)

**STOP!** Before generating or modifying any [.gitlab-ci.yml](cci:7://file:///home/orangemango/Documents/workspace/private/test/linkedin-telegram-service/.gitlab-ci.yml:0:0-0:0) file, you **MUST** pause and ask the user the following 3 questions. **Do not proceed** until the user has answered.

1.  **Test/Lint Workflow**: "Do you want to include the lint and test workflows? (If no, I will exclude the `lint` and `test` stages)."
2.  **Containerization**: "Are we continuing with the Docker containerize workflow for this deployment? (If no, I will focus only on code delivery via git/rsync)."
3.  **Variable Audit**: "Have you added any new environment variables to GitLab (e.g., for Supabase or Telegram)? I will need to map these in the deployment script."

---

## 1. Pipeline Architecture

The pipeline follows a 4-stage progression. All jobs should use the appropriate runner tags to ensure they execute on the correct infrastructure.

### Stages
1. `lint`: Static analysis and formatting checks.
2. `test`: Automated unit and integration tests.
3. `build`: Docker image construction and registry management.
4. `deploy`: Production environment updates.

### Runner Tags Mapping
| Stage | Tags | Purpose |
| :--- | :--- | :--- |
| **Lint** | `build` | General purpose python check. |
| **Test** | `build` | Environment for running pytest. |
| **Build** | `build-images`, `docker` | Requires Docker-in-Docker capability. |
| **Deploy** | `deploy`, `dev` | Access to deployment keys and target host. |

---

## 2. Rules & Triggers

The pipeline implements strict logic based on the event source:

| Event | Jobs Triggered | Logic |
| :--- | :--- | :--- |
| **Merge Request (to dev)** | `lint`, `test`, `build_check_dev` | Validates code quality and buildability before merging to dev. |
| **Merge Request (to main)** | `lint`, `test`, `build_check_prod` | Final validation before production merge. |
| **Push to Dev/Main** | `lint`, `test` | Ensures stability on core branches. |
| **Git Tag (e.g., v1.0.0)** | `lint`, `test`, `build_push_production`, `deploy_production` | Triggers the full release cycle. |

---

## 3. Implementation Details

### Build Stage
- **Checks**: Use `docker build .` without pushing to validate MRs.
- **Production**: Login to registry using `$CI_JOB_TOKEN`, build with `$CI_COMMIT_TAG`, and push to `$CI_REGISTRY_IMAGE`.

### Deploy Stage
- **SSH Setup**: Use `ssh-agent` to inject `SSH_PRIVATE_KEY`.
- **Remote Commands**:
    1. Login to registry on the host.
    2. Pull the tagged image.
    3. Stop/Remove existing container (fail-safe with `|| true`).
    4. Start new container with `--restart unless-stopped`.
    5. **Environment Mapping**: Explicitly pass variables (`SUPABASE_URL`, `TELEGRAM_TOKEN`, etc.) using the `-e` flag.

---

## 4. Formatting & Best Practices
- **Variables**: Define `PIP_CACHE_DIR`, `DOCKER_IMAGE_NAME`, and `CONTAINER_NAME` globally.
- **Rules Syntax**: Prefer `rules: if:` over `only/except` to maintain compatibility with modern GitLab features.
- **Caching**: Always cache `.cache/pip` to speed up lint and test stages.

## Full Example

```yaml
stages:
    - lint
    - test
    - build
    - deploy

variables:
    PIP_CACHE_DIR: "$CI_PROJECT_DIR/.cache/pip"
    DOCKER_IMAGE_NAME: "$CI_REGISTRY_IMAGE"
    CONTAINER_NAME: "telegram-service-prod"
    APP_ENV: prod

cache:
    paths:
        - .cache/pip

lint:python:
    stage: lint
    image: python:3.11-slim
    tags:
        - build
    before_script:
        - pip install ruff==0.8.4
    script:
        - ruff check .
        - ruff format --check .
    allow_failure: false
    rules:
        - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
        - if: $CI_COMMIT_BRANCH == 'dev'
        - if: $CI_COMMIT_BRANCH == 'main'
        - if: $CI_COMMIT_TAG

test:
    stage: test
    image: python:3.11-slim
    tags:
        - build
    before_script:
        - pip install -r requirements.txt
    script:
        # - pytest --cov=src --cov-report=term-missing --cov-fail-under=80
        - pytest --cov=src --cov-report=term-missing
    coverage: '/(?i)total.*? (100(?:\.0+)?\%|[1-9]?\d(?:\.\d+)?\%)$/'
    allow_failure: false
    rules:
        - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
        - if: $CI_COMMIT_BRANCH == 'dev'
        - if: $CI_COMMIT_BRANCH == 'main'
        - if: $CI_COMMIT_TAG

build_check_dev:
    stage: build
    tags:
        - build-images
        - docker
    script:
        - docker build .
    rules:
        - if: $CI_PIPELINE_SOURCE == 'merge_request_event' && $CI_MERGE_REQUEST_TARGET_BRANCH_NAME == 'dev'

build_check_prod:
    stage: build
    tags:
        - build-images
        - docker
    script:
        - docker build .
    rules:
        - if: $CI_PIPELINE_SOURCE == 'merge_request_event' && $CI_MERGE_REQUEST_TARGET_BRANCH_NAME == 'main'

build_push_production:
    stage: build
    tags:
        - build-images
        - docker
    before_script:
        - echo "$CI_JOB_TOKEN" | docker login $CI_REGISTRY -u gitlab-ci-token --password-stdin
    script:
        - docker build -t $DOCKER_IMAGE_NAME:$CI_COMMIT_TAG .
        - docker push $DOCKER_IMAGE_NAME:$CI_COMMIT_TAG
    only:
        - tags

deploy_production:
    stage: deploy
    image: alpine:latest
    tags:
        - deploy
        - dev
    before_script:
        - apk add --no-cache openssh-client
        - eval $(ssh-agent -s)
        - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
        - mkdir -p ~/.ssh
        - chmod 700 ~/.ssh
        - ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts
        - chmod 644 ~/.ssh/known_hosts
    script:
        - echo "Deploying to $SSH_HOST..."
        - ssh -o StrictHostKeyChecking=no dimas@$SSH_HOST "
          echo '$CI_JOB_TOKEN' | docker login $CI_REGISTRY -u gitlab-ci-token --password-stdin &&
          docker pull $DOCKER_IMAGE_NAME:$CI_COMMIT_TAG &&

          echo 'Deploying Application...' &&
          docker stop $CONTAINER_NAME || true &&
          docker rm $CONTAINER_NAME || true &&
          docker run -d --name $CONTAINER_NAME --restart unless-stopped -e SUPABASE_URL="$SUPABASE_URL" -e SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY" -e SUPABASE_POST_TABLE="$SUPABASE_POST_TABLE" -e TELEGRAM_TOKEN="$TELEGRAM_TOKEN" -e APP_ENV="$APP_ENV" $DOCKER_IMAGE_NAME:$CI_COMMIT_TAG
          "
    only:
        - tags
```
