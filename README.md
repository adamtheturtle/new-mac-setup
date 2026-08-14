# New Mac setup

## About This Mac

## System Settings

In System Settings, set the following settings:

* Apple ID
    * iCloud
        * Turn off Optimise Mac Storage
* Keyboard
    * Modifier Keys
        * Caps Lock: Escape (also do this for a connected external keyboard)
    * Text
        * Expand `eemail` to my email (maybe done automatically by iCloud)
    * Shortcuts
        * Select "Use keyboard navigation to move focus between controls"
        * Spotlight > Untick "Show Spotlight search"
        * Turn off Mission Control shortcuts
* Dock & Menubar
    * Tick "Automatically hide and show the dock"
    * Untick "Magnification"
    * Position on screen: Left
    * Untick "Show recent applications in Dock"
* Clock > Show date
* Sound > Show in menubar always
* Bluetooth > Show in menubar
* Trackpad
    * Tap to click
* Mouse (needs mouse connected)
    * Secondary click
    * More Gestures > Swipe between pages
* Internet Accounts
    * Sign in and enable accounts
* Wallet and Apple Pay
    * Set up cards

## Install and configure software

Start automated setup:

```bash
curl -O https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/setup.sh
sudo echo 1 # this will cache the password
bash setup.sh # this will stop when Xcode needs to be installed. Run it again after that:
bash setup.sh
```

* Install iGlasses (private download link in email)
* Set up printer

### Notification Center

* Add Reminders Widgets

### Finder

* Ctrl + click on the Desktop > Show View Options > Sort by "Name".
* View > Show Path Bar.
* View > Show Status Bar.
* Move "cd to" from Applications to the toolbar.
* Add `/Users/<user>` to the Finder sidebar.
* Settings > General > New Finder windows show: `<user>`

### Messages

Settings > iMessage > Enable Messages in iCloud.

### Calendar

* Choose to Sync with iCloud.
* Settings > General > Untick "Show Birthdays calendar".
* Settings > Accounts > Enable accounts.
* Settings > Advanced > Turn on timezone support.
* Subscribe to Inview calendar.

### 1Password

* Settings > General > Format secure notes using Markdown
* Settings > Developer > Use the SSH agent
* Settings > Developer > Connect with 1Password CLI
* Settings > Autofill > Set up macOS AutoFill > Turn On
* Set up the [1Password shell plugin for GitHub](https://developer.1password.com/docs/cli/shell-plugins/github/):
    * Create a GitHub personal access token and save it in 1Password.
    * Run `op plugin init gh` and choose the token as the global default.
    * Add the `source ~/.config/op/plugins.sh` command printed by `op plugin init`
      to `~/.config/fish/config.fish`.
    * Open a new shell and confirm that `gh auth status` succeeds after authenticating
      with 1Password.

### Safari

Install Safari extensions:

* 1Password
* 1Blocker

Settings > Advanced > Tick "Show full website address".
Settings > Advanced > Tick "Show Develop in menubar".

### TextMate

* Settings > Bundles > reStructuredText, YAML.
* View > Wrap Column > 80.
* View > Show Wrap Column.

### Reeder Classic

* Settings > Accounts > Add Feedbin.
* Settings > General > App Icon > Don't display Unread Count.
* Settings > General > Open links in default browser.
* Settings > General > Open links in background.
* Settings > General > Group items by feed.

### SSH Keys

* Move SSH Keys from `SSH Keys` from 1Password to `~/.ssh`.
* `ssh-add ~/.ssh/id_rsa` (use password from 1Password).

### iPhone

* Set up text message forwarding.

### CodeRunner

For Python, change "Run Settings..." > "Run command" to "uv run $filename"

### VSCode

* Turn on Settings sync
* Install extensions:
    * `ruff`
    * `python`
    * `vim`
    * Copilot

### Zed

* Install Claude Code
* Set Accept Edits as the default mode for Claude Code (cmd + select it)
* Install the `Cursor Theme` extension from the Extension Gallery (`cmd-shift-x`).
* Install Astral's Claude Code plugin, which provides the `ty` Python language server
  (and requires `uvx`, installed by the `uv` Homebrew formula):

```bash
claude plugin marketplace add astral-sh/claude-code-plugins
claude plugin install astral@astral-sh
```

### GitHub MCP Server (Claude Code)

Enables GitHub integration (repos, issues, PRs) in Claude Code. **No secrets in this repo.**

1. Create a [GitHub Personal Access Token](https://github.com/settings/personal-access-tokens/new) with `repo` and `read:org` scopes.
2. Export the token, then run the setup script:

```bash
export GITHUB_PAT='your_token_here'
bash <(curl -fsSL https://raw.githubusercontent.com/adamtheturtle/new-mac-setup/master/scripts/setup-github-mcp.sh)
```

Or with a local clone:

```bash
export GITHUB_PAT='your_token_here'
bash scripts/setup-github-mcp.sh
```

3. Restart Claude Code. Verify with `claude mcp list`.

### Logins

* Open every app in 'Applications', and log in / link devices
    * Start with WhatsApp, Slack

## After iCloud Drive download complete

### Alfred

* Add the Powerpack license.
* Advanced > Set Preferences folder... `/Users/Adam/Library/Mobile Documents/com~apple~CloudDocs/Alfred/Alfred.alfredpreferences`
* General > Request Permissions (grant permissions)
* Features > Clipboard > Keep history
* Features > 1Password > Enable 1Password bookmarks.
* Features > Web Bookmarks > Enable Safari Bookmarks.
* [Set up the Google Drive workflow](https://github.com/azai91/alfred-drive-workflow/issues/69#issuecomment-599150203)
