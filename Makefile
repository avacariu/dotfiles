.PHONY: all
all:
	echo "update symlinks"

.PHONY: update
update:
	git pull
	# we need to ensure the URLs for the submodules are all correct, because
	# sometimes they change (e.g. in python-mode's own submodules)
	git submodule sync --recursive
	git submodule update --recursive --init --force
	bash ./setup.sh


.PHONY: upgrade-submodules
upgrade-submodules:
	# we need to ensure the URLs for the submodules are all correct, because
	# sometimes they change (e.g. in python-mode's own submodules)
	# TODO: figure out when exactly this is necessary, and which command is
	# necessary
	git submodule update --recursive --init --force
	git submodule sync --recursive
	git submodule update --remote
