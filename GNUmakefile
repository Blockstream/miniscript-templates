ifeq ($(project),)
PROJECT_NAME                            := $(notdir $(PWD))
else
PROJECT_NAME                            := $(project)
endif
export PROJECT_NAME
VERSION                                 :=$(shell cat version)
export VERSION
TIME                                    :=$(shell date +%s)
export TIME

OS                                      :=$(shell uname -s)
export OS
OS_VERSION                              :=$(shell uname -r)
export OS_VERSION
ARCH                                    :=$(shell uname -m)
export ARCH
ifeq ($(ARCH),x86_64)
TRIPLET                                 :=x86_64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif
ifeq ($(ARCH),arm64)
TRIPLET                                 :=aarch64-linux-gnu
export TRIPLET
endif

HOMEBREW                                :=$(shell which brew || false)

PANDOC                                  :=$(shell which pandoc || false)

RUSTUP_INIT_SKIP_PATH_CHECK=yes
TOOLCHAIN=stable
Z=	##
ifneq ($(toolchain),)

ifeq ($(toolchain),nightly)
TOOLCHAIN=nightly
Z=-Z unstable-options
endif

ifeq ($(toolchain),stable)
TOOLCHAIN=stable
Z=	##
endif

endif

##	: 
##About
##	: 
##	Miniscript is a language for
##	writing (a subset of) Bitcoin Scripts
##	in a structured way, enabling analysis,
##	composition, generic signing and more.
##	: 
##	: 
##Submit:
##	
##	1. Add your template to the TEMPLATES list
##	2. Add your template to the TOC.mediawiki
##	3. make && make serve
##	4. Check html is rendered correctly
##	5. Submit pull request

TEMPLATES:=\
MinT-000 \
MinT-001 \
MinT-002 \
MinT-003 \
MinT-004 \
TOC.mediawiki

.PHONY:-
-:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo

all:README $(TEMPLATES)## 	all: build html templates
	##$(MAKE) strip

help:## 	help
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/	/'

serve:strip## 	serve
	@. serve 2>/tmp/serve.log

.ONESHELL:
strip:
	@(\
	if [[ "$(shell uname -s)" == "Linux" ]]; \
	then \
		sed -i  's/\\_\\_NOTOC\\_\\_//' *.md   >/dev/null  && \
		sed -i  's/\\_\\_NOTOC\\_\\_//' *.html >/dev/null  && \
		sed -i  's/.md/.html/' index.html      >/dev/null; fi)
	@(\
	if [[ "$(shell uname -s)" == "Darwin" ]]; \
	then \
		sed -i  '' 's/\\_\\_NOTOC\\_\\_//' *.md   >/dev/null  && \
		sed -i  '' 's/\\_\\_NOTOC\\_\\_//' *.html >/dev/null  && \
		sed -i  '' 's/.md/.html/' index.html      >/dev/null; fi)

.PHONY: report
report:## 	make variables
	@echo ''
	@echo 'TIME=${TIME}'
	@echo 'PROJECT_NAME=${PROJECT_NAME}'
	@echo 'VERSION=${VERSION}'
	@echo ''
	@echo 'OS=${OS}'
	@echo 'OS_VERSION=${OS_VERSION}'
	@echo 'ARCH=${ARCH}'
	@echo ''
	@echo 'HOMEBREW=${HOMEBREW}'
	@echo 'PANDOC=${PANDOC}'
	@echo ''
	@echo 'TEMPLATES=${TEMPLATES}'
	@echo 'TEMPLATES_MEDIAWIKI=${TEMPLATES_MEDIAWIKI}'
	@echo 'TEMPLATES_MD=${TEMPLATES_MD}'
	@echo 'TEMPLATES_HTML=${TEMPLATES_HTML}'

README:
	@which pandoc
	@command \
		-v \
		pandoc >/dev/null 2>&1 && \
		pandoc \
		--preserve-tabs \
		--ascii \
		--from=markdown \
		--to=html $@.md | \
		sed 's/__NOTOC__//' > index.html || \
		command -v docker && \
		docker \
		pull \
		pandoc/latex:2.6 && \
		docker \
		run \
		--rm \
		--volume "`pwd`:/data" \
		--user `id -u`:`id -g` \
		pandoc/latex:2.6 $@.md > index.html || echo "start docker"
	

$(TEMPLATES):
	@command -v pandoc >/dev/null 2>&1 && \
		pandoc \
		--preserve-tabs \
		--ascii \
		--from=markdown \
		--to=html $@.md | \
		sed 's/__NOTOC__//' > $@.html || \
		command -v docker 2>/dev/null && \
		docker pull pandoc/latex:2.6 && \
		docker run \
		--rm \
		--volume "`pwd`:/data" \
		--user `id -u`:`id -g` \
		pandoc/latex:2.6 $@.md && \
		sed -i '' 's/\\_\\_NOTOC\\_\\_//' $@.html || echo "start docker"

## $(TEMPLATES_MD):
## 	@echo AT2 $@
## 	@echo DOLLAR_CARROT_AT $^@
## 	@echo DOLLAR_HAT $^
## 	@echo DOLLAR_PERCENT $%
## 	@echo DOLLAR_LT $<
## 	@echo DOLLAR_Q $?
## 	@echo DOLLAR_BAR $|
## ##@touch $@
## ##@touch $^@
## 	@command -v pandoc >/dev/null 2>&1 && \
## 		pandoc --preserve-tabs --ascii --from=markdown --to=html $@ | \
## 		sed 's/__NOTOC__//' > $@ || command -v docker 2>/dev/null && docker pull pandoc/latex:2.6 && \
## 		docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` pandoc/latex:2.6 $@ && sed -i '' 's/\\_\\_NOTOC\\_\\_//' $@.html || $(MAKE) docker-start
## 
## $(TEMPLATES_HTML):

checkbrew:## 	install brew command
ifeq ($(HOMEBREW),)
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@type brew && brew install pandoc
	@type brew && brew install emscripten
	@type brew && brew install --cask docker
endif

submodules:## 	submodules
	@git submodule update --init --recursive

.PHONY:$(TEMPLATES) $(TEMPLATES_MD) serve

-include docker.mk
