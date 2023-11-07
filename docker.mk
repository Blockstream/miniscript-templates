.ONESHELL:
docker-start:## 	start docker on Linux or Darwin
	echo $(GITHUB_JOB)
	@[[ "$(OS)" == "Linux" ]] && \
		[[ "$(GITHUB_JOB)" != "build" ]] && \
		echo "!=" || echo ""
	@[[ "$(OS)" == "Darwin" ]] && \
		[[ "$(GITHUB_JOB)" != "build" ]] && \
		echo "!=" || echo ""
	@( \
	    echo $(GITHUB_JOB);\
	    while ! docker system info > /dev/null 2>&1; do\
	    echo 'Waiting for docker to start...';\
	    if [[ "$(OS)" == "Linux" ]] && [[ "$(GITHUB_JOB)" != "build" ]]; then\
	     type -P systemctl && systemctl restart docker.service || type -P service && service restart docker;\
	    fi;\
	    if [[ "$(OS)" == "Darwin" ]] && [[ "$(GITHUB_JOB)" != "build" ]]; then\
	     type -P docker && open --background -a /./Applications/Docker.app/Contents/MacOS/Docker || brew install --cask docker;\
	    fi;\
	sleep 1;\
	echo $(GITHUB_JOB);\
	done\
	)
