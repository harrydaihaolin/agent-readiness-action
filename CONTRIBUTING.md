# Contributing to agent-readiness-action

Thanks for your interest! This repo is intentionally tiny — a single
composite action plus docs.

## Quick checklist

1. Fork and branch from `main`.
2. Update `action.yml`. Keep all inputs documented in `README.md`.
3. If you add an input that affects scan output, add a smoke case to
   `tests/test-good-repo/` or extend `.github/workflows/ci.yml` to cover
   it.
4. Update `README.md` examples if behavior changes.
5. Open the PR. CI must be green and the self-scan must score ≥95.

## What we accept

- New inputs that map to existing `agent-readiness` flags.
- Better defaults. Justify with a 1-line rationale.
- Doc improvements (especially copy-paste-able snippets).

## What we don't accept

- Inputs requiring `agent-readiness-pro` or the closed insights engine
  — those belong on a Pro action in the private fork.
- Anything that breaks the `@v1` floating-tag contract without a
  matching `v2` branch.

## Development

```bash
make lint   # actionlint
make test   # local smoke via act, against tests/test-good-repo
```

## Code of conduct

Be kind. Disagree about the change, not the person.
