# jq kungfu

A [jq](https://github.com/stedolan/jq/) playground, powered by WebAssembly.

## Links

* [jq Playground](https://jqkungfu.com)
* [jq Tutorial](https://sandbox.bio/tutorials?id=jq-intro)
* [Use jq in your own web apps](https://github.com/biowasm/biowasm/tree/main/tools/jq#jqwasm)


## How?

jqkungfu was built by compiling [jq](https://github.com/stedolan/jq/) to WebAssembly, so that it runs in the browser.

The advantages of this approach are:

- **Speed**: After the initial load time, jq queries are very fast because there are no round trips to a server
- **Security**: This approach runs jq within the browser; otherwise, we would need to carefully secure the app so that users can't run arbitrary commands on the server!
- **Convenience**: The app is purely front-end and is hosted as static files on a cloud storage provider

## Setup

To compile jq to WebAssembly, run the `compile.sh` code within an environment that includes <a href="https://github.com/emscripten-core/emscripten">Emscripten</a>.

## Docker

You can also build the web application into a Docker container! First build the container:

```bash
$ docker build -t jqkungfu .
```

And then run it, exposing port 80 on your host:

```bash
$ docker run --name jqkungfu -d --rm -p 80:80 -it jqkungfu
```

You should then be able to open your browser to `127.0.0.1`, and interact with
the application. When you are done, stop the container:

```bash
$ docker stop jqkungfu
```

## Static

To generate the files in the [docs](docs) folder here (for example, if you wanted to
deploy on GitHub pages) we simply create symbolic links to index.html and the loading.gif:

```bash
mkdir -p docs
ln index.html docs/index.html
ln loading.gif docs/loading.gif
```
And then after we have started the container, copy the final web files to docs from it:

```bash
$ docker cp jqkungfu:/var/www/html/jq.wasm docs/jq.wasm
$ docker cp jqkungfu:/var/www/html/jq.js docs/jq.js
```

And then you can serve the folder with any web server of your choosing:

```bash
cd docs
python -m http.server 9999
```

## Learn More

This app is part of an example built for my book <a href="http://levelupwasm.com">Level up with WebAssembly</a>. Check it out if you're interested in more details, or to learn how to create similar applications.
