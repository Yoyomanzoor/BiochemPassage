# MedicinalYoyos
# July 2023

DATE := $(shell date --iso=seconds)
SRC_FILES = main.tex main.pdf 
RM_FILES = $(filter-out $(SRC_FILES), $(wildcard main.*))

.PHONY: all
all:
	$(MAKE) everything 2>&1 | tee -a Make.log

.PHONY: everything
everything: clean pdf open

.PHONY: commit
commit: 
	$(MAKE) everything 2>&1 | tee -a Make.log
	git add .
	git commit -m "Make commit"
	git push

.PHONY: compile
compile:
	$(MAKE) rebuild 2>&1 | tee -a Make.log

.PHONY: rebuild
rebuild: pdf open

.PHONY: pdf
pdf:
	@echo " *"
	@echo " *      Date: $(DATE)"
	@echo " *"
	pdflatex main.tex
	biber main.bcf
	pdflatex main.tex

.PHONY: open
open:
	@xdg-open main.pdf

.PHONY: clean
clean:
	# rm -f main.pdf
	rm -rf $(RM_FILES)
	# rm -f Make.log
