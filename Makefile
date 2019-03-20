FILES=$(shell find . -name ".repo")
REPOS=$(foreach file,$(FILES),$(shell cat $(file)))

build: $(REPOS)

publish: $(foreach repo,$(REPOS),upload/$(repo))

mossop/%:
	@echo "Building $@..."
	$(eval DIR=$(shell find . -name ".repo" -exec grep -q ^$@$$ {} \; -print | xargs -n 1 dirname))
	@if [[ -f "$(DIR)/Makefile" ]]; then \
	  make -C $(DIR); \
	else \
	  docker build $(DIR) --compress --squash -t $@ -t $@:latest; \
	fi
	@echo ""

upload/%:
	docker push $*:latest
	@echo ""

mossop/alpine-build: mossop/alpine

mossop/openvpn: mossop/alpine

mossop/dovecot: mossop/alpine

mossop/postfix: mossop/alpine

mossop/nginx: mossop/alpine-build

mossop/nginx-php: mossop/nginx
