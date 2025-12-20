---
description: Pre-commit Configuration Standard
---

# Pre-commit Configuration Standard

This rule defines the required configuration for [.pre-commit-config.yaml](cci:7://file:///home/orangemango/Documents/workspace/private/test/linkedin-telegram-service/.pre-commit-config.yaml:0:0-0:0) to enforce code quality, formatting, security, and conventional commit messages.

## Configuration

Ensure your `.pre-commit-config.yaml` matches the following structure:

```yaml
# Installation
# pip install pre-commit
# pre-commit install

# Run all hooks
# pre-commit run --all-files
# Runs specific hook
# pre-commit run ruff --all-files


repos:
    # Ruff - Fast Python linting & formatting
    - repo: [https://github.com/astral-sh/ruff-pre-commit](https://github.com/astral-sh/ruff-pre-commit)
      rev: v0.1.15
      hooks:
          - id: ruff
            args: [--fix, --exit-non-zero-on-fix]
          - id: ruff-format

    # Additional Python checks
    - repo: [https://github.com/pre-commit/pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks)
      rev: v4.5.0
      hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml
          - id: check-added-large-files
            args: ["--maxkb=1000"]
          - id: check-json
          - id: check-toml
          - id: check-merge-conflict
          - id: debug-statements
          - id: mixed-line-ending

    # Type checking -> ignored
    # - repo: [https://github.com/pre-commit/mirrors-mypy](https://github.com/pre-commit/mirrors-mypy)
    #   rev: v1.8.0
    #   hooks:
    #       - id: mypy
    #         args: [--ignore-missing-imports]

    # Security scanning
    - repo: [https://github.com/PyCQA/bandit](https://github.com/PyCQA/bandit)
      rev: 1.7.6
      hooks:
          - id: bandit
            exclude: ^tests/
            args: [-c, pyproject.toml]
            additional_dependencies: ["bandit[toml]"]

    # Import sorting
    - repo: [https://github.com/pycqa/isort](https://github.com/pycqa/isort)
      rev: 5.13.2
      hooks:
          - id: isort
            args: [--profile, black]

    # Conventional commits enforcement
    - repo: [https://github.com/compilerla/conventional-pre-commit](https://github.com/compilerla/conventional-pre-commit)
      rev: v3.0.0
      hooks:
          - id: conventional-pre-commit
            stages: [commit-msg]
