if not pcall(require, 'fidget') then
  return
end

require"fidget".setup {
  text = { spinner = "dots_pulse" },
  window = { relative = "editor" },
  timer = { fidget_decay = 3000 },
}
