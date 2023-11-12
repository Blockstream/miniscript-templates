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

GIT_HASH                                := $(shell git rev-parse --short HEAD 2>/dev/null || echo $(PROJECT_NAME))
export GIT_HASH

##	: 
##Submit:
##	
##	1. Add your template to the GNUmakefile TEMPLATES list
##	2. make && make serve
##	3. Check html is rendered correctly
##	4. Submit pull request

TEMPLATES:=\
SUBMISSIONS \
DEVELOPERS \
mint-000 \
mint-001 \
mint-002

.PHONY:-
-:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo

all:README $(TEMPLATES)## 	build html templates

help:## 	help
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/	/'

serve:strip## 	serve
	@. serve 2>/tmp/serve.log

.ONESHELL:
strip:
	@(\
	if [[ "$(shell uname -s)" == "Linux" ]]; \
	then \
		sed -i     's/\\_\\_NOTOC\\_\\_//' *.md    >/dev/null  && \
		sed -i     's/\\_\\_NOTOC\\_\\_//' *.html  >/dev/null  && \
		sed -i     's/.md/.html/' index.html       >/dev/null  && \
		sed -i     's/.md/.html/' DEVELOPERS.html  >/dev/null  && \
		sed -i     's/.md/.html/' SUBMISSIONS.html >/dev/null; fi)
	@(\
	if [[ "$(shell uname -s)" == "Darwin" ]]; \
	then \
		sed -i  '' 's/\\_\\_NOTOC\\_\\_//' *.md    >/dev/null  && \
		sed -i  '' 's/\\_\\_NOTOC\\_\\_//' *.html  >/dev/null  && \
		sed -i  '' 's/.md/.html/' index.html       >/dev/null  && \
		sed -i  '' 's/.md/.html/' DEVELOPERS.html  >/dev/null  && \
		sed -i  '' 's/.md/.html/' SUBMISSIONS.html >/dev/null; fi)

.PHONY: report
report:## 	make variables
	@echo $(GIT_HASH) > version
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
	@echo 'GIT_HASH=${GIT_HASH}'
	@echo ''
	@echo 'TEMPLATES=${TEMPLATES}'

README:
	@touch version
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
	@command \
		-v \
		pandoc >/dev/null 2>&1 && \
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

.PHONY: version
version:## 	make version
#signed releases?
	@echo $(GIT_HASH) > version

checkbrew:## 	install brew command
ifeq ($(HOMEBREW),)
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@type brew && brew install pandoc
	@type brew && brew install emscripten
	@type brew && brew install --cask docker
endif

.PHONY:$(TEMPLATES) serve

#add additional make commands
-include Makefile
