# ========= PREAMBLE ========= #
# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

green = "#b5bd68"
dark_red = "#c82829"
selection = "#373b41"
current_line = "#282a2e"
red = "#cc6666"

c.colors.statusbar.normal.bg = red
c.colors.statusbar.normal.fg = current_line
c.colors.statusbar.url.fg = dark_red
c.colors.statusbar.url.success.https.fg = dark_red
c.colors.statusbar.url.success.http.fg = dark_red
c.colors.statusbar.url.hover.fg = selection
c.colors.statusbar.progress.bg = dark_red

c.colors.tabs.selected.odd.bg = red
c.colors.tabs.selected.odd.fg = selection
c.colors.tabs.selected.even.bg = red
c.colors.tabs.selected.even.fg = selection
c.colors.tabs.indicator.start = "#99cc99"
c.colors.tabs.indicator.stop = dark_red
c.colors.tabs.indicator.error = red
