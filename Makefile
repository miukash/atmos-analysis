IMAGE := atmos-analysis:v1.0

pull:
	docker pull $(IMAGE)
    
build:
	docker build -t $(IMAGE) .

test:
	docker run --rm $(IMAGE) bash /workspace/tests/test_environment.sh

shell:
	docker run --rm -it $(IMAGE) bash