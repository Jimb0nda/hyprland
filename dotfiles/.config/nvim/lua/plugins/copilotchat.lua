return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "github/copilot.vim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
      allow_insecure = false,
      timeout = 30000,
      temperature = 0.1,
      model = "claude-haiku-4.5",
      max_tokens = 2048,

      show_help = true,
      show_folds = true,
      highlight_selection = true,
      highlight_insertion = true,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      insert_at_end = false,
      clear_chat_on_new_prompt = false,

      -- make read-only workspace inspection frictionless
      trusted_tools = { "file", "glob", "grep" },

      window = {
        layout = "vertical",
        width = 0.4,
        relative = "editor",
        border = "single",
      },

      mappings = {
        complete = {
          detail = "Use @<message> to invoke prompt",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-m>",
        },
        accept_diff = {
          normal = "ad",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },

    config = function(_, opts)
      vim.opt.splitright = true

      local chat = require("CopilotChat")
      chat.setup(opts)

      local map = vim.keymap.set

      -- Open chat with current buffer + workspace tools as sticky context
      map("n", "<leader>cpt", function() chat.open({sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })

      -- Ask against current buffer
      map("n", "<leader>cpr", function() chat.ask("Review this code", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cpe", function() chat.ask("Explain this code", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cpf", function() chat.ask("Fix this code", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cpd", function() chat.ask("Write documentation for this", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cpo", function() chat.ask("Optimize this code", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cpx", function() chat.ask("Write tests for this", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })
      map("n", "<leader>cph", function() chat.ask("Refactor this code", {sticky = { "#buffer:listed", "@copilot" },})
        end, { noremap = true, silent = true })

      -- Visual mode: use the selected code, but still allow workspace inspection
      map("v", "<leader>cpr", function() chat.ask("Review this code", {
          selection = require("CopilotChat.select").visual,
          sticky = { "@copilot" },
        })
      end, { noremap = true, silent = true })
    end,
  },
}
