-- fzf config here
return {
	{ 
    "ibhagwan/fzf-lua", 
    opts = {
      files = {
        cwd_prompt= false,
        git_icons = true,
      },
	  },
    keys = {
      {
        ";F",
        function()
          require("fzf-lua").builtin()
        end,
      },
      {
        ";f",
        function()
          require("fzf-lua").files()
        end,
      },
      {
        ";g",
        function()
          require("fzf-lua").live_grep_native()
        end,
      },
      {
        ";G",
        function()
          require("fzf-lua").grep_visual()
        end,
      },
      {
        ";G",
        function()
          require("fzf-lua").grep_visual()
        end,
        mode = "v",
      },
      {
        ";d",
        function()
          require("fzf-lua").diagnostics_document()
        end,
      },
      {
        ";b",
        function()
          require("fzf-lua").buffers()
        end,
      },
      {
        ";;",
        function()
          require("fzf-lua").resume()
        end,
      },
    }
  },
}
