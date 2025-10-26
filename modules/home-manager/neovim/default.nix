{
  inputs,
  pkgs,
  ...
}:
{

  imports = [ inputs.mnw.homeManagerModules.default ];
  config = {

    programs.mnw = {
      enable = true;

      luaFiles = [ ./init.lua ];

      plugins = {
        start = with pkgs.vimPlugins; [
          lazy-nvim
          nvim-lint
          nvim-lspconfig
          snacks-nvim
          lualine-nvim
          which-key-nvim
          blink-cmp
          bufferline-nvim
          conform-nvim
          gitsigns-nvim
          grug-far-nvim
          lazydev-nvim
          mini-icons
          mini-pairs
          noice-nvim
          render-markdown-nvim
          rose-pine
          roslyn-nvim
          (rustaceanvim.overrideAttrs { doCheck = false; })
          todo-comments-nvim
          trouble-nvim
          helm-ls-nvim
          nvim-treesitter.withAllGrammars
        ];

        # Anything that you're lazy loading should be put here
        opt = [ ];

        dev.myconfig = {
          # you can use lib.fileset to reduce rebuilds here
          # https://noogle.dev/f/lib/fileset/toSource
          pure = ./.;
          impure =
            # This is a hack it should be a absolute path
            # here it'll only work from this directory
            "/' .. vim.uv.cwd()";
        };
      };

      extraBinPath = with pkgs; [
        universal-ctags
        curl
        ripgrep
        fd
        tectonic
        imagemagick
        mermaid-cli
        prettierd
        shfmt
        stdenv.cc.cc

        lua-language-server
        stylua

        nixd
        nixfmt-rfc-style
      ];

      aliases = [ "vim" ];
    };
  };
}
