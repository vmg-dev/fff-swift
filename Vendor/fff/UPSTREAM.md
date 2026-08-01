# Vendored FFF source

This directory vendors [FFF](https://github.com/dmtrKovalenko/fff) version
0.7.1 at commit `e8dd50ce5a6857f2dc7f827746163a4b1040ba9c`.

FFF Swift modifies the vendored source to:

- retain common binary formats for filename-only indexing;
- index ancestor directories as first-class search results;
- keep files and directories current after live filesystem changes;
- expose the corresponding configuration through the C API; and
- build `fff-c` as a static library for XCFramework distribution.

The original FFF MIT license remains at [`LICENSE`](LICENSE). Updates should
be imported with `git subtree`, reviewed against these changes, and tested with
both `cargo test` and the FFFKit Swift test suite.

