# Vendored FFF source

This directory vendors [FFF](https://github.com/dmtrKovalenko/fff) version
0.10.5 at commit `459ebcdbdba094843fe5339a1a7f7dae4ced2d82`.

FFF Swift modifies the vendored source to:

- optionally exclude common binary formats from non-git filename indexes;
- register watcher-created directories and their ancestors as first-class
  search results after incremental filesystem changes;
- expose that configuration through the versioned C API; and
- build `fff-c` as a static library for XCFramework distribution.

The original FFF MIT license remains at [`LICENSE`](LICENSE). Updates should
be imported with `git subtree`, reviewed against these changes, and tested with
both `cargo test` and the FFFKit Swift test suite.
