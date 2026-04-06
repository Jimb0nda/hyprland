return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      { "nvim-lua/plenary.nvim" },
      { "github/copilot.vim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
      allow_insecure = false,
      proxy = nil,
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
      window = {
        layout = "float",
        relative = "cursor",
        width = 0.8,
        height = 0.8,
        row = 1,
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
          normal = "<C-y>",
          insert = "<C-y>",
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
      require("CopilotChat").setup(opts)
      
      -- Keybindings for CopilotChat (simplified to use working commands)
      local map = vim.keymap.set
      map("n", "<leader>cpt", "<cmd>CopilotChatToggle<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpe", "<cmd>CopilotChat Explain this code<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpf", "<cmd>CopilotChat Fix this code<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpd", "<cmd>CopilotChat Write documentation for this<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpr", "<cmd>CopilotChat Review this code<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpo", "<cmd>CopilotChat Optimize this code<CR>", { noremap = true, silent = true })
      map("n", "<leader>cpx", "<cmd>CopilotChat Write tests for this<CR>", { noremap = true, silent = true })
      map("n", "<leader>cph", "<cmd>CopilotChat Refactor this code<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpe", "<cmd>CopilotChat Explain this code<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpf", "<cmd>CopilotChat Fix this code<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpd", "<cmd>CopilotChat Write documentation for this<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpr", "<cmd>CopilotChat Review this code<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpo", "<cmd>CopilotChat Optimize this code<CR>", { noremap = true, silent = true })
      map("v", "<leader>cpx", "<cmd>CopilotChat Write tests for this<CR>", { noremap = true, silent = true })
      map("v", "<leader>cph", "<cmd>CopilotChat Refactor this code<CR>", { noremap = true, silent = true })
    end,
  },
}
