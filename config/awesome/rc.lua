-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/collodi/.config/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc +sb"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Date in our language
--os.setlocale(os.getenv("LANG"))
os.setlocale("cs_CZ.utf8")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end

tags[1][1].name = "@"   awful.layout.set(layouts[6], tags[1][1])
tags[1][2].name = "web" awful.layout.set(layouts[10], tags[1][2])
tags[1][3].name = "α"   awful.layout.set(layouts[6], tags[1][3])
tags[1][4].name = "β"   awful.layout.set(layouts[6], tags[1][4])
tags[1][5].name = "Γ"   awful.layout.set(layouts[10], tags[1][5])
tags[1][6].name = "δ"   awful.layout.set(layouts[6], tags[1][6])
tags[1][7].name = "G"   awful.layout.set(layouts[6], tags[1][7])
tags[1][8].name = "T8"  awful.layout.set(layouts[6], tags[1][8])
tags[1][9].name = "♫"  awful.layout.set(layouts[6], tags[1][9])
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "&quit", awesome.quit },
   { "&debugg", awful.util.getdir("config") .. "/debug.sh" },
   { "&restart", awesome.restart }
}

mysystemmenu = {
	{ "&reboot", "sudo shutdown -r now"},
	{ "&halt", "sudo shutdown -h now"},
	{ "&s2ram", "sudo s2ram"}
}

xclipmenu = { 
  { "mBank &ID", "xclip -d localhost:0 /home/collodi/.xclip/mbank-id"},
  { "cislo &uctu", "xclip -d localhost:0 /home/collodi/.xclip/mbank-cu"},
  { "&xferra00", "xclip -d localhost:0 /home/collodi/.xclip/xferra00"},
  { "&radecek.feru", "xclip -d localhost:0 /home/collodi/.xclip/radecek.feru"},
  { "&mobil", "xclip -d localhost:0 /home/collodi/.xclip/mobil"},
}

mymainmenu = awful.menu({ items = { 
    { "&Awesome", myawesomemenu, beautiful.awesome_icon },
    { "&system", mysystemmenu },
    { "x&clip load", xclipmenu },
    { "&open terminal", terminal }
  }
})


-- {{{ Reusable separators
spacer         = widget({ type = "textbox", name = "spacer" })
spacer.text    = " "
-- }}}

-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right", color= "blue"}, " %a %d %B(%m) %Y, %H:%M:%S ", 1)


cpuwidget      = awful.widget.graph()
-- CPU graph properties
cpuwidget:set_width(60):set_height(11)
cpuwidget:set_border_color("#777777")
cpuwidget:set_color("#bbbbbb")
awful.widget.layout.margins[cpuwidget.widget] = { left=3, top = 1, bottom = 1}
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)

---- wired eth connection
eth0graph      = awful.widget.graph({ layout = awful.widget.layout.horizontal.rightleft })
eth0graph:set_width(26)
eth0graph:set_height(11)
eth0graph:set_scale(true)
eth0graph:set_border_color("#777777")
eth0graph:set_color("#bbbbbb")

awful.widget.layout.margins[eth0graph.widget] = { top = 1, bottom = 1}
vicious.register(eth0graph, vicious.widgets.net, "${eth0 down_kb}", 2)


eth1graph      = awful.widget.graph({ layout = awful.widget.layout.horizontal.rightleft })
-- graph properties
eth1graph:set_width(26)
eth1graph:set_height(11)
eth1graph:set_scale(true)
eth1graph:set_border_color("#777777")
eth1graph:set_color("#bbbbbb")

awful.widget.layout.margins[eth1graph.widget] = { top = 1, bottom = 1}
vicious.register(eth1graph, vicious.widgets.net, "${eth1 down_kb}", 1)


parita_widget = widget({type = "textbox", name = "parita_widget"})
parita_widget.text = "-----"
vicious.register(parita_widget, vicious.widgets.date,
    "<span color='yellow'>[%W]</span>", 300)

eth0text = widget({ type = "textbox", name = "eth0text" })
eth0text.text = "wired: "

eth1text = widget({ type = "textbox", name = "eth1text" })
eth1text.text = "wifi:"

--{{{ Memory
memicon       = widget({ type = "imagebox", name = "memicon" })
memicon.image = image(beautiful.widget_mem)
memtext	=widget({ type = "textbox", name = "memtext" })
vicious.register(memtext, vicious.widgets.mem, 
  function (widget, args)
    local used = tonumber(args[2])
    local color="#F0DFAF"
    if used > 600 then
       color = "red"
    end
    return "<span color='" .. color .."'>" .. used .. " MB</span>" 
  end, 5)
-- }}}


