import yaml, os
from subprocess import check_output 

path = f"{os.path.expanduser('~')}/.config/bspwm/settings.yaml"

with open(path, 'r') as settings:
	data = yaml.load(settings, Loader=yaml.Loader)
	layouts = data["layouts"]
current = [_ for _ in check_output(
		["setxkbmap", "-query"]
	).decode("utf-8").split(
		'\n'
	) if 'layout' in _][0].replace(
	"layout:     ", ''
)

index = layouts.index(current) + 1
if index >= len(layouts):
	index = 0

os.system(f"setxkbmap {layouts[index]}")

del(index, layouts, current)
