return {
  "mrjones2014/legendary.nvim",
  config = function()
    local status_ok, legendary = pcall(require, "legendary")
    if not status_ok then
      vim.notify("failed to load legendary", vim.log.levels.ERROR)
      return
    end

    legendary.setup({
      which_key = {
        auto_register = true,
        -- do_binding = false,
      },
    })
  end,
}
