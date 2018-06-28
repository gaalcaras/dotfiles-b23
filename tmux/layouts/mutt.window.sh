# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "$HOME"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Mutt"

# Split window into panes.
split_h 25

# Set active pane.
select_pane 1

# Run commands.
run_cmd "neomutt -n" 1  # runs in pane 1
run_cmd "mutt_task_report.sh" 2   # runs in pane 2
