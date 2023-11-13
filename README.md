# .minecraft

[![Build](https://github.com/juraj-hrivnak/.minecraft/actions/workflows/Build.yml/badge.svg)](https://github.com/juraj-hrivnak/.minecraft/actions/workflows/Build.yml)

An easy-to-use template for an automated modpack development environment.

## Features

- **⌨️ Manage mods in command-line interface** using **[PAX]** without the need to use CurseForge launcher.
- **📦 Export modpack and server pack** easily, using **[PAX]** and **[ServerPackCreator]**.
- **🤝** Designed for multiple people working together...
  - **📥** Mod `.jar`s, resource packs, shader packs and overrides are handled properly! **[ModpackDownloader]**.
  - **🧰 Easy integration with [MultiMC] file structure**.
- **📝 Handle changelogs easily**, based on **[Keep a Changelog]**.
- **🧬 CI/CD** using **[GitHub Actions]**.
  - **📤 Automatically deploy** to CurseForge and GitHub in about 5 minutes.
  - **📃 Automatically generate mod changelog**.
  - **🗃️ Share development builds**.
  - **⚙️ Close issues** with the 'fixed in dev' label on release.

## How It Works

This template uses various tools to help you with your modpack development and release process.

- **Release** uses: **[PAX]** to export the modpack as zip, **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json`, and **[ServerPackCreator]** to remove client-side mods and create the server pack.
  - Modpack can be released using GitHub actions, which requires a CurseForge API token. (Recommended)
  - Or it can be exported locally and then released on CurseForge manually. (Not recommended)

- **Development** uses: **[PAX]** to manage mods, and **[ModpackDownloader]** to download mod `.jar`'s and other files from `manifest.json`.

![Development_02](https://github.com/juraj-hrivnak/.minecraft/assets/71150936/71a4622a-54dd-44af-9e37-e76aad3b2e2b)

## Setup

1. Click on the ["Use this template"] button.
2. Clone the repository to your modpack folder.
3. Run the set-up script:
    - If you are on _Windows 10 or higher_, run the `./pax/setup-windows.ps1` with _PowerShell_.
    - If you are on _Linux_, open your _terminal_ and use the `cd` command to move into the `./pax` folder, then run `sh setup-linux.sh`.
    - If you are on _macOS_, open your _terminal_ and use the `cd` command to move into the `./pax` folder, then run `brew install grep` and after it is finished, run `sh setup-macos.sh`.
4. Configure overrides in the `./pax/sync_overrides.sh`. By default only `config`, `local`, `oresources`, `patchouli_books`, `resources`, `scripts` and `structures` are synced with your modpack folder.
5. Set up automatic releases using a CurseForge API token. (Can be done later or skipped if you don't wish to have releases automated.)
    1. Navigate to [curseforge.com/account/api-tokens](https://curseforge.com/account/api-tokens).
    2. Enter a name for your token and hit the "Generate Token" button.
      ![new_token](https://github.com/juraj-hrivnak/.minecraft/assets/71150936/1718613a-8994-4102-a2a2-aff7939d36ad)
      
    3. Copy your generated secret (the jumbled mess of numbers, letters and dashes).
      ![new_token_copy](https://github.com/juraj-hrivnak/.minecraft/assets/71150936/5c8cd169-5249-40b0-bd23-f42926c88789)
      
    4. [Create a new Secret for GitHub Actions] with the name `CF_API_TOKEN`, and for the value, paste your previously copied secret.
    5. Open an editor with the release workflow config file (located at [.github/workflows/Release.yml](.github/workflows/Release.yml#L28C1-L29) in your project folder).
    6. Locate the `PROJECT_ID` env variable and change the value to your modpack project ID.
      ```yml
      env:
        PROJECT_ID: "443254" # If your Curseforge page shows 443254 as the Project ID.
      ```
6. Enjoy!

## Development

After you have set up your modpack, use the [ModpackDownloader] to download the mod `.jar`s and other files.

- Open your _terminal/cmd_ and use the `cd` command to move into the `./pax` folder, then run the [ModpackDownloader]:
    ```
    java -jar ModpackDownloader-<version>.jar modpack ..
    ```
    > **Note**
    > Make sure to replace the `<version>` with the correct version of ModpackDownloader.

<!-- Links: -->
[PAX]: https://github.com/froehlichA/pax
[ServerPackCreator]: https://github.com/Griefed/ServerPackCreator
[ModpackDownloader]: https://github.com/Joshyx/ModpackDownloader
[MultiMC]: https://multimc.org/
[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[GitHub Actions]: .github/workflows
["Use this template"]: https://github.com/juraj-hrivnak/.minecraft/generate
[Create a new Secret for GitHub Actions]: https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository
