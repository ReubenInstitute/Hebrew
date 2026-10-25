PYPI_TOKEN ?= ~/pypi.txt

.PHONY: pip install-pip upload clean deb deb-termux all

all: pip deb deb-termux

pip:
	mkdir -p build/pip
	cp hebrew.py number.py __init__.py pip/pyproject.toml LICENSE build/pip/
	cd build/pip && python3 -m build --outdir .

deb:
	$(MAKE) -f debian/rules deb

deb-termux:
	$(MAKE) -f debian/rules deb-termux

install-pip:
	python3 -m pip install build/pip/*.whl

upload:
	TWINE_USERNAME=__token__ TWINE_PASSWORD=$$(cat $(PYPI_TOKEN)) twine upload build/pip/*.whl build/pip/*.tar.gz

clean:
	rm -rf build