.PHONY: test lint install run

install:
	pip install -e .

test:
	python -m unittest discover -s tests -v

lint:
	python -m compileall src

run:
	python -m good.cli
