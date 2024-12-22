# ------------------------------------------------------------------------------
# Color definitions
# ------------------------------------------------------------------------------
RED    := \033[0;31m
GREEN  := \033[0;32m
YELLOW := \033[0;33m
BLUE   := \033[0;34m
BOLD   := \033[1m
RESET  := \033[0m

# ------------------------------------------------------------------------------
# Help content
# ------------------------------------------------------------------------------
define HELP
$(BOLD)Manage ml-project-template Usage:$(RESET)

  $(GREEN)make clean$(RESET)          Clean Python compiled bytecode files.
  $(GREEN)make lint$(RESET)           Run linter.
  $(GREEN)make static-check$(RESET)   Run static typing.
  $(GREEN)make security-check$(RESET) Run security issue scan.
  $(GREEN)make start-local$(RESET)    Start development services.
  $(GREEN)make stop-local$(RESET)     Stop development services.
  $(GREEN)make all$(RESET)            Show help.
endef

export HELP

# ------------------------------------------------------------------------------
# Targets
# ------------------------------------------------------------------------------
help:
	@echo "$$HELP"

start-local:
	docker compose up -d --build

stop-local:
	docker compose down --remove-orphans

lint:
	ruff check src

test:
	coverage html

static-check:
	mypy --ignore-missing-imports src

security-check:
	bandit src

clean:
	@echo "Cleaning up..."
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	@echo "Finished cleaning."

all: help

.PHONY: help clean start-local stop-local test lint security-check static-check