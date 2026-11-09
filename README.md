# macOS dotfiles

This repository manages the Mac with nix-darwin and Home Manager. It follows
the same broad layout as [the reference dotfiles repository](https://github.com/kunchenguid/dotfiles),
but does not use a bootstrap script and does not manage Neovim or WezTerm.

## One-time preparation

Install Nix separately before the first activation. This configuration assumes
the Nix daemon is managed externally, such as by Determinate Nix.

Create the conventional repository link manually:

```sh
ln -sfn /path/to/this/checkout ~/.dotfiles
```

The Home Manager file links and the rebuild wrapper intentionally refer to
`~/.dotfiles`, not to a machine-specific checkout path.

## First activation

Review `configuration.nix`, especially the Homebrew inventory and the current
macOS defaults, then perform the first nix-darwin activation using the flake at
`~/.dotfiles#mac`.

The initial Homebrew configuration uses `cleanup = "none"` so that activation
does not uninstall anything. After the inventory has been reviewed, cleanup
can be tightened deliberately.

The active Ghostty configuration currently lives under macOS Application
Support. Home Manager manages that path from
`home/.config/ghostty/config`.

## Normal workflow

After the first activation:

```sh
~/.dotfiles/rebuild.sh
```

Changes to system settings, package lists, or Home Manager declarations require
a rebuild. The tmux and Ghostty files are linked from the repository.

## Project dependencies

Global command-line tools are declared in `home.nix`. Project-specific
dependencies should be declared in each project's own `flake.nix` and entered
with `nix develop` or direnv using a project `.envrc` containing `use flake`.
