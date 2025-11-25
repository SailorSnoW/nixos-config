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

      initLua = ''
        require('config')
        require('lz.n').load('plugins')
      '';

      plugins = {
        start = with pkgs.vimPlugins; [
          lz-n
          nvim-lspconfig
          blink-cmp
          mini-icons
          todo-comments-nvim
        ];

        # Anything that you're lazy loading should be put here
        opt = with pkgs.vimPlugins; [
          snacks-nvim
          nvim-lint
          conform-nvim
          which-key-nvim
          gitsigns-nvim
          trouble-nvim
          roslyn-nvim
          lazydev-nvim
          grug-far-nvim
          mini-pairs
          # lualine-nvim
          mini-statusline
          nvim-treesitter.withAllGrammars
          render-markdown-nvim
          (rustaceanvim.overrideAttrs { doCheck = false; })
          rose-pine
          noice-nvim
        ];

        dev.config = {
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
