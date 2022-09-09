local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"
local gooey = require "ui.gooey"
local rubato = require "modules.rubato"

F.start = {}

local app_factory = function(icon, exec)
  return gooey.make_button {
    icon = icon,
    bg = beautiful.bg_subtle,
    hover = true,
    width = 50,
    height = 50,
    margins = 12,
    exec = function()
      awful.spawn(exec)
    end,
  }
end

local app_browser = app_factory("browser", "librewolf")
local app_terminal = app_factory("term", "xterm")
local app_zathura = app_factory("zathura", "zathura")
local app_gimp = app_factory("gimp", "gimp")
local app_inkscape = app_factory("inkscape", "inkscape")

local apps = wibox.widget {
  layout = wibox.layout.grid,
  spacing = 5,
  forced_num_cols = 3,
  forced_num_rows = 2,
  app_browser,
  app_terminal,
  app_gimp,
  app_zathura,
  app_inkscape,
}

local calendar = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.bg_subtle,
  forced_width = 100,
  forced_height = 100,
  {
    widget = wibox.container.margin,
    margins = 15,
    {
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.widget.textclock "%A",
        font = beautiful.font_name .. " Bold 9",
        align = "center",
      },
      {
        widget = wibox.widget.textclock "%d",
        font = beautiful.font_name .. " Bold 30",
        align = "center",
      },
    },
  },
}

local site_github = app_factory("github", "librewolf https://github.com")
local site_mail = app_factory("proton", "librewolf https://proton.me")
local site_nixpkgs = app_factory("nixos", "librewolf https://search.nixos.org/packages")

local sites = wibox.widget {
  layout = wibox.layout.grid,
  spacing = 5,
  forced_num_cols = 3,
  forced_num_rows = 2,
  site_github,
  site_mail,
  site_nixpkgs,
}

local blank = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.bg_subtle,
  forced_width = 160,
  forced_height = 100,
  {
    widget = wibox.container.margin,
    margins = 10,
    {
      widget = wibox.widget.textbox,
      align = "center",
      text = "Placeholder Text",
    },
  },
}

local start = awful.popup {
  widget = {
    {
      {
        apps,
        calendar,
        layout = wibox.layout.fixed.horizontal,
        spacing = 30,
      },
      {
        sites,
        layout = wibox.layout.fixed.horizontal,
        spacing = 30,
      },
      layout = wibox.layout.fixed.vertical,
      spacing = 30,
    },
    widget = wibox.container.margin,
    margins = 30,
  },
  ontop = true,
  placement = function(c)
    (awful.placement.bottom_left)(c, { margins = { bottom = 55, left = 10 } })
  end,
  visible = false,
  border_color = beautiful.bg_subtle,
  border_width = 2,
  bg = beautiful.bg_normal,
}

local slide = rubato.timed {
  pos = -500,
  rate = 60,
  intro = 0.3,
  duration = 0.8,
  easing = rubato.quadratic,
  awestore_compat = true,
  subscribed = function(pos)
    start.x = pos
  end,
}

local start_status = false

slide.ended:subscribe(function()
  if start_status then
    start.visible = false
  end
end)

local function start_show()
  start.visible = true
  slide:set(10)
  start_status = false
end

local function start_hide()
  slide:set(-500)
  start_status = true
end

F.start.toggle = function()
  if start.visible then
    start_hide()
  else
    start_show()
  end
end
