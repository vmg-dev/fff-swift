# Vendored FFF source

This directory vendors [FFF](https://github.com/dmtrKovalenko/fff) version
0.10.3 at commit `e2cad2f09ea617d4c024f396f21d80e557f23a17`.

FFF Swift modifies the vendored source to:

- optionally exclude common binary formats from non-git filename indexes;
- register watcher-created directories and their ancestors as first-class
  search results after incremental filesystem changes;
- expose that configuration through the versioned C API; and
- build `fff-c` as a static library for XCFramework distribution.

The original FFF MIT license remains at [`LICENSE`](LICENSE). Updates should
be imported with `git subtree`, reviewed against these changes, and tested with
both `cargo test` and the FFFKit Swift test suite.
