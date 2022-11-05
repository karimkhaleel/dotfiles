#!/usr/bin/env python

import json
import re

cspell_section_pattern = re.compile(r'(?<="cSpell.userWords": \[\n)(    ".*",?\n?)*')


def format_cspell_words(s):
    print("Formatting new cSpell words")
    formatted_elements = map(lambda x: f'"{x}"', s)
    joined_str = ",\n    ".join(formatted_elements)
    return f"    {joined_str}\n"


print("Opening ~/.config/Code/User/settings.json")
with open("/home/karim/.config/Code/User/settings.json", "rb") as in_f:
    local_settings = json.load(in_f)

print("Formatting output ../.chezmoitemplates/code_user_settings.json file")
with open(
    "/home/karim/.local/share/chezmoi/.chezmoitemplates/code_user_settings.json", "rb"
) as in_f:
    res = cspell_section_pattern.sub(
        repl=format_cspell_words(local_settings["cSpell.userWords"]),
        string=in_f.read().decode("utf-8"),
    )

print("Writing updated ../.chezmoitemplates/code_user_settings.json file")
with open(
    "/home/karim/.local/share/chezmoi/.chezmoitemplates/code_user_settings.json", "w"
) as out_f:
    out_f.write(res)
