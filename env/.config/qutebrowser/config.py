c = c  # pyright: ignore[reportUndefinedVariable]
config = config  # pyright: ignore[reportUndefinedVariable]

# rosepine = {
#     "bg": "#191724",
#     "fg": "#e0def4",
#
#     "muted": "#6e6a86",
#     "subtle": "#908caa",
#
#     "love": "#eb6f92",
#     "gold": "#f6c177",
#     "rose": "#ebbcba",
#     "pine": "#31748f",
#     "foam": "#9ccfd8",
#     "iris": "#c4a7e7",
#
#     "highlight_low": "#21202e",
#     "highlight_med": "#403d52",
#     "highlight_high": "#524f67",
# }
#
# # statusbar
# c.colors.statusbar.normal.bg = "#00000000"
# c.colors.statusbar.command.bg = "#00000000"
# c.colors.statusbar.normal.fg = rosepine["foam"]
# c.colors.statusbar.command.fg = rosepine["fg"]
# c.colors.statusbar.passthrough.fg = rosepine["foam"]
#
# c.colors.statusbar.url.fg = rosepine["rose"]
# c.colors.statusbar.url.success.https.fg = rosepine["rose"]
# c.colors.statusbar.url.hover.fg = rosepine["pine"]
#
# # tabs
# c.colors.tabs.even.bg = "#00000000"
# c.colors.tabs.odd.bg = "#00000000"
# c.colors.tabs.bar.bg = "#00000000"
#
# c.colors.tabs.even.fg = rosepine["muted"]
# c.colors.tabs.odd.fg = rosepine["muted"]
#
# c.colors.tabs.selected.even.bg = rosepine["fg"]
# c.colors.tabs.selected.odd.bg = rosepine["fg"]
# c.colors.tabs.selected.even.fg = rosepine["bg"]
# c.colors.tabs.selected.odd.fg = rosepine["bg"]
#
# c.colors.tabs.indicator.start = rosepine["pine"]
# c.colors.tabs.indicator.stop = rosepine["muted"]
#
# # hints
# c.colors.hints.bg = rosepine["bg"]
# c.colors.hints.fg = rosepine["fg"]
# c.hints.border = f"1px solid {rosepine['iris']}"
#
# # completion
# c.colors.completion.odd.bg = rosepine["bg"]
# c.colors.completion.even.bg = rosepine["bg"]
# c.colors.completion.fg = rosepine["fg"]
# c.colors.completion.category.bg = rosepine["bg"]
# c.colors.completion.category.fg = rosepine["iris"]
#
# c.colors.completion.match.fg = rosepine["foam"]
# c.colors.completion.item.selected.match.fg = rosepine["foam"]
# c.colors.completion.item.selected.bg = rosepine["highlight_med"]
# c.colors.completion.item.selected.fg = rosepine["fg"]
#
# # messages / downloads
# c.colors.messages.info.bg = rosepine["bg"]
# c.colors.messages.info.fg = rosepine["fg"]
# c.colors.messages.error.bg = rosepine["bg"]
# c.colors.messages.error.fg = rosepine["love"]
#
# c.colors.downloads.bar.bg = rosepine["bg"]
# c.colors.downloads.start.bg = rosepine["pine"]
# c.colors.downloads.start.fg = rosepine["fg"]
# c.colors.downloads.stop.bg = rosepine["muted"]
# c.colors.downloads.stop.fg = rosepine["fg"]
#
# # tooltip / webpage
# c.colors.tooltip.bg = rosepine["bg"]
# c.colors.webpage.bg = rosepine["bg"]

c.url.start_pages  = "https://winterleg.github.io"
c.url.default_page = "https://winterleg.github.io"

c.tabs.title.format = "{audio}{current_title}"
c.tabs.position = 'left'

c.url.searchengines = {
# note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!g': 'https://www.google.com/search?q={}',
        # '!aw': 'https://wiki.archlinux.org/?search={}',
        # '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        # '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }

c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = False # save tabs on quit/restart

# keybinding changes
config.bind(';', 'cmd-set-text :')
config.bind('q', 'close')
config.bind('wo', 'edit-url')
config.bind('m', 'spawn mpv {url}')
config.bind('M', 'hint links spawn mpv {hint-url}')
        # config.bind('=', 'cmd-set-text -s :open')
        # config.bind('h', 'history')
        # config.bind('cc', 'hint images spawn sh -c "cliphist link {hint-url}"')
        # config.bind('cs', 'cmd-set-text -s :config-source')
        # config.bind('tH', 'config-cycle tabs.show multiple never')
        # config.bind('sH', 'config-cycle statusbar.show always never')
        # config.bind('T', 'hint links tab')
        # config.bind('pP', 'open -- {primary}')
        # config.bind('pp', 'open -- {clipboard}')
        # config.bind('pt', 'open -t -- {clipboard}')
        # config.bind('qm', 'macro-record')
        # config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh')
        # config.bind('tT', 'config-cycle tabs.position top left')
        # config.bind('gJ', 'tab-move +')
        # config.bind('gK', 'tab-move -')
        # config.bind('gm', 'tab-move')

# dark mode setup
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
# c.colors.webpage.darkmode.policy.images = 'never'
# config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# styles, cosmetics
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
c.tabs.width = '7%'

# fonts
c.fonts.default_family         = ['Courier Prime Code', 'Klee One']
c.fonts.default_size           = '14pt'
c.fonts.web.size.default       = 20
c.fonts.web.size.default_fixed = 20
c.fonts.web.family.fixed       = 'Miracode'
c.fonts.web.family.sans_serif  = 'Miracode'
c.fonts.web.family.serif       = 'Miracode'
c.fonts.web.family.standard    = 'Miracode'
c.content.user_stylesheets     = ["override-fonts.css"]

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.webgl", True, "*")
config.set("content.canvas_reading", True)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)

c.editor.command = ['neovide', '{}']

c.content.blocking.enabled = True
