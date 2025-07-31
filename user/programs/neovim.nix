{ config, pkgs, lib, ...}:
let
  # Fetch the Neovim configuration from GitHub
  neovimConfig = pkgs.fetchFromGitHub {
    owner = "xmeatballx";  # Replace with your GitHub username
    repo = "nvim2.0";  # Replace with your repository name
    rev = "main";  # The branch you want to track
    sha256 = "sha256-IuprWj4uqXc+Td8GK68xVjW8EGB+TDP1CXiHmkG0I5A=";
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
      nil
      phpactor
      typescript-language-server
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
      wrapping-nvim
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
        config = toLuaFile "${neovimConfig}/plugins/lspconfig.lua";
      }
      {
        plugin = nvim-cmp;
        config = toLuaFile "${neovimConfig}/plugins/cmp.lua";
      }
      {
        plugin = wrapping-nvim;
        config = toLua "require(\'wrapping\').setup()";
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
        config = toLuaFile "${neovimConfig}/plugins/nvim-treesitter.lua";
      }
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
