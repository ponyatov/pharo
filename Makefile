.PHONY: all
all:

.PHONY: files
files: update

install update:
	sudo apt update
	sudo apt install -yu `cat apt.*`
