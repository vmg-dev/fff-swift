.PHONY: build cargo-test clean lint release-archive test

build:
	./scripts/build-xcframework.sh

cargo-test:
	cargo test --manifest-path Vendor/fff/Cargo.toml --package fff-search --package fff-c --locked

test: build
	swift test

lint:
	cargo fmt --manifest-path Vendor/fff/Cargo.toml --all -- --check
	cargo clippy --manifest-path Vendor/fff/Cargo.toml --package fff-search --package fff-c --all-targets -- -D warnings

release-archive:
	./scripts/create-release-archive.sh

clean:
	swift package clean
	cargo clean --manifest-path Vendor/fff/Cargo.toml

