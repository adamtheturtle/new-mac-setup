#!/usr/bin/env bash
# Set up GitHub MCP Server for Claude Code
# See: https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md
#
# SECRETS: This script never contains your PAT. Set it before running:
#   export GITHUB_PAT='your_token_here'

set -euo pipefail

if ! command -v claude &>/dev/null; then
    echo "Error: Claude Code CLI not found. Install it first (e.g. via Zed)."
    exit 1
fi

GITHUB_PAT="${GITHUB_PAT:-${GITHUB_PERSONAL_ACCESS_TOKEN:-}}"

if [[ -z "${GITHUB_PAT:-}" ]]; then
    echo "Error: GITHUB_PAT not set."
    echo ""
    echo "Set your GitHub Personal Access Token before running:"
    echo "  export GITHUB_PAT='your_token_here'"
    echo "  bash $0"
    echo ""
    echo "Create a PAT at: https://github.com/settings/personal-access-tokens/new"
    echo "Scopes: repo, read:org"
    exit 1
fi

# Remove existing server if present (idempotent)
claude mcp remove github 2>/dev/null || true

# Add GitHub MCP server (remote HTTP - no Docker required)
claude mcp add-json github '{"type":"http","url":"https://api.githubcopilot.com/mcp","headers":{"Authorization":"Bearer '"$GITHUB_PAT"'"}}' --scope user

echo "GitHub MCP server configured. Restart Claude Code and run 'claude mcp list' to verify."
