.PHONY: default build server clean invclean

include conf.mk

RM              := rm -rf
SPHINXBUILD     := sphinx-build
SPHINXAUTOBUILD := sphinx-autobuild
SPHINXAPIDOC    := sphinx-apidoc
SPHINXOPTS      := -j auto -d .doctrees \
                   -D project="$(PROJECT_NAME)" \
                   -D copyright="$(PROJECT_COPYRIGHT)" \
                   -D author="$(PROJECT_AUTHOR)" \
                   -D version="$(PROJECT_VERSION)" \
                   -D release="$(PROJECT_RELEASE)"


default: build


$(SOURCEDIR)/apidoc:
	SPHINX_APIDOC_OPTIONS='members' $(SPHINXAPIDOC) --force --module-first --no-toc --private -o "$(SOURCEDIR)/apidoc" $(CODEDIR)
	mv "$(SOURCEDIR)"/apidoc/pseudomat.rst{,.bak}


build: $(SOURCEDIR)/apidoc
	$(SPHINXBUILD) -b html $(SPHINXOPTS) "$(SOURCEDIR)" "$(BUILDDIR)"


server: $(SOURCEDIR)/apidoc
	@$(AUTOBUILD) "$(BUILDDIR)" $(SPHINXOPTS) --watch $(CODEDIR) --watch "$(SOURCEDIR)" "$(SOURCEDIR)"


clean:
	@$(RM) $(BUILDDIR) .doctrees "$(SOURCEDIR)/apidoc"


invclean:
	@$(RM) *.inv *.inv.txt