-- {{{ Wifi widget
wifiwidget = widget({ type = "textbox", name = "wifiwidget" })
vicious.register(wifiwidget, vicious.widgets.wifi, "<span color='#FC8B07' font_weight='ultrabold'>" .. " ${ssid} " .. "</span>", 10, "eth1")

thermalwidget  = widget({ type = "textbox", name = "thermalwidget" })
vicious.register(thermalwidget, vicious.widgets.thermal,
  function (widget, args)
    local temp = tonumber(args[1])
    local color="#ABBC92"
    if temp > 55 then
       color="red"
    end
    return "<span color='" .. color .. "'>" .. temp .. "°C</span>"
  end, 5, "thermal_zone0")
-- }}}


-- {{{ CPU Speed stepping
governwidget  = widget({ type = "textbox", name = "governwidget" })
vicious.register(governwidget, vicious.widgets.cpufreq,
function (widget, args)
    return "<span color='gray'>" .. string.format("%4d", args[1]) .. "MHz</span>"
end, 5, "cpu0")
-- }}}


-- {{{ Battery percentage and state indicator
baticon       = widget({ type = "imagebox", name = "baticon" })
baticon.image = image(beautiful.widget_bat)
batwidget     = widget({ type = "textbox", name = "batwidget" })
batwarn_icon = "/usr/share/icons/Tango/32x32/devices/battery.png"
vicious.register( batwidget, vicious.widgets.bat,
  function (widget, args)
    local perc = tonumber(args[2])
    local color = "#ABBC92"
    if perc > 30 then
       color="red"
    end

    if args[1] == "-" then -- discharging
      color="#F0DFAF"
        if perc <= 99 then
          awful.util.spawn(
           "notify-send -u critical -t 3500 -i " .. batwarn_icon ..
           "'<tt>BATTERY OUT!</tt>' '\nConnect me to AC adapter. Immediately!'",false)
        if perc <= 95 then
          awful.util.spawn("sudo s2ram", false)
        end
      end
    end
     
    return "<span color='" .. color .. "'>" .. args[1] .. perc .. "% " ..
    args[3] .. "</span>"
  end, 5, "BAT0")
-- }}}

