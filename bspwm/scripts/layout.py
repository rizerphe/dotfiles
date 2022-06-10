import yaml, os
from subprocess import check_output

path = f"{os.path.expanduser('~')}/.config/bspwm/settings.yaml"

with open(path, "r") as settings:
    data = yaml.load(settings, Loader=yaml.Loader)
    layouts = data["layouts"]
    layout_names = [layout["name"] for layout in data["layouts"]]
current = [
    _
    for _ in check_output(["setxkbmap", "-query"]).decode("utf-8").split("\n")
    if "layout" in _
][0].replace("layout:     ", "")

if current in layout_names:
    index = layout_names.index(current) + 1
else:
    index = 0
if index >= len(layouts):
    index = 0

os.system(f"setxkbmap {layouts[index]['name']}")
for mod in layouts[index].get("mods", []):
    if mod["type"] == "command":
        os.system(mod["command"])
    elif mod["type"] == "modmap":
        os.system(f"xmodmap -e 'keycode {mod['keycode']} = {mod['chars']}'")

del (index, layouts, current)
