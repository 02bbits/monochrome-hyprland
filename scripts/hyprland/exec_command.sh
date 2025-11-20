#! /bin/bash

CONFIG_FILE="$HOME/.config/rofi/command.rasi"
OPTIONS="wiki
openrgb"

# kill rofi if another instance is alr running
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
fi

# Stop hyprland animation
hyprctl keyword animations:enabled 0

option=$(echo "$OPTIONS" | rofi -i -dmenu -config $CONFIG_FILE)
hyprctl keyword animations:enabled 1

if [[ "$option" == "wiki" ]]; then
    WIKI_SOURCE=$(echo -e "Wikipedia\nArch Wiki\nGentoo Wiki" | rofi -i -dmenu -config $CONFIG_FILE)
    if [[ -n "$WIKI_SOURCE" ]]; then
        QUERY=$(rofi -i -dmenu -config $CONFIG_FILE -no-case-sensitive)
        if [[ -n "$QUERY" ]]; then
            case "$WIKI_SOURCE" in
                "Wikipedia")
                    xdg-open "https://en.wikipedia.org/wiki/Special:Search?search=$(echo $QUERY | sed 's/ /+/g')" ;;
                "Arch Wiki")
                    xdg-open "https://wiki.archlinux.org/index.php?search=$(echo $QUERY | sed 's/ /+/g')" ;;
                "Gentoo Wiki")
                    xdg-open "https://wiki.gentoo.org/index.php?search=$(echo $QUERY | sed 's/ /+/g')" ;;
            esac
        fi
    fi
fi

if [[ "$option" == "rgb" ]]; then
    MODE=$(echo -e "Spectrum Cycle\nStatic\nBreathing" | rofi -i -dmenu -config $CONFIG_FILE)
    if [[ -n "$MODE" ]]; then
    case "$MODE" in 
        "Spectrum Cycle")
        BRIGHTNESS=(echo -e "50\n80\n100" | rofi -dmenu -config $CONFIG_FILE)
        case "$BRIGHTNESS" in
            "50")
            openrgb -m 'Spectrum Cycle' -b 50 -s 0 ;;
            "80")
            openrgb -m 'Spectrum Cycle' -b 80 -s 0 ;;
            "100")
            openrgb -m 'Spectrum Cycle' -b 100 -s 0 ;;
            esac
        esac
    fi
fi
