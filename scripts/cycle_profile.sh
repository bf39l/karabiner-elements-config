if test "$(/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli --show-current-profile-name)" == "bf39L"; then
    /Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli --select-profile "colemak" &&
        osascript -e 'display notification "colemak" with title "Karabiner" subtitle "Profile Switch" sound name "Purr"'
    # /opt/homebrew/bin/terminal-notifier -title "Karabiner" -group "Karabiner" -message "Profile: colemak"
else
    /Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli --select-profile "bf39L" &&
        osascript -e 'display notification "bf39L" with title "Karabiner" subtitle "Profile Switch" sound name "Purr"'
fi
