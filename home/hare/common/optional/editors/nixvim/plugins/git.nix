{ ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>gg";
        mode = "n";
        action = "<cmd>Git<CR>";
        options = {
          desc = "Git";
        };
      }
      {
        key = "<leader>gp";
        mode = "n";
        action = "<cmd>Git push<CR>";
        options = {
          desc = "Push";
        };
      }
      {
        key = "<leader>ga";
        mode = "n";
        action = "<cmd>Git add %:p<CR>";
        options = {
          desc = "Add";
        };
      }
    ];
    plugins = {
      fugitive.enable = true;
      mini-git.enable = true;
    };
  };
}
