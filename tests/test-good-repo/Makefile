.PHONY: test lint install run

install:
	pip install -e .

test:
	PYTHONPATH=src python -m unittest discover -s tests -v

lint:
	python -m compileall src

run:
	python -m good.cli
