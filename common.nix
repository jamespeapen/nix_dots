{ config, pkgs, ... }:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "james.eapen";
  home.homeDirectory = "/home/james.eapen";

  # packages
  home.packages = with pkgs; [
    delta
    entr
    exa
    fd
    gcc                             # for neovim treesitter compilation
    isync
    msmtp
    oath-toolkit
    (pass.withExtensions (ext: with ext; [
      pass-tomb
    ]))
    ripgrep
    youtube-dl
    zoxide
  ];

  programs = {

    # neovim
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          neovim
          jedi-language-server
        ]))
      ];
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };

  }

  # config 

  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/nvim;
      recursive = true;
    };
    "git" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/git;
      recursive = true;
    };
    "zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink ~/Documents/dotfiles/config/zsh;
      recursive = true;
    };
  };

}

# vim:set et sw=2 ts=2:
