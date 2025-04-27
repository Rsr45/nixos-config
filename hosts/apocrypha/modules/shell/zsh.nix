{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    history = {
      append = true;
      share = true;
      extended = true;
      ignoreSpace = true;
      ignoreAllDups = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    # antidote = {
    #   enable = true;
    #   plugins = [
    #     # "getantidote/use-omz"
    #     # "zsh-users/zsh-syntax-highlighting"
    #     # "zsh-users/zsh-autosuggestions"
    #     # "zsh-users/zsh-completions"
    #     # "zsh-users/zsh-history-substring-search"
    #     "MichaelAquilina/zsh-auto-notify"
    #   ];
    # };

    # oh-my-zsh = {
    #   enable = true;
    #   theme = "bureau";
    #   plugins = [
    #     "git"
    #     "sudo"
    #   ];
    # };
  };
}
