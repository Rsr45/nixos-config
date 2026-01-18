{ ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>gg";
        mode = "n";
        action = "<cmd>Neogit<CR>";
        options = {
          desc = "Open Neogit";
        };
      }
      {
        key = "<leader>tg";
        mode = [ "n" ];
        action = "<cmd>lua Snacks.lazygit.open()<CR>";
        options.desc = "Lazygit";
      }
    ];
    plugins = {
      neogit.enable = true;
      snacks.settings = {
        lazygit.enabled = true;
        git.enabled = true;
      };
      fugitive.enable = true;
      gitsigns.enable = false;
      mini-git.enable = true;
    };
  };
}
