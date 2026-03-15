## Table of Contents

1. [Introduction](#introduction)
2. [Run](#run)
3. [Releases](#releases)
4. [License](#license)
5. [Notice](#notice)

## Introduction

The system configuration/dotfiles of `mscalindt`. Managed with `syscfg`.

[syscfg at GitHub](https://github.com/mscalindt/syscfg)\
[syscfg at GitLab](https://gitlab.com/mscalindt/syscfg)\
[syscfg at Codeberg](https://codeberg.org/mscalindt/syscfg)

## Run

Clone the repository using the `--recursive` option to ensure all submodules
are downloaded.

```
git clone --recursive https://github.com/mscalindt/conf
```

If the repository has been cloned without the submodules, they can be
initialized and fetched with:

```
git submodule update --init --recursive
```

To execute a function, run `make` as root (currently required by syscfg) with
the `FUNC` variable defined. Example:

```
$ doas make FUNC=_gov_performance
```

or manually, by running `syscfg` and giving it the path to a function:

```
$ doas lib/syscfg/src/syscfg "$PWD"/src/_gov_performance
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
