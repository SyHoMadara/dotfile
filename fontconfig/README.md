# Fontconfig (Persian Typography)

This configuration sets [Vazirmatn](https://github.com/rastikerdar/vazirmatn) as the default Persian fallback font across the desktop, web browsers (Firefox, Chromium, Chrome), and GUI applications for `sans-serif`, `system-ui`, and `serif`. It also configures [Vazir Code](https://github.com/rastikerdar/vazir-code-font) as the default monospaced fallback font for Persian code blocks.

Without this configuration, Linux distributions (such as Arch Linux) fall back to **DejaVu Sans**, which renders Persian text with inconsistent letter shapes, poor baseline alignment, and overly thick bold weights.

## Install prerequisites

Install Fontconfig and curl using your distribution's package manager. For example:

- On Arch Linux:
  ```sh
  sudo pacman -S fontconfig curl unzip
  ```
- On Debian/Ubuntu:
  ```sh
  sudo apt install fontconfig curl unzip
  ```

## Fonts

### Persian UI and text: Vazirmatn

Download and install the Vazirmatn font if it is not already installed:

```sh
curl -fL https://github.com/rastikerdar/vazirmatn/releases/latest/download/vazirmatn.zip -o /tmp/vazirmatn.zip
mkdir -p ~/.local/share/fonts/vazirmatn
unzip -o /tmp/vazirmatn.zip '*.ttf' -d ~/.local/share/fonts/vazirmatn
fc-cache -f ~/.local/share/fonts
```

On Arch Linux, it is also available via the AUR (`ttf-vazirmatn`).

### Persian code and terminal: Vazir Code

[Vazir Code](https://github.com/rastikerdar/vazir-code-font) is used for monospace contexts (such as code tags `<pre>`, `<code>`, and terminal blocks):

```sh
curl -fL https://github.com/rastikerdar/vazir-code-font/releases/download/v1.1.2/vazir-code-font-v1.1.2.zip -o /tmp/vazir-code.zip
mkdir -p ~/.local/share/fonts/vazir-code
unzip -jo /tmp/vazir-code.zip 'Vazir-Code.ttf' -d ~/.local/share/fonts/vazir-code
fc-cache -f ~/.local/share/fonts
```

## Install configuration

From the repository root:

```sh
mkdir -p ~/.config/fontconfig/conf.d
cp fontconfig/.config/fontconfig/conf.d/70-persian.conf ~/.config/fontconfig/conf.d/
fc-cache -f
```

Restart your browser (Firefox, Chromium) or reload existing tabs to apply the font changes.

## Verify

Run the following commands to verify that Fontconfig resolves Persian requests to Vazirmatn and Vazir Code:

```sh
fc-match "sans-serif:lang=fa"
fc-match "sans-serif:weight=bold:lang=fa"
fc-match "system-ui:lang=fa"
fc-match "monospace:lang=fa"
```

Expected output:
- `Vazirmatn[wght].ttf: "Vazirmatn" "Regular"` for regular sans-serif and system-ui.
- `Vazirmatn[wght].ttf: "Vazirmatn" "Bold"` for bold sans-serif.
- `Vazir-Code.ttf: "Vazir Code" "Regular"` for monospace.
