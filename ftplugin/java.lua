-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = "C:/Users/tinnguyen/Documents/notes/courses/cscolby-lab/cs231-lab/w4/w4extension-jddata/"
  .. project_name

local processing_dir = "C:/Program Files/processing-4.3/core/library/core.jar"

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar",
    "C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    "-configuration",
    "C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/jdtls/config_win",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    "-data",
    workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      project = {
        referencedLibraries = {
          processing_dir,
        },
      },
      rename = true,
      completion = false,
      format = false,
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}

local map = vim.keymap.set
-- export on_attach & capabilities
local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

vim.api.nvim_create_user_command("JdtStart", function()
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  require("jdtls").start_or_attach(config)
  on_attach()
end, {})

local java_run = function(args, file)
  require("nvchad.term").runner {
    pos = "sp",
    cmd = function()
      vim.cmd "w"
      return "javac " .. args .. " " .. file .. ".java; java " .. args .. " " .. file .. "; exit"
    end,
  }
end

local java_run_nocompile = function(args, file)
  require("nvchad.term").runner {
    pos = "sp",
    cmd = function()
      return "java " .. args .. " " .. file .. ";"
    end,
  }
end

local java_compile = function(args, file)
  require("nvchad.term").runner {
    pos = "sp",
    cmd = function()
      vim.cmd "w"
      return "javac " .. args .. " " .. file .. ".java;"
    end,
  }
end

vim.api.nvim_create_user_command("JavaRun", function()
  java_run("", vim.fn.expand "%:r")
end, {})
vim.api.nvim_create_user_command("ProcessingRunSketch", function()
  java_compile("-cp '.;" .. processing_dir .. "'", "*")
  java_run_nocompile("-cp '.;" .. processing_dir .. "'", project_name)
end, {})
vim.api.nvim_create_user_command("ProcessingCompileSketch", function()
  java_compile("-cp '.;" .. processing_dir .. "'", "*")
end, {})
vim.api.nvim_create_user_command("ProcessingCompile", function()
  java_compile("-cp '.;" .. processing_dir .. "'", vim.fn.expand "%:r")
end, {})
