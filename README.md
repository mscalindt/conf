## Table of Contents

1. [Introduction](#introduction)
2. [Build](#build)
3. [Run](#run)
4. [Releases](#releases)
5. [License](#license)
6. [Notice](#notice)

## Introduction

The system configuration/dotfiles of `mscalindt` using the `syscfg` API.

[syscfg at GitHub](https://github.com/mscalindt/syscfg)\
[syscfg at GitLab](https://gitlab.com/mscalindt/syscfg)\
[syscfg at Codeberg](https://codeberg.org/mscalindt/syscfg)

## Build

Clone the repository using the `--recursive` option to ensure all submodules
are downloaded.

```
git clone --recursive https://github.com/mscalindt/conf
cd conf
make CONF=__DEVICE__.conf
```

If the repository has been cloned without the submodules, they can be
initialized and fetched with:

```
git submodule update --init --recursive
```

## Run

**Note:** Use `make clean` if a different device configuration file than the
one from the last build is to be used.

Specify the `CONF` variable or let recipes run with the default device
configuration file. The output of a function ran with the `run` recipe can be
redirected using the `OUT` variable.

To execute a specific function, use the `run` recipe with the `FUNC` variable
defined. Example:

```
$ make FUNC=_face_bin run
```

To execute all intended software configuration, use the `config` recipe and
specify the `CN` (country) variable:

```
$ make CN=bg config
```

## Releases

Source code releases follow the `YYYYMMDD` format.

To list the available releases, check out the available tags or use `git tag`.

## License

[KEYCLA 1.0 License](LICENSE)

For a list of external dependencies and their licenses,
refer to the [DEPENDENCIES](DEPENDENCIES) file.

## Notice

This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

For detailed information on external dependencies,
see the [DEPENDENCIES](DEPENDENCIES) file.
