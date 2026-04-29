"""Trivial CLI entry point so the smoke fixture has a runnable surface."""

from __future__ import annotations

import argparse


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="good")
    parser.add_argument("--name", default="world")
    args = parser.parse_args(argv)
    print(f"hello, {args.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
