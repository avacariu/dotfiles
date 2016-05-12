all:
	echo "update symlinks"

update-submodules:
	git submodule update --init --recursive

upgrade-submodules:
	# will need a line for each submodule since some use different branches
	echo "git submodule foreach git pull"

rebuild-ycm:
	echo

.PHONY: all update-submodules upgrade-submodules rebuild-ycm
