#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys
from pathlib import Path

# Directory holding all the checkouts. This script lives in a repository that is
# itself checked out alongside them, so default to its parent and allow an
# override for anyone whose layout differs.
DEFAULT_BASE_DIR = Path(__file__).resolve().parent.parent


def main() -> int:
    parser = argparse.ArgumentParser(description="Fast-forward the default branch of each checkout.")
    parser.add_argument(
        "--prune-merged",
        action="store_true",
        help="delete local branches already merged into the remote default branch",
    )
    args = parser.parse_args()
    base_dir = Path(os.environ.get("MULTI_REPO_BASE", DEFAULT_BASE_DIR))
    subdir_names = [
        "click-compose",
        "coderpad-api-mock",
        "coderpad-api-python",
        "Coding-Project-TODOs",
        "doccmd",
        "doccmd-pre-commit",
        "homebrew-vws",
        "internal-tools",
        "literalizer",
        "literalizer-cli",
        "literalizer-cli-pre-commit",
        "mypy-strict-kwargs",
        "openapi-mock",
        "pip-check-reqs",
        "plex-configuration",
        "requests-mock-flask",
        "resumes",
        "sphinx-combine",
        "sphinx-confluencebuilder-bridge",
        "sphinx-indent",
        "sphinx-literalizer",
        "sphinx-notionbuilder",
        "sphinx-substitution-extensions",
        "sybil-extras",
        "vws-auth-tools",
        "vws-cli",
        "vws-python",
        "vws-python-mock",
        "vws-test-fixtures",
        "vws-web-tools",
        "wiremock-mock",
    ]
    failed = False
    for subdir_name in subdir_names:
        subdir = base_dir / subdir_name
        if not (subdir / ".git").exists():
            print(f"{subdir_name}: no checkout at {subdir}, skipping")
            continue

        try:
            if _git(subdir, "status", "--porcelain"):
                print(f"{subdir_name}: uncommitted changes, skipping")
                continue

            _git(subdir, "fetch", "origin")
            _git(subdir, "remote", "set-head", "origin", "--auto")
            remote_branch = _git(subdir, "symbolic-ref", "--short", "refs/remotes/origin/HEAD")
            default_branch = remote_branch.removeprefix("origin/")
            _git(subdir, "switch", default_branch)
            _git(subdir, "merge", "--ff-only", remote_branch)
        except subprocess.CalledProcessError as exc:
            _report_error(subdir, exc)
            failed = True
            continue

        if args.prune_merged:
            try:
                failed |= _delete_merged_branches(subdir, default_branch, remote_branch)
            except subprocess.CalledProcessError as exc:
                _report_error(subdir, exc)
                failed = True

    return int(failed)


def _git(subdir: Path, *args: str) -> str:
    return subprocess.run(
        ["git", *args],
        cwd=subdir,
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip("\n")


def _report_error(subdir: Path, error: subprocess.CalledProcessError) -> None:
    message = (error.stderr or error.stdout or "").strip()
    print(f"{subdir.name}: {error}", file=sys.stderr)
    if message:
        print(message, file=sys.stderr)


def _delete_merged_branches(subdir: Path, default_branch: str, remote_branch: str) -> bool:
    branches = _git(
        subdir,
        "branch",
        "--merged",
        remote_branch,
        "--format=%(refname:short)%09%(worktreepath)",
    )
    failed = False
    for line in branches.splitlines():
        branch, _, worktree = line.partition("\t")
        if branch == default_branch or worktree:
            continue
        try:
            _git(subdir, "branch", "-d", "--", branch)
        except subprocess.CalledProcessError as exc:
            _report_error(subdir, exc)
            failed = True
    return failed


if __name__ == "__main__":
    raise SystemExit(main())
