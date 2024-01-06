NIXNAME ?= lenovo-5-amd

system:
	sudo nixos-rebuild switch --flake ".#${NIXNAME}"

.PHONY: system
