# Install AetherCircle and Run an AVP Application

This guide installs the AetherCircle command-line tool, creates a project, and runs it in the Apple Vision Pro simulator.

## Requirements

Before beginning, install:

- Homebrew
- Xcode with the visionOS simulator runtime
- Xcode Command Line Tools

## 1. Install AetherCircle

Add the Zodiac Innovations Homebrew tap:

```bash
brew tap zodiac-innovations/tap
```

Install the current AetherCircle CLI:

```bash
brew install --HEAD zodiac-innovations/tap/aethercircle
```

Homebrew installs XcodeGen automatically.

Verify the installation:

```bash
aethercircle --version
aethercircle --help
```

Open the AetherCircle framework repository in the default browser:

```bash
aethercircle repo
```

## 2. Create an AetherCircle Application

Choose the directory where the project should be created:

```bash
cd ~/Desktop
```

Create and enter the project:

```bash
aethercircle init HelloAetherCircle
cd HelloAetherCircle
```

## 3. Generate the Apple Vision Pro Project

Generate the Xcode project:

```bash
aethercircle avp create
```

The default icon is installed automatically from `Shared/Icons`. Replace the appropriate icon files there before regenerating with `aethercircle avp create -d` if you want a custom icon.

Check the generated project and development environment:

```bash
aethercircle doctor
```

## 4. Open and Run the Application

Open the generated project in Xcode:

```bash
aethercircle avp ide
```

In Xcode:

1. Select the `HelloAetherCircle` scheme.
2. Select an Apple Vision Pro simulator.
3. Press **Run**, or press **Command-R**.

The example application enters an immersive space and displays a rotating blue cube.

## Updating AetherCircle

To update the Homebrew-installed command-line tool:

```bash
brew update
brew upgrade --fetch-HEAD zodiac-innovations/tap/aethercircle
```

The generated AVP project uses the repository and branch in `AetherCircle.info`. To update its Swift package, open the project in Xcode and select **File > Packages > Update to Latest Package Versions**.
