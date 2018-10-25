
debug:
	swift build

release:
	swift build -c release -Xswiftc -static-stdlib

run:
	swift run

update:
	swift package update

resolve:
	swift package resolve

clean:
	rm -rf .build

test:
	swift test

xcode:
	swift package generate-xcodeproj

edit:
	vim Package.swift

