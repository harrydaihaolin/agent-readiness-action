.PHONY: lint test self-scan validate

lint:
	@which actionlint >/dev/null 2>&1 || (echo "actionlint not installed (brew install actionlint)" && exit 1)
	# actionlint is a workflow linter; validate action.yml separately via `make validate`.
	actionlint .github/workflows/*.yml

validate:
	@which action-validator >/dev/null 2>&1 && action-validator action.yml || echo "action-validator not installed (skipping)"

test:
	@echo "Running inner smoke fixture tests..."
	$(MAKE) -C tests/test-good-repo test
	@which act >/dev/null 2>&1 && act -W .github/workflows/ci.yml --container-architecture linux/amd64 || echo "act not installed; skipping the act-based outer smoke."

self-scan:
	# Action repos can't satisfy manifest.detected/lockfile_present/typecheck.configured,
	# so 80 is the realistic ceiling.
	agent-readiness scan . --fail-below 80
