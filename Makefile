.PHONY: lint test self-scan validate

lint:
	@which actionlint >/dev/null 2>&1 || (echo "actionlint not installed (brew install actionlint)" && exit 1)
	actionlint action.yml .github/workflows/*.yml

validate:
	@which action-validator >/dev/null 2>&1 && action-validator action.yml || echo "action-validator not installed (skipping)"

test:
	@which act >/dev/null 2>&1 || (echo "act not installed (brew install act). Skipping local test." && exit 0)
	act -W .github/workflows/ci.yml --container-architecture linux/amd64

self-scan:
	agent-readiness scan . --fail-below 95
