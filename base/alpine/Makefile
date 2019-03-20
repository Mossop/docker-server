build:
	docker build . --compress --squash -t tmpimage
	docker create --name tmpcontainer tmpimage
	docker export tmpcontainer | docker import -c 'CMD ["/bin/sh"]' -m "Import updated alpine" - mossop/alpine
	docker container rm tmpcontainer
	docker image rm tmpimage
	docker tag mossop/alpine mossop/alpine:latest
