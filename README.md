# Build Patch Tool for the Epic Games Store in Docker

**Docker image for the Build Patch Tool for Epic Games Store publishing, ment to be used within CI/CD environments.**

[![Docker Image Size](https://badgen.net/docker/size/mrbandler/bpt?icon=docker&label=Size)](https://hub.docker.com/r/mrbandler/bpt/)
[![Docker Pulls](https://badgen.net/docker/pulls/mrbandler/bpt?icon=docker&label=Pulls)](https://hub.docker.com/r/mrbandler/bpt/)

---

## Table Of Content

1. [Overview](#1-overview) 👀
2. [Usage](#2-usage) ⌨️
3. [Bugs and Features](#3-bugs-and-features) 🐞💡
4. [License](#4-license) 📃

## 1. Overview

> **⚠️ Tags always represent the version of the Build Patch Tool**

The image is based off of [`debian:stable-slim`](https://hub.docker.com/_/debian) with a few caveats.

- A custom user (`bpt:bpt`) has been added since the binary expects a non-root user to execute it.
- To make it usable within CI/CD environments, where other software might be needed, the above mentioned user can execute `sudo` without a password.
- The package `xdg-user-dirs` has been installed since the binary expects it to be installed and exits with a non-zero exit code if it's not present.
- A binary wrapper script has been added with which the binary can be called from everywhere: `bpt -help`.

## 2. Usage

**Pull Image**

```bash
docker pull mrbandler/bpt:latest
```

**Run Image**

```bash
docker run -it mrbandler/bpt:latest <add arguments or system command here>
```

[![Demonstration](https://asciinema.org/a/582947.svg)](https://asciinema.org/a/582947)

## 3. Bugs and Features

Please open a issue when you encounter any bugs 🐞 or if you have an idea for a additional feature 💡.

## 4. License

MIT License

Copyright (c) 2023 mrbandler

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
