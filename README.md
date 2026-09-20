# vemonet tap

## Install the casks

```sh
brew install --cask vemonet/tap/<cask>
```

Or `brew tap vemonet/tap` and then `brew install --cask <cask>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "vemonet/tap"
cask "<cask>"
```

## typodown

[Typodown](https://typodown.app) markdown editor with live preview, from
[vemonet/typodown](https://github.com/vemonet/typodown).

```sh
brew install --cask vemonet/tap/typodown
```

The app is signed ad-hoc rather than with an Apple Developer ID, so the cask drops the quarantine
flag after install and Gatekeeper does not block the first launch. The cask is bumped daily by
[bump.yml](.github/workflows/bump.yml).

## alt-tab-pro

Unsigned builds of [alt-tab-macos](https://github.com/lwouis/alt-tab-macos) with the Pro features
enabled, mirrored from [vemonet/alt-tab-macos-free](https://github.com/vemonet/alt-tab-macos-free).

```sh
brew install --cask vemonet/tap/alt-tab-pro
```

The cask drops the quarantine flag after install, so Gatekeeper does not block the self-signed
build. `brew upgrade --cask alt-tab-pro` follows the mirror releases; the cask itself is bumped
daily by [bump.yml](.github/workflows/bump.yml).
