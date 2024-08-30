{ config, pkgs, lib, ...}:
let
  # Fetch the Neovim configuration from a Git repository
  neovimConfig = builtins.fetchGit {
    url = "https://github.com/xmeatballx/nvim2.0.git";
    rev = "main";  # optional: specify a commit or branch
  };

  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    enable = true;
    extraLuaConfig = '' ${builtins.readFile "${neovimConfig}/init.lua"} '';
    extraPackages = with pkgs; [
      cmake
      gcc

      lua-language-server
      rnix-lsp
      nodePackages.typescript-language-server
      nodePackages.svelte-language-server
      efm-langserver
      emmet-ls
      vscode-langservers-extracted
      
      ripgrep
      xclip
      wl-clipboard
    ];
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      neo-tree-nvim
      bufferline-nvim
      comment-nvim
      efmls-configs-nvim
      vim-tmux-navigator
      # {
      # plugin = rustaceanvim;
      #  config = toLuaFile "${neovimConfig}/plugins/rust.lua";
      # }
      {
        plugin = vim-sleuth;
        config = toLua "require(\'bufferline\').setup()";
      }
      {
        plugin = indent-blankline-nvim;
        config = toLua "require(\'ibl\').setup()";
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile "${neovimConfig}/plugins/telescope.lua";
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile "${neovimConfig}/plugins/lsp.lua";
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile "${neovimConfig}/plugins/cmp.lua";
      }
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
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
        config = toLuaFile "${neovimConfig}/plugins/treesitter.lua";
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