-- {{{ Song played in MOC
moctext = widget({ type = "textbox", name = "moctext" })
vicious.register(moctext, vicious.widgets.mocp,
    function (widget, args)
      if (args["{State}"] == "STOP" or args["{State}"] == "DOWN") then
          return ""
      else
          return ' '..args["{State}"] ..' <span color="#ABBC92">'..
          vicious.helpers.truncate(args["{Artist}"]..': '..args["{Title}"], 80) ..
          '</span>'
      end
    end)

-- {{{ Volume level
volbar    = awful.widget.progressbar()
volbar:set_width(30)
volbar:set_height(9)
volbar:set_vertical(false)
volbar:set_background_color(beautiful.bg_widget)
volbar:set_border_color("#777777")
volbar:set_color("#bbbbbb")

awful.widget.layout.margins[volbar.widget] = { top = 2, bottom = 2}
vicious.register(volbar,    vicious.widgets.volume, "$1",  1, "PCM")
-- }}}

-- {{{ Messages beeing written to these boxes from external scripts
backupwidget =widget({ type = "textbox", name = "backupwidget" })
backupwidget.text = ""
recwidget =widget({ type = "textbox", name = "recwidget" })
recwidget.text = ""

function wifiInfo(adapter)
    local f = io.open("/sys/class/net/"..adapter.."/wireless/link")
    local f_os = io.open("/sys/class/net/"..adapter.."/operstate")
    local wifiStrength = f:read()
    local wifiState = f_os:read()

    eth1text.text = " wifi " .. wifiState .. ":" .. " " ..wifiStrength.. "% "
    f:close()
    f_os:close()
end
function wiredInfo(adapter)
    spacer = " "
    local f_os = io.open("/sys/class/net/"..adapter.."/operstate")
    local State = f_os:read()

    State = "wired " .. State .. ":"
    eth0text.text = spacer..State..spacer
    f_os:close()
end

mytimer = timer({ timeout = 5 })
mytimer:add_signal("timeout", function()  
    wifiInfo("eth1")
    wiredInfo("eth0")
end)
mytimer:start()
-- }}}

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 26 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
        { volbar, moctext,
         layout = awful.widget.layout.horizontal.leftright
        },
        { parita_widget, mytextclock, memtext, memicon, 
          governwidget,
          spacer,
          spacer, 
          thermalwidget,
          spacer, cpuwidget.widget, 
          batwidget,
          baticon,
          eth0graph.widget,
          eth0text, spacer,
          eth1graph.widget,
          wifiwidget, eth1text, 
          layout = awful.widget.layout.horizontal.rightleft
        },
      },
      { mytaglist[s], mypromptbox[s], s == 1 and mysystray or nil, backupwidget,
        recwidget, mylayoutbox[s], mytasklist[s],
        layout = awful.widget.layout.horizontal.leftright
      },
        layout = awful.widget.layout.vertical.flex
      }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 1, function () mymainmenu:hide() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "e", awful.tag.history.restore),
    awful.key({ modkey, "Mod1"    }, "h",   awful.tag.viewprev),
    awful.key({ modkey, "Mod1"    }, "l",  awful.tag.viewnext),
    awful.key({ modkey,           }, "Escape", function () awful.screen.focus_relative( 1) end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Restore all minimized clients
    --awful.key({ modkey, "Shift"}, "n",
    --    function ()
     --     local scrn = awful.tag.selected(mouse.screen)
     --     local allclients = client.get(mouse.screen)
     --     for _,c in ipairs(allclients) do
     --       if c.minimized and c:tags()[mouse.screen] == scrn then
     --         c.minimized = false
     --         client.focus = c
     --         c:raise()
     --         return
     --       end
     --     end
     --   end),

    -- mocp
    awful.key({ modkey, }, "F9",
        function () awful.util.spawn("mocp --previous", false) end),
    awful.key({ modkey, }, "F11",
        function () awful.util.spawn("mocp --toggle-pause", false) end),
    awful.key({ modkey, }, "F12",
        function () awful.util.spawn("mocp --next", false) end),

    -- amixer
    awful.key({ modkey, "Shift" }, "F9",
        function () awful.util.spawn("amixer set PCM 5%-", false) end),
    awful.key({ modkey, "Shift" }, "F12",
        function () awful.util.spawn("amixer set PCM 5%+", false) end),

    -- arecord
    awful.key({ modkey, }, "F10", 
        function () 
          awful.util.spawn("arecord -t wav -f cd /tmp/capture.wav", false)
          recwidget.text = "<span color='red'>recording .. </span>" end),

    awful.key({ modkey, "Shift" }, "F10",
        function () 
          awful.util.spawn("killall arecord", false) 
          recwidget.text = "" end),

    -- starters
    awful.key({ modkey, }, "F5",
        function () awful.util.spawn(terminal ..
          " -e sh -c 'export TERM=xterm-256color;mocp'", false) end),
    awful.key({ modkey, "Shift" }, "F5",
        function () awful.util.spawn(terminal ..
          " -e alsamixer", false) end),
    awful.key({ modkey, }, "F6",
        function () awful.util.spawn(terminal ..
          " -e htop", false) end),
    awful.key({ modkey, "Shift" }, "F6",
        function () awful.util.spawn(terminal ..
          " -e wicd-curses", false) end),
    awful.key({ modkey, }, "F7",
        function () awful.util.spawn(terminal ..
          " -e mutt", false) end),
    awful.key({ modkey, "Shift" }, "F7",
        function () awful.util.spawn(terminal ..
          " -e canto -u") end),
    awful.key({ modkey,	}, "F8",
        function () awful.util.spawn_with_shell(
          "DISPLAY=:0.0 &&" .. os.getenv('HOME') .. '/scripts/pidgin.bash') end),
	  awful.key({ modkey, "Shift" }, "F8",
        function () awful.util.spawn(
          "galculator") end),

    -- screen blanking
	  awful.key({ }, "XF86ScreenSaver",
        function ()
          awful.util.spawn_with_shell(
            "sleep 1;xterm -e xset dpms force standby", false) 
          awful.util.spawn_with_shell("slock") end),

    -- sleeping	
    awful.key({ }, "XF86Sleep",
        function ()
          awful.util.spawn("/home/collodi/scripts/sleep.sh", false) end),
    
    -- lock and sleep
    awful.key({"Shift" }, "XF86Sleep",
        function ()
          awful.util.spawn("slock", false)
          awful.util.spawn("/home/collodi/scripts/sleep.sh", false) end),

    -- hiding wibox
    awful.key({ modkey, }, "b",
        function ()
          mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end), 

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
            c:raise()
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "gcolor2" },   properties = { floating = true } },
    { rule = { class = "Qjackctl" },  properties = { floating = true } },
    { rule = { class = "Galculator" },properties = { floating = true } },
    { rule = { class = "Xmessage" },  properties = { floating = true } },
    { rule = { class = "MATLAB" },    properties = { floating = true } },
    { rule = { class = "Orage" },    properties = { floating = true } },

    { rule = { class = "Swiftfox" },  properties = { tag = tags[1][2] } },
    { rule = { class = "Firefox" },  properties = { tag = tags[1][2] } },
    { rule = { class = "luakit" },    properties = { tag = tags[1][2] } },
    { rule = { class = "Pidgin" },    properties = { tag = tags[1][1] } },
    { rule = { class = "Gimp" },      properties = { tag = tags[1][7] } },
    { rule = { class = "Evince" },    properties = { tag = tags[1][5] } },
    { rule = { class = "Epdfview" },  properties = { tag = tags[1][5] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
-- ???            awful.placement.under_mouse(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
