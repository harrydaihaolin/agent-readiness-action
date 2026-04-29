# agent-readiness-action

A composite GitHub Action that runs [`agent-readiness`](https://github.com/harrydaihaolin/agent-readiness)
on your repo, optionally fails the workflow below a score threshold, and
optionally uploads SARIF findings to GitHub Code Scanning.

The Bronze tier UX in one CI line.

## Quick start

Drop this into `.github/workflows/agent-readiness.yml`:

```yaml
name: agent-readiness

on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read
  security-events: write   # only needed when sarif: true

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: harrydaihaolin/agent-readiness-action@v1
        with:
          fail-below: 70
          sarif: true
```

## Inputs

| Name | Default | Description |
|---|---|---|
| `fail-below` | (none) | Fail the workflow when overall score is below this threshold (0-100). |
| `sarif` | `false` | When `true`, write `findings.sarif` and (by default) upload to Code Scanning. |
| `json` | `true` | When `true`, emit the JSON report to stdout (also parsed for the `score` output). |
| `baseline` | (none) | Path to a previous `run.json` to score the diff against. |
| `path` | `.` | Repo path to scan. |
| `python-version` | `3.11` | Python version installed for the scanner. |
| `agent-readiness-version` | (latest) | Pin a specific `agent-readiness` PyPI version. |
| `upload-sarif` | `true` | When `sarif: true`, also upload via `github/codeql-action/upload-sarif`. |

## Outputs

| Name | Description |
|---|---|
| `score` | Overall agent-readiness score (0-100), parsed from JSON output. |
| `sarif-path` | Path to `findings.sarif` (only set when `sarif: true`). |

## Matrix example

```yaml
- uses: harrydaihaolin/agent-readiness-action@v1
  id: ar
  with:
    fail-below: 80
    json: true

- name: Comment score on PR
  if: github.event_name == 'pull_request'
  run: gh pr comment ${{ github.event.pull_request.number }} --body "Score: ${{ steps.ar.outputs.score }}"
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Versioning

This action follows the [GitHub Action floating major-tag convention](https://docs.github.com/en/actions/sharing-automations/creating-actions/about-custom-actions#using-release-management-for-actions):

- `harrydaihaolin/agent-readiness-action@v1` — floating tag; tracks latest v1.x.x.
- `harrydaihaolin/agent-readiness-action@v1.0.0` — pin a specific release.

## Development

```bash
make lint   # action-validator + actionlint
make test   # runs the action against tests/test-good-repo via act
```

## License

MIT. Same as upstream `agent-readiness`.
