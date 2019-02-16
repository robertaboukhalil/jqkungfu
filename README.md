# jq kungfu

A [jq](https://github.com/stedolan/jq/) playground, written in WebAssembly.

## How?

jqkungfu was built by compiling [jq](https://github.com/stedolan/jq/) into WebAssembly, so that it can run in the browser.

The advantages of this approach are:

- **Speed**: After the initial load time, jq queries are very fast because there are no round trips to a server
- **Security**: This approach runs jq within the browser; otherwise, we would need to carefully secure the app so that users can't run arbitrary commands on the server!
- **Convenience**: The app is purely front-end and is hosted as static files on a cloud storage provider

## Setup

To compile jq to WebAssembly, run the `compile.sh` code within an environment that includes <a href="https://github.com/emscripten-core/emscripten">Emscripten</a>.

## Learn More

This app is part of an example built for my book <a href="http://levelupwasm.com">Level up with WebAssembly</a>. Check it out if you're interested in more details, or to learn how to create similar applications.
