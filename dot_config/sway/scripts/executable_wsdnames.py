#!/usr/bin/env python3
# _*_ coding: utf-8 _*_

"""
This script uses the i3ipc python library to create dynamic workspace names in Sway / i3

Author: Piotr Miller
e-mail: nwg.piotr@gmail.com
Project: https://github.com/nwg-piotr/swayinfo
License: GPL3

Based on the example from https://github.com/altdesktop/i3ipc-python/blob/master/README.rst

Dependencies: python-i3ipc>=2.0.1 (i3ipc-python), python-xlib

Pay attention to the fact, that your workspaces need to be numbered, not named for the script to work.

Use:
bindsym $mod+1 workspace number 1

instead of:
bindsym $mod+1 workspace 1

in your ~/.config/sway/config or ~/.config/i3/config file.
"""

from typing import cast
from i3ipc import Connection, Event
from i3ipc.events import IpcBaseEvent

# truncate workspace name to this value
max_length = 15

# Create the Connection object that can be used to send commands and subscribe to events.
i3 = Connection()


# Name the workspace after the focused window name
def assign_generic_name(i3: Connection, e: IpcBaseEvent) -> None:
    # avoid looping
    if e.change == "rename":
        return

    con = i3.get_tree().find_focused()
    if not con:
        return

    number = cast(int, con.workspace().num)

    old_name = cast(str, con.workspace().name)
    new_name = old_name

    # avoid renaming new empty workspaces on 'binding' event()
    if not con.type == "workspace":
        if not e.change == "new":
            new_name = f"{number}: {con.name}"
        else:
            # In sway we may open a new window w/o moving focus; let's give the workspace a name anyway.
            con = i3.get_tree().find_by_id(e.container.id)
            number = con.workspace().num
            name = con.name if con.name else ""

            if name and number:
                new_name = f"{number}: {name}"

    else:
        new_name = f"{number}"

    if len(new_name) > max_length - 1:
        new_name = new_name[: max_length - 1] + "…"

    if new_name != old_name:
        _ = i3.command(f'rename workspace number {number} to "{new_name}"')


def main():
    # Subscribe to events
    i3.on(Event.WORKSPACE_FOCUS, assign_generic_name)
    i3.on(Event.WINDOW_FOCUS, assign_generic_name)
    i3.on(Event.WINDOW_TITLE, assign_generic_name)
    i3.on(Event.WINDOW_CLOSE, assign_generic_name)
    i3.on(Event.WINDOW_NEW, assign_generic_name)
    i3.on(Event.BINDING, assign_generic_name)

    i3.main()


if __name__ == "__main__":
    main()
