# Konsole

This profile uses a warm charcoal background, JetBrains Mono Nerd Font at size 13, 12 pixels of padding, and 5 pixels of extra line spacing. Persian uses Vazir Code, enlarged by 12% through Fontconfig. Bidirectional rendering is enabled; the terminal line remains left-to-right for shell use. The toolbar and scrollbar are configured to be hidden.

## Install prerequisites

Install Konsole, Fontconfig, curl, and unzip using your distribution's package manager. For example, on Debian/Ubuntu:

```sh
sudo apt install konsole fontconfig curl unzip
```

The profile runs `/usr/bin/zsh`. Install Zsh and optionally the prompt using the [Zsh guide](../zsh/README.md). If Zsh is elsewhere on your system, update `Command` in `.local/share/konsole/Syhomadara.profile`.

## Fonts

Fonts are downloaded from their upstream projects, rather than stored in this repository.

### English and icons: JetBrains Mono Nerd Font

Download the JetBrains Mono archive from [Nerd Fonts](https://www.nerdfonts.com/font-downloads), or use:

```sh
curl -fL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/jetbrains-mono
unzip -o /tmp/JetBrainsMono.zip '*.ttf' -d ~/.local/share/fonts/jetbrains-mono
```

The profile expects the family name `JetBrainsMono Nerd Font`.

### Persian: Vazir Code

[Vazir Code](https://github.com/rastikerdar/vazir-code-font) is a Persian monospaced coding font. The project is discontinued; this setup uses its v1.1.2 release. Regular Vazirmatn is a different font and is not used here.

```sh
curl -fL https://github.com/rastikerdar/vazir-code-font/releases/download/v1.1.2/vazir-code-font-v1.1.2.zip -o /tmp/vazir-code.zip
mkdir -p ~/.local/share/fonts/vazir-code
unzip -jo /tmp/vazir-code.zip 'Vazir-Code.ttf' -d ~/.local/share/fonts/vazir-code
fc-cache -f ~/.local/share/fonts
```

Font licenses and other variants are available in the upstream archives. Only the regular Vazir Code font is needed for this setup.

## Install configuration

Close all Konsole windows first so the running application does not overwrite the copied settings. Run these commands from another terminal, from the repository root:

```sh
mkdir -p ~/.config/fontconfig/conf.d ~/.local/share/konsole
if [ -f ~/.config/konsolerc ]; then
    cp -a ~/.config/konsolerc ~/.config/konsolerc.before-dotfiles
fi
cp konsole/.config/konsolerc ~/.config/konsolerc
cp konsole/.local/share/konsole/Syhomadara.profile ~/.local/share/konsole/
cp konsole/.local/share/konsole/Syhomadara.colorscheme ~/.local/share/konsole/
cp konsole/.config/fontconfig/conf.d/60-jetbrains-persian.conf ~/.config/fontconfig/conf.d/
```

Back up existing `Syhomadara` profile, palette, or fallback files before replacing them if you have customized them. Then reopen Konsole. The configuration selects Syhomadara as the default profile and Breeze Dark for the interface. If Breeze Dark is unavailable, select an installed dark interface scheme through Konsole's settings.

The Fontconfig rule applies to applications requesting `JetBrainsMono Nerd Font`, not only Konsole. It keeps that font for English and inserts Vazir Code as the fallback. Remove older JetBrains Persian fallback rules if you have installed conflicting ones.

## Verify and adjust

```sh
fc-match 'JetBrainsMono Nerd Font'
fc-match 'JetBrainsMono Nerd Font:charset=06cc'
fc-match --format '%{family}: %{pixelsize}px\n' 'JetBrainsMono Nerd Font:pixelsize=18:charset=06cc'
```

Expect JetBrains Mono for the first command, Vazir Code for the second, and approximately `20.16px` for the third (18 × 1.12).

To adjust Persian size, edit the `1.12` multiplier in `~/.config/fontconfig/conf.d/60-jetbrains-persian.conf`, then close all Konsole windows and reopen. Change the general font size or line spacing in **Settings → Edit Current Profile → Appearance**.

Use **Ctrl+Shift+M** to show the menu. **Settings → Toolbars Shown → Main Toolbar** restores the toolbar. Konsole does not offer a native hover-reveal option in the settings used here. If a running session restores the toolbar on exit, hide it from this menu before closing Konsole.

## Persian sample

Paste into the shell:

```sh
printf '%s\n' \
'سلام! چطوری؟ امروز می‌خواهم ظاهر فونت فارسی را بررسی کنم.' \
'پ چ ژ گ ک ی — فارسی خوانا، حروف متصل و فاصله‌های مناسب' \
'اعداد فارسی: ۱۲۳۴۵۶۷۸۹۰ | English: 0123456789' \
'پروژه demo روی شاخه main است؛ نسخه Python 3.12' \
'مسیر فایل: /home/hosein/پروژه/test.py'
```

Shell syntax highlighting can apply different colors to words while typing. Bidirectional rendering may also behave differently in terminal applications that position individual characters.

See the [Konsole handbook](https://docs.kde.org/stable_kf6/en/konsole/konsole/index.html) and [Fontconfig documentation](https://fontconfig.pages.freedesktop.org/fontconfig/fontconfig-user.html) for the underlying settings.
