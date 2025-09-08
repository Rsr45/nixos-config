{ ... }:
{
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspkind.enable = true;
      trouble.enable = true;
    };
    visuals.fidget-nvim.enable = true;
  };
}
