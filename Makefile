.PHONY: default build server clean invclean

include conf.mk

RM              := rm -rf
SPHINXBUILD     := sphinx-build
SPHINXAUTOBUILD := sphinx-autobuild
SPHINXAPIDOC    := sphinx-apidoc
SOURCEDIR       := src
SPHINXOPTS      := -j auto -d .doctrees \
                   -D project="$(PROJECT_NAME)" \
                   -D copyright="$(PROJECT_COPYRIGHT)" \
                   -D author="$(PROJECT_AUTHOR)" \
                   -D version="$(PROJECT_VERSION)" \
                   -D release="$(PROJECT_RELEASE)"

SOURCEFILES = $(shell find $(CODEDIR) -name \*.py)

default: build


$(SOURCEDIR)/apidoc: $(SOURCEFILES)
	SPHINX_APIDOC_OPTIONS='members' $(SPHINXAPIDOC) --force --module-first --no-toc --private -o "$(SOURCEDIR)/apidoc" $(CODEDIR)
	mv "$(SOURCEDIR)/apidoc/pseudomat.rst"{,~}


build: $(SOURCEDIR)/apidoc
	$(SPHINXBUILD) -b html $(SPHINXOPTS) "$(SOURCEDIR)" "$(BUILDDIR)"


server: $(SOURCEDIR)/apidoc
	$(SPHINXAUTOBUILD) $(SPHINXOPTS) --watch $(CODEDIR) --watch "$(SOURCEDIR)" "$(SOURCEDIR)" "$(BUILDDIR)"


clean:
	$(RM) $(BUILDDIR) .doctrees "$(SOURCEDIR)/apidoc"


invclean:
	$(RM) *.inv *.inv.txt
