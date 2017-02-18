# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/Codecave/gaalcaras"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Gaalcaras"

# Split window into panes.
split_h 45
split_v 50

# Run commands.
run_cmd "git status"     # runs in active pane
run_cmd "./jekyll_build.sh" 2  # runs in pane 1

# Paste text
send_keys "nv " 1 # paste into pane 1

# Set active pane.
select_pane 1
