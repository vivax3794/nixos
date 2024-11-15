local response_format = "Respond EXACTLY in this format:\n```$ftype\n<your code>\n```"

return {
    'Exafunction/codeium.vim',
    -- "nomnivore/ollama.nvim",
    -- dependencies = {
    --     "nvim-lua/plenary.nvim"
    -- },
    -- -- All the user commands added by the plugin
    -- cmd = {"Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop"},
    -- keys = {
    --     -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
    --     {
    --         "<leader>oo",
    --         ":<c-u>lua require('ollama').prompt()<cr>",
    --         desc = "ollama prompt",
    --         mode = {"n", "v"}
    --     }
    -- },
    -- ---@type Ollama.Config
    -- opts = {
    --     prompts = {
    --         Simplify_Code = {
    --             prompt = "Simplify the following $ftype code so that it is both easier to read and understand. " ..
    --                 response_format .. "\n\n```$ftype\n$sel```",
    --             action = "display_replace"
    --         },
    --         Modify_Code = {
    --             prompt = "Modify this $ftype code in the following way: $input\n\n" ..
    --                 response_format .. "\n\n```$ftype\n$sel```",
    --             action = "display_replace"
    --         },
    --         Generate_Code = {
    --             prompt = "Generate $ftype code that does the following: $input\n\n" .. response_format,
    --             action = "display_insert"
    --         },
    --         Generate_Docs = {
    --             prompt = "Generate $ftype docs as specified: $input\n\n" ..
    --                     "respond only with the new docs and none of the surrounding code.\nDo not respond with the method/function signature/body or anything except the docs.\n\n" ..
    --                     "\n\nContext: ```$ftype\n$sel```"
    --                     .. "Respond EXACTTLY in this format: ```rust\n/// <your docs>```",
    --             action = "display_insert",
    --             extract = "^(.*)$"
    --         }
    --     }
    -- }
}
