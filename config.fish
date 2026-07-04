if status is-interactive
# Commands to run in interactive sessions can go here
function fish_prompt
    echo '> '
end
end
if status is-login
    and test -z "$WAYLAND_DISPLAY"
    and test "$XDG_VTNR" = 1
    exec uwsm start hyprland-uwsm.desktop
end

