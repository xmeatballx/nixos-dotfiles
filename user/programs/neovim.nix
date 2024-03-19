{ config, pkgs, lib, ...}:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    enable = true;
    extraLuaConfig = '' ${builtins.readFile ../config/nvim/init.lua} '';
    extraPackages = with pkgs; [
      cmake
      gcc

      lua-language-server
      rnix-lsp
      nodePackages.typescript-language-server
      nodePackages.svelte-language-server
      
      ripgrep
      xclip
      wl-clipboard
    ];
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      neo-tree-nvim
      {
        plugin = bufferline-nvim;
        config = '' '';
      }
      {
        plugin = vim-sleuth;
        config = toLua "require(\'bufferline\').setup()";
      }
      {
        plugin = comment-nvim;
        config = '' '';
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ../config/nvim/plugins/telescope.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ../config/nvim/plugins/lsp.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-css
          p.tree-sitter-html
          p.tree-sitter-javascript
          p.tree-sitter-typescript
          p.tree-sitter-svelte
        ]));
        config = toLuaFile ../config/nvim/treesitter.lua;
      }
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-mocha";
      }
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
