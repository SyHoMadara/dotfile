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

## Customize Konsole

Press **Ctrl+Shift+M** if the menu is hidden. Open **Settings → Edit Current Profile** to change the active profile, or **Settings → Manage Profiles** to choose Syhomadara and make it the default. Click **Apply** to preview and **OK** to save. Labels and tab locations can vary between Konsole versions.

### Font and size

In the profile's **Appearance** page, use **Select Font** (or **Choose Font**) to select an installed monospaced family and set its size. This profile starts at **13 pt**. A Nerd Font retains the Python icon used by the Zsh prompt.

For a new font, place its `.ttf` or `.otf` files under `~/.local/share/fonts/`, run `fc-cache -f ~/.local/share/fonts`, and reopen Konsole before selecting it.

Changing the main font also changes the terminal cell dimensions. If you replace JetBrains Mono, update the first family test in the Persian fallback file to the exact new family name; otherwise the Vazir Code fallback rule will no longer match.

### Persian font and its size

Edit `~/.config/fontconfig/conf.d/60-jetbrains-persian.conf`:

- The first `<test>` selects the main font, currently `JetBrainsMono Nerd Font`.
- The first `<edit>` selects the Persian fallback, currently `Vazir Code`.
- The second `<test>` must match that fallback family so its size adjustment applies.
- `<double>1.12</double>` enlarges Persian by 12%. Use `1.00` for the original size, `1.08` for 8%, or `1.15` for 15%.

For example, to use another Persian font, install it and replace both occurrences of `Vazir Code` with its family name. Prefer a monospaced Persian font for the terminal grid. Close all Konsole windows and reopen after changing Fontconfig rules; `fc-match` commands above help verify the selection.

### Line spacing and padding

Look for **Line spacing** in the profile's **Appearance** options. The current value is **5 pixels** of additional space per line; increase it for more separation or set it to `0` for normal spacing.

For precise changes, close Konsole and edit `~/.local/share/konsole/Syhomadara.profile`:

```ini
[General]
TerminalMargin=12

[Appearance]
LineSpacing=5
```

Change the existing keys in their existing sections. `TerminalMargin` controls the padding around the terminal content, not the spacing between lines.

### Terminal colors and window colors

In **Edit Current Profile → Appearance**, select **Syhomadara** in the color scheme list and use **Edit** to change the background, foreground, and ANSI colors. The Zsh theme uses blue for the folder, magenta for Git, green for the arrow, yellow for environments, and red for failures; changing those palette entries changes the prompt too.

The terminal palette is stored in `~/.local/share/konsole/Syhomadara.colorscheme`. **Settings → Window Color Scheme**, where available, changes the surrounding interface (toolbar and menus); it is separate from the terminal palette. This setup selects Breeze Dark.

### Cursor, scrollbar, and scrollback

In the profile editor, look for **Cursor** options to choose a block, underline, or vertical bar and enable or disable blinking. Use **Scrolling** to choose scrollbar visibility and the amount of output kept in scrollback. The current scrollbar is hidden.

### Toolbar, menu, tabs, and title bar

- **Ctrl+Shift+M** shows or hides the menu.
- **Settings → Toolbars Shown → Main Toolbar** shows or hides the toolbar.
- **Settings → Configure Toolbars** changes the toolbar buttons and their order.
- **Settings → Configure Konsole** contains application settings for tabs and the window, including title bar options where supported.

Konsole does not offer a native hover-reveal option in the settings used here. If a running session restores the toolbar on exit, hide it from the menu before closing Konsole. Hiding the toolbar and removing the window title bar are separate settings.

### Persian text direction

In the profile editor, open **Appearance → Complex Text Layout** and find **Bi-Directional text rendering** and keep it enabled. The tracked profile sets:

```ini
[Terminal Features]
BidiRenderingEnabled=true
BidiLineLTR=true
```

`BidiLineLTR=true` keeps the overall shell line left-to-right while allowing Persian text to be reordered inside it. Set it to `false` if you want each line's direction determined by its content; test mixed Persian/English commands after making that change.

### Save customizations back to this repository

The installation commands copy files, so GUI changes affect your home directory, not this checkout. Close all Konsole windows so settings are saved, then run from the repository root:

```sh
cp ~/.config/konsolerc konsole/.config/konsolerc
cp ~/.local/share/konsole/Syhomadara.profile konsole/.local/share/konsole/
cp ~/.local/share/konsole/Syhomadara.colorscheme konsole/.local/share/konsole/
cp ~/.config/fontconfig/conf.d/60-jetbrains-persian.conf konsole/.config/fontconfig/conf.d/
git diff -- konsole
```

If you created a new profile or palette, copy its files too and update the default profile and installation instructions accordingly. Review `konsolerc` before committing: Konsole may save machine-specific window state there.

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
