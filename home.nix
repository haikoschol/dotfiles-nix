{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    bat
    gh
    gnupg
    ripgrep
    fd
    jq
    eza
    tree
    tmux
    pinentry-tty
    pinentry_mac
    python314
    rtk
    wget
    nerd-fonts.sauce-code-pro
    direnv
    nix-direnv
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ./home/zsh/init.zsh;
    shellAliases = {
      ll = "eza -l --icons --git";
      sweep-cargo = "cargo sweep --toolchains $(rustup default | cut -d \" \" -f 1) -r";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # These links make the checked-in files the live configuration files. The
  # user-owned ~/.dotfiles symlink should point at this repository.
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.tmux.conf";

  # Ghostty's macOS Application Support path takes precedence over its XDG
  # path, so manage the active path directly while keeping the source in home/.
  home.file."Library/Application Support/com.mitchellh.ghostty/config".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/ghostty/config";
}
