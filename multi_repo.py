#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path

# Directory holding all the checkouts. This script lives in a repository that is
# itself checked out alongside them, so default to its parent and allow an
# override for anyone whose layout differs.
DEFAULT_BASE_DIR = Path(__file__).resolve().parent.parent


def main():
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
    fetch_args = ["git", "fetch", "origin"]
    checkout_master_args = ["git", "checkout", "main"]
    git_pull_args = ["git", "pull"]
    checkout_args = ["git", "checkout", "-b", "yaml-nextline"]
    # cp_args = ["cp", "../vws-cli/.github/workflows/dependabot-merge.yml", "./.github/workflows/dependabot-merge.yml"]
    git_add_args = ["git", "add", ".github"]
    git_commit_args = [
        "git",
        "commit",
        "--no-verify",
        "-m",
        "Avoid zizmor warning",
    ]
    git_push_args = ["git", "push"]
    gh_pr_create_args = ["gh", "pr", "create", "--fill"]
    gh_repo_view_args = ["gh", "pr", "view", "--web"]
    all_args = [
        fetch_args,
        checkout_master_args,
        ["git", "config", "pull.rebase", "false"],
        git_pull_args,
#       checkout_args,
#       ["uv", "run", "--all-extras", "pre-commit", "autoupdate"],
#       git_add_args,
#       git_commit_args,
#       git_push_args,
#       gh_pr_create_args,
#       gh_repo_view_args,
    ]
    for subdir_name in subdir_names:
        subdir = base_dir / subdir_name
        if not subdir.is_dir():
            print(f"{subdir_name}: no checkout at {subdir}, skipping")
            continue

        # This script used to `git reset --hard HEAD`, which silently threw away
        # uncommitted work. Skip dirty checkouts instead so nothing is lost.
        if _is_dirty(subdir=subdir):
            print(f"{subdir_name}: uncommitted changes, skipping")
            continue

        _delete_merged_branches(subdir=subdir)

        for args in all_args:
            try:
                subprocess.check_output(args=args, cwd=subdir)
            except subprocess.CalledProcessError as exc:
                print(exc)
                print("Exception in", subdir)


def _is_dirty(subdir: Path) -> bool:
    """Whether the checkout has uncommitted changes, staged or not."""
    result = subprocess.run(
        ["git", "status", "--porcelain"],
        capture_output=True,
        text=True,
        check=True,
        cwd=subdir,
    )
    return bool(result.stdout.strip())


def _delete_merged_branches(subdir: Path) -> None:
    result = subprocess.run(
        ["git", "branch", "--merged"],
        capture_output=True,
        text=True,
        check=True,
        cwd=subdir,
    )

    # Split the result into individual branch names
    branches = result.stdout.splitlines()

    # Filter out the current branch (marked with '*') and any excluded branches
    filtered_branches = [
        branch.strip()
        for branch in branches
        if not branch.startswith("*") and branch.strip() != "main" and not branch.startswith("+")
    ]

    if filtered_branches:
        # Branches can appear in `git branch --merged` yet still be rejected by `git branch -d`
        # (e.g. squash-merged or rebased PRs: merged into HEAD but not into their remote-tracking
        # ref). Batch `git branch -d` would abort the whole repo on the first refusal; delete
        # individually and continue so later repos and git steps still run.
        for branch in filtered_branches:
            proc = subprocess.run(
                ["git", "branch", "-d", branch],
                capture_output=True,
                text=True,
                cwd=subdir,
            )
            if proc.returncode != 0:
                msg = (proc.stderr or proc.stdout or "").strip()
                print(f"{subdir.name}: could not delete branch {branch!r}")
                if msg:
                    print(msg)


if __name__ == "__main__":
    main()
