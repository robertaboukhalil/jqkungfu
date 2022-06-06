#!/bin/bash

# Compile jq to WebAssembly

# Need Emscripten installed
[[ ! $(command -v emcc --version) ]] && \
  echo "You need Emscripten to compile jq to WebAssembly. See the setup instructions in the README file." && \
  exit

# Update jq repo and its submodules
cd jq
git submodule update --init --recursive

# Edit main.c so that reset option flags to 0 every time we call the main() function
# This is needed because we're not exiting after each main() call; otherwise, the
# "Sort Keys" feature wouldn't work
git apply ../jq.patch

# Generate ./configure file
autoreconf -fi

# Run ./configure
emconfigure ./configure \
    --with-oniguruma=builtin \
    --disable-maintainer-mode

# Compile jq and generate .js/.wasm files
emmake make \
  EXEEXT=.js \
  CFLAGS="-O2 -s EXPORTED_RUNTIME_METHODS=['callMain']"

mkdir -p ../build/
mv jq.{js,wasm} ../build/
