#!/usr/bin/env sh

# Echo function that behaves consistently across shells
echo() { printf '%s\n' "$*";}

# Compile jq to WebAssembly

# Need Emscripten installed
if ! command -v emcc > /dev/null 2>&1; then
  echo 'You need Emscripten to compile jq to WebAssembly. See the setup instructions in the README file.'
  exit 2
fi >&2

# Update jq repo and its submodules
cd jq || exit 2
git submodule update --init --recursive

# Edit main.c so that reset option flags to 0 every time we call the main() function
# This is needed because we're not exiting after each main() call; otherwise, the
# "Sort Keys" feature wouldn't work
git apply ../jq.patch 2> /dev/null

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
mv jq.js jq.wasm ../build/
