SHELL=/bin/sh
THESIS=thesis

.SUFFIXES:
.SUFFIXES: .bib .pdf .tex
.PHONY: clean

run: $(THESIS).pdf

$(THESIS).pdf: $(THESIS).bbl $(THESIS).tex $(THESIS).gls $(THESIS).acr $(THESIS).ind
	pdflatex $(THESIS).tex -draftmode
	pdflatex $(THESIS).tex 

$(THESIS).bbl: $(THESIS).aux
	bibtex $(THESIS).aux

$(THESIS).aux: $(THESIS).bib
	pdflatex $(THESIS).tex -draftmode
	pdflatex $(THESIS).tex -draftmode

$(THESIS).gls: $(THESIS).ist $(THESIS).glo
	makeindex -t $(THESIS).glg -s $(THESIS).ist -o $(THESIS).gls $(THESIS).glo

$(THESIS).acr: $(THESIS).ist $(THESIS).acn
	makeindex -t $(THESIS).alg -s $(THESIS).ist -o $(THESIS).acr $(THESIS).acn

$(THESIS).ind: $(THESIS).idx
	makeindex -t $(THESIS).ilg -o $(THESIS).ind $(THESIS).idx

clean:
	rm -rf *.aux *.lof *.log *.lot *.toc *.bbl *.blg *.pdf *.gls *.acr *.ind *.glo *.idx *.acn *.alg *.ist *.ilg *.loa *.out *.glg
