local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default")

beautiful.init(theme_path)
local osmium = require("osmium")
local markup = osmium.util.markup

local cnt = wibox.container
local hrz = wibox.layout.align.horizontal

local separators = osmium.util.separators
local arrow = separators.arrow_left
local arrw0 = arrow(beautiful.col0, beautiful.col1)
local arrw1 = arrow(beautiful.col1, beautiful.col0)

local mem = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/ram", 2,
  function(widget, stdout)
    widget:set_markup(markup.font(beautiful.font, stdout))
  end,
  wibox.widget{
    valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

-- battery
local battery = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/battery", 5,
  function(widget, stdout)
    widget:set_text(stdout)
  end,
  wibox.widget{
    valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

-- kernel
local kernel = wibox.widget{
  valign = 'top',
  widget = wibox.widget.textbox
}

awful.spawn.easy_async_with_shell(os.getenv("HOME") .. "/.local/bin/kernel",
  function(out)
    kernel:set_markup_silently(out)
    kernel.text = out
  end
)

-- backlight
local backlight = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/backlight", 1,
  function(widget, stdout)
    widget:set_text(stdout)
  end,
  wibox.widget{
    valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

backlight:buttons(awful.util.table.join(
  awful.button({}, 4, function() -- scroll up
    os.execute("xbacklight -inc 10")
  end),
  awful.button({}, 5, function() -- scroll down
    os.execute("xbacklight -dec 10")
  end)
))

-- CPU temperature
local tmp = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/cpu_temp", 5,
  function(widget, stdout)
    widget:set_text(stdout)
  end,
  wibox.widget{
    valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

-- WEATHER
local weather = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/weather", 600,
  function(widget, stdout)
    widget:set_markup(markup.font(beautiful.font, stdout))
  end,
  wibox.widget{
    --valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

-- DISK
local disk = awful.widget.watch(
  os.getenv("HOME") .. "/.local/bin/disk", 5,
  function(widget, stdout)
    widget:set_markup(markup.font(beautiful.font, stdout))
  end,
  wibox.widget{
    valign = 'top',
    widget = wibox.widget.textbox,
    font = beautiful.font
  }
)

-- KEYBOARD LAYOUT
local keybrd = awful.widget.keyboardlayout {
  font = beautiful.font,
  pattern = "⌨️ %s"
}

local vol_cmd = os.getenv("HOME") .. "/.local/bin/volume"
local vol = awful.widget.watch(vol_cmd, 1,
  function(widget, stdout)
    widget:set_markup(markup.font(beautiful.font, stdout))
  end
)

vol:buttons(awful.util.table.join(
  awful.button({}, 4, function() -- scroll up
    os.execute(vol_cmd .. " -s 1%+")
  end),
  awful.button({}, 5, function() -- scroll down
    os.execute(vol_cmd .. " -s 1%-")
  end)
))

-- CPU
local cpuicon = wibox.widget.imagebox(beautiful.cpu_icon)
local cpu = osmium.widget.cpu {
  notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = beautiful.font },
  settings = function()
    local text = string.format("%3d%%", cpu_now.usage)
        widget:set_markup(markup.font(beautiful.font, text))
    end
}
-- CLK
local clkicon = wibox.widget.imagebox(beautiful.clk_icon)
local clk_cmd = os.getenv("HOME") .. "/.local/bin/datetime"
local clk = awful.widget.watch(
  clk_cmd, 60,
  function(widget, stdout)
    widget:set_markup(markup.font(beautiful.font, stdout))
  end
)

-- CAL
local cal = osmium.widget.cal {
  attach_to = { clk },
  notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = beautiful.font }
}

local function factory(args)
local widgets = { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            arrow("alpha", beautiful.col0),
            cnt.background(cnt.margin(keybrd, 2, 3)                                          , beautiful.col0), arrw0,
            cnt.background(cnt.margin(wibox.widget {cpuicon, cpu.widget, layout = hrz}, 2, 3), beautiful.col1), arrw1,
            cnt.background(cnt.margin(tmp                                             , 2, 3), beautiful.col0), arrw0,
            cnt.background(cnt.margin(mem                                             , 2, 3), beautiful.col1), arrw1,
            cnt.background(cnt.margin(disk                                            , 2, 3), beautiful.col0), arrw0,
            cnt.background(cnt.margin(vol,                                              2, 3), beautiful.col1), arrw1,
            --cnt.background(cnt.margin(battery                                         , 2, 3), beautiful.col0), arrw0,
            --cnt.background(cnt.margin(backlight                                       , 2, 3), beautiful.col1), arrw1,
            cnt.background(cnt.margin(kernel                                          , 2, 3), beautiful.col0), arrw0,
            cnt.background(cnt.margin(weather                                         , 2, 3), beautiful.col1), arrw1,
            cnt.background(cnt.margin(wibox.widget {         clk       , layout = hrz}, 2, 3), beautiful.col0), arrw0,
            cnt.background(cnt.margin(wibox.widget {args.screen.mylayoutbox      , layout = hrz}, 2, 3), beautiful.col1)
        }
  return widgets
end

return factory

