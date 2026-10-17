{config, ...}: {
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    starship = {
      enableNushellIntegration = true;
    };

    eza = {
      enableNushellIntegration = true;
    };

    zoxide = {
      enableNushellIntegration = true;
    };
  };

  programs.nushell = {
    enable = true;

    settings = {
      show_banner = false;
      buffer_editor = "nvim";
      abbreviations = config.home.shellAliases;
    };

    envFile.text = ''
      $env.CARAPACE_BRIDGES = 'fish,inshellisense'
      $env.TRANSIENT_PROMPT_COMMAND = ^starship module character
    '';

    configFile.text = ''
      # General =====================================================================
      $env.config.show_banner = false
      $env.config.bracketed_paste = true

      # Table view
      $env.config.table.mode = 'compact_double'
      $env.config.table.header_on_separator = true
      $env.config.table.missing_value_symbol = '×'
      $env.config.table.trim = { methodology: "truncating", truncating_suffix: "…" }

      $env.config.datetime_format.table = "%Y-%m-%d %H:%M:%S"
      $env.config.datetime_format.normal = "%Y-%m-%d %H:%M:%S"

      $env.config.completions.algorithm = "fuzzy"

      # Vi mode =====================================================================
      $env.config.edit_mode = 'vi'
      $env.config.cursor_shape.vi_insert = 'line'
      $env.config.cursor_shape.vi_normal = 'block'
    '';
  };
}
