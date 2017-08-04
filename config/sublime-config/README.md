
Usage

```shell
$SUBLIME_DIR="~/.config/sublime-text-3"
mkdir -p "$SUBLIME_DIR/Packages"
cd "$SUBLIME_DIR/Packages"
rm User -rf
cp -r ./ User
```
Sync to github

```shell
cp -r ~/.config/sublime-text-3/Packages/User/* ./
```