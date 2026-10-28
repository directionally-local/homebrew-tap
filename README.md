# Autopilot Homebrew Tap

Install Autopilot with Homebrew on macOS or Linux:

```sh
brew install directionally-local/tap/autopilot
autopilot
```

The formula installs Node.js 22 as a dependency. It is pinned to the published `autopilot-ai` npm tarball and verifies its SHA-256 checksum.

A scheduled workflow checks npm for new releases and opens a pull request to update the formula. Merge that PR to make the new version available through `brew upgrade autopilot`.
