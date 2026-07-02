-- フローティングモードとタイリングモードを切り替える

local floating = hl.window_rule({
  name = "floating-mode",
  match = {
    class = ".*",
  },
  float = true
})

floating:set_enabled(false)

function FloatingToggle()
  local isFloating = floating:is_enabled()

  if isFloating then
    hl.notification.create { text = "floating false", timeout = 2000 }
    floating:set_enabled(false)
  else
    hl.notification.create { text = "floating true", timeout = 2000 }
    floating:set_enabled(true)
  end
end
