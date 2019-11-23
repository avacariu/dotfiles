all:
	echo "update symlinks"

update-submodules:
	git submodule update --recursive --init --force
	git submodule sync --recursive
	git submodule update --remote

.PHONY: all update-submodules
