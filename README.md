# jq kung fu

A [jq](https://github.com/stedolan/jq/) playground, powered by WebAssembly.

## Links

* [jqkungfu.com](https://jqkungfu.com)
* [sandbox.bio's jq Playground](https://jqkungfu.com)
* [jq Tutorial](https://sandbox.bio/tutorials?id=jq-intro)
* [Use jq in your own web apps](https://github.com/biowasm/biowasm/tree/main/tools/jq#jqwasm)


## How?

jqkungfu was built by compiling [jq](https://github.com/stedolan/jq/) to WebAssembly, so that it runs in the browser.

The advantages of this approach are:

- **Speed**: After the initial load time, jq queries are very fast because there are no round trips to a server
- **Security**: This approach runs jq within the browser; otherwise, we would need to carefully secure the app so that users can't run arbitrary commands on the server!
- **Convenience**: The app is purely front-end and is hosted as static files on a cloud storage provider

## Launch locally

To launch jqkungfu locally:

```bash
python3 -m http.server 9999
```

Then open [http://localhost:9999](http://localhost:9999) in your browser.


## Compile to WebAssembly (optional)

To compile jq to WebAssembly, run the `compile.sh` code within an environment that includes [Emscripten](https://github.com/emscripten-core/emscripten).

To set up your environment:

```bash
# Make sure to use "--recursive" so the jq submodule is initialized
$ git clone --recursive https://github.com/robertaboukhalil/jqkungfu.git

# Build the Docker image with needed dependencies
$ docker build -t jqkungfu .

# Compile to WebAssembly
$ docker run --rm -it -v $(pwd):/src --entrypoint ./compile.sh jqkungfu
```

## Learn More

This app is part of an example built for my book [Level up with WebAssembly](https://levelupwasm.com). Check it out if you're interested in more details, or to learn how to create similar applications.
