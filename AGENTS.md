# AGENTS.md — agent-readiness-action

Composite GitHub Action that wraps `agent-readiness scan`. The whole
project is a single `action.yml` plus docs and a smoke test.

## Canonical commands

| Task | Command |
|---|---|
| Lint action.yml | `make lint` |
| Test the action locally with `act` | `make test` |
| Validate composite action shape | `actionlint action.yml` |

## Do-not-touch

- The `v1` floating tag is repointed by `release.yml` on every minor/patch
  release. Don't move it manually unless you're making a breaking change
  (which would warrant a `v2` branch instead).
- `tests/test-good-repo/` is intentionally minimal. Do not add unrelated
  files there or self-scan baselines will drift.

## Release flow

1. Land changes on `main` via PR; CI must pass.
2. Tag `vX.Y.Z`.
3. `release.yml` (or maintainer manual) updates the `v1` major tag to
   point at `vX.Y.Z`.

## Headless contract

`action.yml` exposes machine-readable outputs (`score`, `sarif-path`).
Consumer workflows can branch on these. No interactive prompts; no human
input required at runtime.
