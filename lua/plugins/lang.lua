-- ─────────────────────────────────────────────────────────────
-- Language specific plugins
-- ─────────────────────────────────────────────────────────────

return {
    -- Rust
    { "rust-lang/rust.vim" },
    { "simrat39/rust-tools.nvim" },

    -- Prisma
    {
        "prisma/vim-prisma",
        ft = "prisma",
    },
}
