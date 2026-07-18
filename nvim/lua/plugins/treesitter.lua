return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core
        "lua",
        "vim",
        "vimdoc",

        -- Flutter
        "dart",

        -- Backend
        "java",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",

        -- Config
        "json",
        "yaml",
        "toml",

        -- Scripting
        "bash",
        "python",

        -- Docs
        "markdown",
        "markdown_inline",

        -- Git
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",

        -- Regex
        "regex",
      },
    },
  },
}
