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

.PHONY: pharo
pharo: pharo/pharo
	$^ `ls pharo/*.image`
	
# format
format: tmp/format_d
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# rule
bin/$(MODULE): $(D) $(J) Makefile
	$(BLD)

# doc
.PHONY: doc
doc: doc/yazyk_programmirovaniya_d.pdf doc/Programming_in_D.pdf \
	doc/learningoop-wip.pdf doc/PharoWithStyle.pdf \
	doc/SpecBooklet.pdf doc/smacc.pdf doc/AMiniScheme-wip.pdf

doc/yazyk_programmirovaniya_d.pdf:
	$(CURL) $@ https://www.k0d.cc/storage/books/D/yazyk_programmirovaniya_d.pdf
doc/Programming_in_D.pdf:
	$(CURL) $@ http://ddili.org/ders/d.en/Programming_in_D.pdf

doc/learningoop-wip.pdf:
	$(CURL) $@ https://github.com/SquareBracketAssociates/LearningOOPWithPharo/releases/download/v1.0/learningoop-wip.pdf
doc/PharoWithStyle.pdf:
	$(CURL) $@ https://github.com/SquareBracketAssociates/Booklet-PharoWithStyle/releases/download/latest/PharoWithStyle.pdf
doc/SpecBooklet.pdf:
	$(CURL) $@ https://ci.inria.fr/pharo-contribution/view/Books/job/BuildingUIWithSpec/lastSuccessfulBuild/artifact/book-result/SpecBooklet.pdf
doc/smacc.pdf:
	$(CURL) $@ https://github.com/SquareBracketAssociates/Booklet-Smacc/releases/download/continuous/smacc.pdf
doc/AMiniScheme-wip.pdf:
	$(CURL) $@ https://github.com/SquareBracketAssociates/Booklet-AMiniSchemeInPharo/releases/download/continuous/AMiniScheme-wip.pdf


# install
.PHONY: install update gz
install: doc gz
	$(MAKE) update
	dub fetch dfmt
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
gz: \
	pharo/pharo pharo/pharo.version

pharo/pharo: $(GZ)/pharo-vm-Linux-x86_64-stable.zip
	unzip $< -d pharo && touch $@

$(GZ)/pharo-vm-Linux-x86_64-stable.zip:
	$(CURL) $@ http://files.pharo.org/get-files/110/pharo-vm-Linux-x86_64-stable.zip

pharo/pharo.version: $(GZ)/pharo64_image.zip
	unzip $< -d pharo && touch $@

$(GZ)/pharo64_image.zip:
	$(CURL) $@ https://files.pharo.org/get-files/110/pharo64.zip
