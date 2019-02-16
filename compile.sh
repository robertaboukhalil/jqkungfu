#!/bin/bash

# Compile jq to WebAssembly
# Need Emscripten installed

# Update jq repo and its submodules
cd jq
git submodule update --init

# Generate ./configure file
autoreconf -fi

# Run ./configure
emconfigure ./configure \
    --with-oniguruma=builtin \
    --disable-maintainer-mode

# Build jq executable
emmake make LDFLAGS=-all-static

# Convert to .o; otherwise emcc complains
# that the "file has an unknown suffix"
cp jq ../jq.o
cd ..

# Compile to WebAssembly (we need .js/.wasm files; we can't execute jq.o in the browser)
# - Use "ERROR_ON_UNDEFINED_SYMBOLS=0" to ignore "undefined symbol: llvm_fma_f64" warning
emcc jq.o -o jq.js \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0
