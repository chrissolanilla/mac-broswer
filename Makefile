.PHONY: build clean
default: build

build:
	clang -fobjc-arc -framework Cocoa main.m -o build/bustoBrowser

clean:
	rm -rf build/bustoBrowser
