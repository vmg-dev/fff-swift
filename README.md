# FFF Swift

FFF Swift packages a Floodlight-focused build of
[FFF](https://github.com/dmtrKovalenko/fff) as a static XCFramework and exposes
it through Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/vmg-dev/fff-swift", from: "0.1.0")
]
```

The `FFFKit` product provides a Swift concurrency API for starting an index,
searching files and folders, observing scan progress, and tracking frecency.
Consumers do not need a Rust toolchain.

## Development

Build the local XCFramework before running Swift tests:

```sh
make build
make test
```

The vendored FFF source is based on version 0.7.1 and includes the changes
listed in [`Vendor/fff/UPSTREAM.md`](Vendor/fff/UPSTREAM.md).

## License

FFF Swift is available under the MIT License. The vendored FFF source retains
its original MIT license and copyright notices.

