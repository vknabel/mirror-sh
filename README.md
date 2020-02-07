# Mirror

A small script responsible to mirror online resources like repositories or files locally and acts the most basic version of a bash-package-manager.
In most cases Mirror adds offline capabilities to the typical `curl url | bash`-pattern and extends it to repositories.

| Subcommand                                               | Returns             |
| -------------------------------------------------------- | ------------------- |
| `mirror file url`                                        | File contents.      |
| `mirror repo url-or-github-repo [branch tag commit]` | Path to repository. |

## Installation

### Homebrew

```bash
$ brew tap vknabel/mirror-sh https://github.com/vknabel/mirror-sh
$ brew install mirror-sh
```

### Manual

```bash
$ curl https://raw.githubusercontent.com/vknabel/mirror-sh/master/mirror.sh > /usr/local/bin/mirror
$ chmod +x /usr/local/bin/mirror
```

## Configuration

| Env Variable  | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| `MIRROR_PATH` | The base path to store mirrors. Defaults to `$HOME/.mirror`. |

## Examples

```bash
# Run a Swift Package by a given url in a specific version
function mirror-swiftpm() {
    if [ "$#" -ge 3 ]; then
        local PACKAGE="$1"
        local VERSION="$2"
        local TARGET="$3"

        local CLONE_PATH=$(mirror repo "$PACKAGE" "$VERSION")
        swift build --package-path "$CLONE_PATH" -c release > /dev/null
        swift run --skip-build --package-path "$CLONE_PATH" -c release "$TARGET" ${@:4}
    else
        echo "usage: mirror-swiftpm package version target [arguments...]"
    fi
}

# Runs a specific Swift Package in a specific version
function archery@maser() {
    mirror-swiftpm https://github.com/vknabel/Archery master archery $@
}
```

## License

Mirror is available under the [MIT](./LICENSE) license.
