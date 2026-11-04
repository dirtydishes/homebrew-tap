# dirtydishes/tap

Homebrew tap for [gh-forgejo-shim](https://github.com/dirtydishes/gh-forgejo-shim), which lets
the GitHub CLI and the tools built on it work with Forgejo repositories.

```sh
brew install dirtydishes/tap/gh-forgejo-shim
gfj bootstrap
```

The formula installs `gh-forgejo-shim` and `gfj` from the project's release archives, and the
GitHub CLI as a dependency. It's rendered from
[`packaging/homebrew/Formula/gh-forgejo-shim.rb.template`](https://github.com/dirtydishes/gh-forgejo-shim/blob/main/packaging/homebrew/Formula/gh-forgejo-shim.rb.template)
for each release.
