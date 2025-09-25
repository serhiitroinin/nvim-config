return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Test adapters
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-vitest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest")({
          vitestCommand = "npx vitest",
          env = { CI = true },
        }),
      },
      consumers = {},
      default_strategy = "integrated",
      diagnostic = {
        enabled = true,
        severity = 1,
      },
      discovery = {
        concurrent = 0,
        enabled = true,
      },
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },
      highlights = {
        adapter_name = "NeotestAdapterName",
        border = "NeotestBorder",
        dir = "NeotestDir",
        expand_marker = "NeotestExpandMarker",
        failed = "NeotestFailed",
        file = "NeotestFile",
        focused = "NeotestFocused",
        indent = "NeotestIndent",
        marked = "NeotestMarked",
        namespace = "NeotestNamespace",
        passed = "NeotestPassed",
        running = "NeotestRunning",
        select_win = "NeotestWinSelect",
        skipped = "NeotestSkipped",
        target = "NeotestTarget",
        test = "NeotestTest",
        unknown = "NeotestUnknown",
        watching = "NeotestWatching",
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "",
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        skipped = "",
        unknown = "",
        watching = "",
      },
      jump = {
        enabled = true,
      },
      log_level = 3,
      output = {
        enabled = true,
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      projects = {},
      quickfix = {
        enabled = false,
        open = false,
      },
      run = {
        enabled = true,
      },
      running = {
        concurrent = true,
      },
      state = {
        enabled = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },
      summary = {
        animated = true,
        count = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
          watch = "w",
        },
        open = "botright vsplit | vertical resize 50",
      },
      watch = {
        enabled = true,
        symbol_queries = {
          go = "        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (call_expression function: (identifier) @symbol)\n      ",
          javascript = "  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Captures namespaced import\n  (namespace_import (identifier) @symbol)\n  ;Captures require()\n  (variable_declarator\n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function (#eq? @function \"require\")))\n  ;Capture function and method calls\n  (call_expression function: (identifier) @symbol)\n  (call_expression\n  function: (member_expression\n    property: (property_identifier) @symbol))\n  ;Capture constructor calls\n  (new_expression\n    constructor: (identifier) @symbol)\n",
          lua = '        ;query\n        ;Captures module names in require()\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n        ;Captures function calls\n        (function_call\n          name: (identifier) @symbol)\n        (function_call\n          name: (dot_index_expression field: (identifier) @symbol))\n      ',
          python = "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol)+)\n        (import_statement (_ (identifier) @symbol)+)\n        ;Captures function calls\n        (call\n          function: [\n            (identifier) @symbol\n            (attribute attribute: (identifier) @symbol)\n          ]\n        )\n      ",
          rust = "        ;query\n        ;Captures imports\n        (use_declaration\n          argument: (scoped_identifier\n            name: (identifier) @symbol))\n        (use_declaration\n          argument: (identifier) @symbol)\n        (use_as_clause alias: (identifier) @symbol)\n        ;Captures macro calls\n        (macro_invocation\n          macro: (identifier) @symbol)\n        ;Captures function calls\n        (call_expression\n          function: (identifier) @symbol)\n        (call_expression\n          function: (scoped_identifier\n            name: (identifier) @symbol))\n        (call_expression\n          function: (field_expression\n            field: (field_identifier) @symbol))\n        ;Captures method calls\n        (method_call_expression\n          name: (field_identifier) @symbol)\n      ",
          tsx = "  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Captures namespaced import\n  (namespace_import (identifier) @symbol)\n  ;Captures require()\n  (variable_declarator\n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function (#eq? @function \"require\")))\n  ;Capture function and method calls\n  (call_expression function: (identifier) @symbol)\n  (call_expression\n  function: (member_expression\n    property: (property_identifier) @symbol))\n  ;Capture constructor calls\n  (new_expression\n    constructor: (identifier) @symbol)\n  ;Capture JSX component tags\n  (jsx_opening_element name: (identifier) @symbol)\n  (jsx_closing_element name: (identifier) @symbol)\n  (jsx_self_closing_element name: (identifier) @symbol)\n",
          typescript = "  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Captures namespaced import\n  (namespace_import (identifier) @symbol)\n  ;Captures require()\n  (variable_declarator\n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function (#eq? @function \"require\")))\n  ;Capture function and method calls\n  (call_expression function: (identifier) @symbol)\n  (call_expression\n  function: (member_expression\n    property: (property_identifier) @symbol))\n  ;Capture constructor calls\n  (new_expression\n    constructor: (identifier) @symbol)\n",
        },
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>tt", function()
      neotest.run.run()
    end, { desc = "Run nearest test" })

    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current file tests" })

    vim.keymap.set("n", "<leader>ta", function()
      neotest.run.run(vim.fn.getcwd())
    end, { desc = "Run all tests" })

    vim.keymap.set("n", "<leader>ts", function()
      neotest.run.stop()
    end, { desc = "Stop test" })

    vim.keymap.set("n", "<leader>to", function()
      neotest.output.open({ enter = true, auto_close = true })
    end, { desc = "Show test output" })

    vim.keymap.set("n", "<leader>tO", function()
      neotest.output_panel.toggle()
    end, { desc = "Toggle test output panel" })

    vim.keymap.set("n", "<leader>ti", function()
      neotest.summary.toggle()
    end, { desc = "Toggle test summary" })

    vim.keymap.set("n", "<leader>tw", function()
      neotest.watch.toggle(vim.fn.expand("%"))
    end, { desc = "Toggle test watch mode" })

    -- Jump to test
    vim.keymap.set("n", "<leader>jt", function()
      neotest.jump.next({ status = "failed" })
    end, { desc = "Jump to next failed test" })

    vim.keymap.set("n", "<leader>jT", function()
      neotest.jump.prev({ status = "failed" })
    end, { desc = "Jump to previous failed test" })

    -- Set up highlights
    vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#10B981" })
    vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#EF4444" })
    vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#FBBF24" })
    vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#6B7280" })
  end,
}
