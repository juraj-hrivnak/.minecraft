# Modpack Development Environment

An easy-to-use template for an automated modpack development environment.

## Features

- **⌨️ Manage mods in CLI interface** using **[PAX]** without the need to use CurseForge launcher. 
- **📦 Export modpack and server pack** easily, using **[PAX]** and **[ServerPackCreator]**.
- **🤝 Multiple people working together**.
  - **📥 Download mods and resource packs** using **[ModpackDownloader]**.
  - **🧰 Easy integration with MultiMC file structure**.
- **📝 Handle changelogs easily**, based on **[Keep a Changelog]**.
- **🧬 CI/CD support**.
  - **📤 Automatically deploy** to CurseForge and GitHub in about 5 minutes.
  - **🗃️ Development builds**.
  - **⚙️ Closes issues** with the 'fixed in dev' label on release.

## How It Works

This template uses various tools to help you with your modpack development and release process.

- **Release** uses: **[PAX]** to export the modpack as zip, **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json` required for server pack creation, which requires CurseForge API key, and **[ServerPackCreator]** to remove client-side mods and create the server pack.
  - Modpack can be released using GitHub actions. (Recommended.) Which requires a CurseForge API token.
  - Or it can be exported locally and then released on CurseForge manually. (Not recommended.)

- **Development** uses: **[PAX]** to manage mods, and **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json`, which requires the CurseForge API key.

![](https://i.imgur.com/kCZhkXX.png)

<!-- Links: -->
[PAX]: https://github.com/froehlichA/pax
[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[ServerPackCreator]: https://github.com/Griefed/ServerPackCreator
[ModpackDownloader]: https://github.com/Joshyx/ModpackDownloader
