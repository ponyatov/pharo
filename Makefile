
.PHONY: all
all:

.PHONY: files
files: install

# install
DEBIAN_VER  = $(shell lsb_release -rs)
DEBIAN_NAME = $(shell lsb_release -cs)
DEBIAN      = Debian_$(DEBIAN_VER)

REPO        = http://download.opensuse.org/repositories/devel

APT_FILES  += /etc/apt/sources.list.d/pharo.list
APT_FILES  += /etc/apt/trusted.gpg.d/pharo.gpg

install: $(APT_FILES)
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.*`

/etc/apt/sources.list.d/pharo.list:
	echo 'deb $(REPO):/languages:/pharo:/latest/$(DEBIAN)/ /' | sudo tee /etc/apt/sources.list.d/pharo.list

/etc/apt/trusted.gpg.d/pharo.gpg:
	curl -fsSL $(REPO):languages:pharo:latest/$(DEBIAN)/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/pharo.gpg > /dev/null
