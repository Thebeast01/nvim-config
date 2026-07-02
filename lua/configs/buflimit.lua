-- ─────────────────────────────────────────────────────────────
-- Buffer limit (tabufline tabs)
-- ─────────────────────────────────────────────────────────────
-- Keep at most MAX_BUFS buffers open in NvChad's tabufline. When a new
-- buffer pushes the count past the limit, the least-recently-used buffer
-- that is NOT currently active is closed to make room.
--
-- A buffer is only evicted if it is safe to drop: not the active buffer,
-- not visible in any split, and not modified (so unsaved work is never lost).

local M = {}

local MAX_BUFS = 3

-- Recency bookkeeping: a higher tick means more recently used.
local tick = 0
local last_used = {}

local function touch(bufnr)
    tick = tick + 1
    last_used[bufnr] = tick
end

local function is_visible(bufnr)
    return vim.fn.bufwinid(bufnr) ~= -1
end

local function enforce_limit()
    local bufs = vim.t.bufs
    if not bufs then
        return
    end

    -- Only count valid, listed buffers (the ones shown as tabs).
    bufs = vim.tbl_filter(function(b)
        return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
    end, bufs)

    if #bufs <= MAX_BUFS then
        return
    end

    local current = vim.api.nvim_get_current_buf()

    -- Buffers we are allowed to evict: not active, not visible, not modified.
    local candidates = {}
    for _, b in ipairs(bufs) do
        if b ~= current and not is_visible(b) and not vim.bo[b].modified then
            table.insert(candidates, b)
        end
    end

    -- Oldest (least recently used) first.
    table.sort(candidates, function(a, b)
        return (last_used[a] or 0) < (last_used[b] or 0)
    end)

    local to_remove = #bufs - MAX_BUFS
    for i = 1, math.min(to_remove, #candidates) do
        local b = candidates[i]
        last_used[b] = nil
        -- The buffer isn't displayed, so deleting it won't disturb the
        -- active window. NvChad's BufDelete autocmd drops it from vim.t.bufs.
        pcall(vim.api.nvim_buf_delete, b, {})
    end
end

local group = vim.api.nvim_create_augroup("BufLimit", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(args)
        if vim.bo[args.buf].buflisted then
            touch(args.buf)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
    group = group,
    callback = function()
        -- Defer so NvChad's own tabufline autocmds finish updating
        -- vim.t.bufs before we read and trim it.
        vim.schedule(enforce_limit)
    end,
})

vim.api.nvim_create_autocmd("BufDelete", {
    group = group,
    callback = function(args)
        last_used[args.buf] = nil
    end,
})

return M
