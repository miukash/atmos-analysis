IMAGE := atmos-analysis:v1.0

DATA_DIR := $(CURDIR)/data

.PHONY: pull build test shell fv open-data

pull:
	docker pull $(IMAGE)

build:
	docker build -t $(IMAGE) .

test:
	docker run --rm $(IMAGE) bash /workspace/tests/test_environment.sh

shell:
	docker run --rm -it \
		-v "$(DATA_DIR):/workspace/data" \
		$(IMAGE) \
		bash

fv:
	docker run --rm -it \
		-e DISPLAY=$$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v "$(DATA_DIR):/workspace/data" \
		$(IMAGE) \
		bash

open-data:
	explorer.exe "$$(wslpath -w "$(DATA_DIR)")"