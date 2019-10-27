#!/bin/bash

# Compile jq to WebAssembly
# Need Emscripten installed

# Update jq repo and its submodules
cd jq
git submodule update --init
git submodule update --init

# Edit main.c so that reset option flags to 0 every time we call the main() function
# This is needed because we're not exiting after each main() call; otherwise, the
# "Sort Keys" feature wouldn't work
MAIN_FN="int main(int argc, char\* argv\[\]) {"
sed -i "s/${MAIN_FN}/${MAIN_FN} options = 0; /" src/main.c | grep "int main"

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
  -s EXTRA_EXPORTED_RUNTIME_METHODS='["callMain"]' \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0
