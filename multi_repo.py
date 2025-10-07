#!/usr/bin/env python3

import subprocess
from pathlib import Path

def main():
	base_dir = Path("/Users/adam/Documents/repositories/")
	subdir_names = [
		"sybil-extras",
		"doccmd",
		"doccmd-pre-commit", #
		"requests-mock-flask",  #
		"mypy-strict-kwargs",
		"sphinx-substitution-extensions",
		"vws-auth-tools",
		"vws-python",
		"vws-test-fixtures",  #
		"vws-web-tools",  #
		"vws-cli",
		"vws-python-mock",
		"sphinx-combine",
		"sphinx-confluencebuilder-bridge",
		"sphinx-notionbuilder",
	]
	fetch_args = ["git", "fetch", "origin"]
	checkout_master_args = ["git", "checkout", "main"]
	git_pull_args = ["git", "pull"]
	checkout_args = ["git", "checkout", "-b", "vscode-test-settings"]
    # cp_args = ["cp", "../vws-cli/.github/workflows/dependabot-merge.yml", "./.github/workflows/dependabot-merge.yml"]
	git_add_args = ["git", "add", "pyproject.toml"]
	git_commit_args = ["git", "commit", "-am", "Configure VSCode to run tests in its UI"]
	git_push_args = ["git", "push"]
	gh_pr_create_args = ["gh", "pr", "create", "--fill"]
	gh_repo_view_args = ["gh", "pr", "view", "--web"]
	all_args = [
		fetch_args,
		checkout_master_args,
#		["git", "reset", "--hard", "HEAD"],
#		["git", "config", "pull.rebase", "false"],
#		git_pull_args,
#		checkout_args,
#		["pre-commit", "autoupdate"],
#		git_add_args,
#		git_commit_args,
#		git_push_args,
#		gh_pr_create_args,
#		gh_repo_view_args,
	]
	for subdir_name in subdir_names:
		subdir = base_dir / subdir_name
		_delete_merged_branches(subdir=subdir)

		for args in all_args:
			try:
				subprocess.check_output(args=args, cwd=subdir)
			except subprocess.CalledProcessError as exc:
				print(exc)
				print("Exception in", subdir)

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
		branch.strip() for branch in branches
		if not branch.startswith("*") and branch.strip() != "main"
	]
	
	if filtered_branches:
		subprocess.run(
			["git", "branch", "-d", *filtered_branches], 
			check=True,
			cwd=subdir,
		)

if __name__ == "__main__":
	main()
	
