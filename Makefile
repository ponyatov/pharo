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

# doc
.PHONY: doc
doc: doc/yazyk_programmirovaniya_d.pdf doc/Programming_in_D.pdf

doc/yazyk_programmirovaniya_d.pdf:
	$(CURL) $@ https://www.k0d.cc/storage/books/D/yazyk_programmirovaniya_d.pdf
doc/Programming_in_D.pdf:
	$(CURL) $@ http://ddili.org/ders/d.en/Programming_in_D.pdf

# install
.PHONY: install update gz
install: doc gz
	$(MAKE) update
	dub fetch dfmt
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
gz: \
	$(GZ)/pharo-vm-Linux-x86_64-stable.zip \
	$(GZ)/pharo64_image.zip

$(GZ)/pharo-vm-Linux-x86_64-stable.zip:
	$(CURL) $@ http://files.pharo.org/get-files/110/pharo-vm-Linux-x86_64-stable.zip

$(GZ)/pharo64_image.zip:
	$(CURL) $@ https://files.pharo.org/get-files/110/pharo64.zip
