# .minecraft

[![Build](https://github.com/juraj-hrivnak/.minecraft/actions/workflows/Build.yml/badge.svg)](https://github.com/juraj-hrivnak/.minecraft/actions/workflows/Build.yml)

An easy-to-use template for an automated modpack development environment.

## Features

- **⌨️ Manage mods in CLI interface** using **[PAX]** without the need to use CurseForge launcher.
- **📦 Export modpack and server pack** easily, using **[PAX]** and **[ServerPackCreator]**.
- **🤝 Multiple people working together**.
  - **📥 Download mods and resource packs** using **[ModpackDownloader]**.
  - **🧰 Easy integration with [MultiMC] file structure**.
- **📝 Handle changelogs easily**, based on **[Keep a Changelog]**.
- **🧬 CI/CD** using **[GitHub Actions]**.
  - **📤 Automatically deploy** to CurseForge and GitHub in about 5 minutes.
  - **📃 Automatically generate mod changelog**.
  - **🗃️ Share development builds**.
  - **⚙️ Close issues** with the 'fixed in dev' label on release.

## How It Works

This template uses various tools to help you with your modpack development and release process.

- **Release** uses: **[PAX]** to export the modpack as zip, **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json`, which requires CurseForge API key, and **[ServerPackCreator]** to remove client-side mods and create the server pack.
  - Modpack can be released using GitHub actions. (Recommended) Which requires a CurseForge API token.
  - Or it can be exported locally and then released on CurseForge manually. (Not recommended)

- **Development** uses: **[PAX]** to manage mods, and **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json`, which requires the CurseForge API key.

![Diagram](https://i.imgur.com/kCZhkXX.png)

## Setup

> **Note** \
> This setup process is still work-in-progress and will be improved in the future.

1. Click on the ["Use this template"] button.
2. Clone the repository to your modpack folder.
3. Run the set-up script:
    - If you are on _Windows 10 or higher_, run the `./setup-windows.ps1` with _PowerShell_.
    - If you are on _Linux_, open your _terminal_ and use the `./cd` command to move into the `./pax` folder, then run `./sh setup-linux.sh`.
    - If you are on _macOS_, open your _terminal_ and use the `./cd` command to move into the `./pax` folder, then run `./brew install grep` and after it is finished, run `./sh setup-macos.sh`.
4. Set up automatic releases using a CurseForge API token. [↗ Tutorial...](https://github.com/froehlichA/pax/wiki/Automatic-releases#configuring-curseforge-releases)
5. Enjoy!

<!-- Links: -->
[PAX]: https://github.com/froehlichA/pax
[ServerPackCreator]: https://github.com/Griefed/ServerPackCreator
[ModpackDownloader]: https://github.com/Joshyx/ModpackDownloader
[MultiMC]: https://multimc.org/
[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[GitHub Actions]: .github/workflows
["Use this template"]: https://github.com/juraj-hrivnak/.minecraft/generate
[Create a new Secret for GitHub Actions]: https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository
