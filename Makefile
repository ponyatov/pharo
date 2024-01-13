# var
MODULE  = $(notdir $(CURDIR))

# dir
CWD = $(CURDIR)
BIN = $(CWD)/bin
TMP = $(CWD)/tmp
SRC = $(CWD)/src
GZ  = $(HOME)/gz

# tool
CURL = curl -L -o
DC   = dmd
RUN  = dub run   --compiler=$(DC)
BLD  = dub build --compiler=$(DC)

# src
D += $(wildcard src/*.d*)

# all
.PHONY: all
all: $(D)
	$(RUN)
	
# format
format: tmp/format_d
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# rule
bin/$(MODULE): $(D) $(J) Makefile
	$(BLD)

# # # install
# # DEBIAN_VER  = $(shell lsb_release -rs)
# # DEBIAN_NAME = $(shell lsb_release -cs)
# # DEBIAN      = Debian_$(DEBIAN_VER)

# doc
.PHONY: doc
doc: doc/yazyk_programmirovaniya_d.pdf doc/Programming_in_D.pdf

doc/yazyk_programmirovaniya_d.pdf:
	$(CURL) $@ https://www.k0d.cc/storage/books/D/yazyk_programmirovaniya_d.pdf
doc/Programming_in_D.pdf:
	$(CURL) $@ http://ddili.org/ders/d.en/Programming_in_D.pdf

# APT_FILES  += /etc/apt/sources.list.d/pharo.list
# # APT_FILES  += /etc/apt/trusted.gpg.d/pharo.gpg

# install
.PHONY: install update gz
install: doc gz $(APT_FILES)
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.*`
gz: \
	$(GZ)/pharo-vm-Linux-x86_64-stable.zip

$(GZ)/pharo-vm-Linux-x86_64-stable.zip:
	$(CURL) $@ http://files.pharo.org/get-files/110/pharo-vm-Linux-x86_64-stable.zip

# # /etc/apt/sources.list.d/pharo.list:
# # 	echo 'deb $(REPO):/languages:/pharo:/latest/$(DEBIAN)/ /' | sudo tee /etc/apt/sources.list.d/pharo.list

# # /etc/apt/trusted.gpg.d/pharo.gpg:
# # 	curl -fsSL $(REPO):languages:pharo:latest/$(DEBIAN)/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/pharo.gpg > /dev/null

http://files.pharo.org/get-files/110/pharo-vm-Linux-x86_64-stable.zip
