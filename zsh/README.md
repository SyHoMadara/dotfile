# Zsh

The Syhomadara theme shows the current folder, Git branch, and a command arrow on one line. The right prompt shows active Python, Ruby, or Conda environments and failed-command exit codes. Colors follow your terminal palette; use the [Konsole profile](../konsole/README.md) for the matching appearance.

## Install prerequisites

Install Zsh, Git, and curl using your distribution's package manager. For example, on Debian/Ubuntu:

```sh
sudo apt install zsh git curl
```

Install [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation) if it is not already installed:

```sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/install-oh-my-zsh.sh
sh /tmp/install-oh-my-zsh.sh
```

The full `.zshrc` uses two additional plugins. Install them if their directories do not already exist:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
```

See the upstream instructions for [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) and [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md).

Install JetBrains Mono Nerd Font using the [font instructions](../konsole/README.md#fonts).

## Install the theme

From the repository root:

```sh
mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
cp zsh/.oh-my-zsh/themes/syhomadara.zsh-theme "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/"
```

Set these in `~/.zshrc` before sourcing Oh My Zsh:

```zsh
ZSH_THEME="syhomadara"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Open a new terminal or run `exec zsh`.

## Optional full configuration

The tracked `.zshrc` contains personal aliases, `/home/hosein` paths, a Python environment activation alias, GNOME proxy detection, and optional opam setup. Review and adapt those before installing it. Tools referenced by aliases include uv, proxychains4, Docker, Neovim, and Python formatting tools; they are not required by the theme itself.

After reviewing it, install from the repository root:

```sh
cp -a ~/.zshrc ~/.zshrc.before-dotfiles
cp zsh/.zshrc ~/.zshrc
exec zsh
```

## Usage

- Change folders with `cd`; the prompt shows the full final folder name.
- Inside a Git repository, the branch appears in parentheses; `*` indicates changes.
- Activate a Python environment with `source /path/to/venv/bin/activate`.
- Run `false` to preview the red arrow and `exit 1` status.

Zsh syntax highlighting can color different words differently. Persian ordering and connected letters are handled by the terminal; see the Konsole guide.
