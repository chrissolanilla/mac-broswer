.PHONY: build clean
default: build

build:
	# clang -fobjc-arc -framework Cocoa main.m -o build/bustoBrowser
	clang -fobjc-arc -framework Cocoa  main.m c_lib/http.c  -lcurl -o build/bustoBrowser


clean:
	rm -rf build/bustoBrowser
