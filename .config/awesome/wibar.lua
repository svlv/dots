local awful = require("awful")
local wibox = require("wibox")

local beautiful = require("beautiful")
local theme_path = string.format(
  "%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")
beautiful.init(theme_path)
color0 = beautiful.col0
color1 = beautiful.col1

local osmium = require("osmium")
local arrow_left = osmium.util.separators.arrow_left

local cnt = wibox.container
local hrz = wibox.layout.align.horizontal

local arrow0 = arrow_left(color1, color0)
local arrow1 = arrow_left(color0, color1)

local wibar = {}

wibar.bin_dir = os.getenv("HOME") .. "/.local/bin/statusbar/"
local function watch_widget_factory(args)
  return awful.widget.watch(
    wibar.bin_dir .. args.cmd, args.timeout or 5,
    function(widget, stdout)
      widget:set_text(stdout)
    end,
    wibox.widget{
      valign = args.valign or "center",
      widget = wibox.widget.textbox,
      font = beautiful.font
    }
  )
end

local function is_laptop()
  file = io.open("/sys/class/dmi/id/chassis_type", "r")
  if not file then
    return false
  end
  local type = file:read()
  file:close()
  return type == "9" or type == "10"
end

-- kernel
local kernel = wibox.widget{
  valign = 'top',
  widget = wibox.widget.textbox
}

awful.spawn.easy_async_with_shell(wibar.bin_dir .. "kernel",
  function(out)
    kernel:set_text(out)
  end
)

local function update(args)
  awful.spawn.easy_async_with_shell(args.cmd,
    function(out)
      args.widget:set_text(out)
    end)
end

wibar.widgets = {}

-- backlight
local backlight = watch_widget_factory{cmd="backlight",timeout=1,valign='top'}
wibar.widgets.backlight = {widget=backlight}
backlight:connect_signal("update",
  function()
    update{cmd=wibar.bin_dir.."backlight",widget=backlight}
  end
)
backlight:buttons(awful.util.table.join(
  awful.button({}, 4,
  function() -- scroll up
    os.execute("xbacklight -inc 10")
    backlight:emit_signal("update")
  end),
  awful.button({}, 5,
  function() -- scroll down
    os.execute("xbacklight -dec 10")
    backlight:emit_signal("update")
  end)
))

-- volume
local vol = watch_widget_factory{cmd="volume",timeout=1}
local vol_cmd = wibar.bin_dir .. "volume"
wibar.widgets.volume = {widget=vol,cmd=vol_cmd}
vol:connect_signal("update",
  function()
    update{cmd=vol_cmd,widget=vol}
  end
)
vol:buttons(awful.util.table.join(
  awful.button({}, 4,
  function() -- scroll up
    os.execute(vol_cmd .. " -s 1%+")
    vol:emit_signal("update")
  end),
  awful.button({}, 5,
  function() -- scroll down
    os.execute(vol_cmd .. " -s 1%-")
    vol:emit_signal("update")
  end)
))

-- datetime with calendar
local datetime = watch_widget_factory{cmd="datetime",timeout=60}
osmium.widget.cal{
  attach_to = { datetime },
  notification_preset = {
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    font = beautiful.font
  }
}

wibar.bar = function (args)
  local widgets = {
    layout = wibox.layout.fixed.horizontal,
    wibox.widget.systray(),
    arrow_left("alpha", beautiful.col0)
  }

  local function push_widget(args)
    local isEven = (#widgets - 2) % 4 == 0
    local arrow = isEven and arrow1 or arrow0
    local color = isEven and color0 or beautiful.col1
    widgets[#widgets+1] = cnt.background(cnt.margin(args.widget, 2, 3), color)
    if not args.last then
      widgets[#widgets+1] = arrow
    end
  end

  local create = watch_widget_factory

  push_widget{widget=awful.widget.keyboardlayout{pattern = "⌨️ %s"}}
  push_widget{widget=create{cmd="upt",timeout=60}}
--push_widget{widget=create{cmd="rate",timeout=60}}
--push_widget{widget=create{cmd="cpu",timeout=1}}
--push_widget{widget=create{cmd="cpu_temp",valign='top'}}
  push_widget{widget=create{cmd="ram",timeout=2,valign ='top'}}
--push_widget{widget=create{cmd="disk",valign='top'}}
  push_widget{widget=vol}
  if is_laptop() then
     push_widget{widget=create{cmd="battery",valign='top'}}
     push_widget{widget=backlight}
  end
--push_widget{widget=kernel}
  push_widget{widget=create{cmd="mailbox",timeout=1}}
  push_widget{widget=create{cmd="atmos-line --get-current-weather",timeout=600}}
  push_widget{widget=create{cmd="internet",timeout=1}}
  push_widget{widget=create{cmd="nettraf",timeout=1}}
  push_widget{widget=datetime}
  push_widget{widget=wibox.widget{args.screen.mylayoutbox, layout = hrz},last=true}
  return widgets
end

return wibar

