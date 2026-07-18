local map = vim.keymap.set

map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git Blame" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous Hunk" })

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>du", dapui.toggle)
