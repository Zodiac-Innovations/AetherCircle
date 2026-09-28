# Install AetherCircle and Run a Quest Application

This guide installs the AetherCircle command-line tool, creates a project, and runs it on a Meta Quest headset.

## Requirements

Before beginning, install and configure:

- Homebrew
- Android Studio
- Android SDK platform 36
- Android SDK Command-Line Tools
- Android NDK 29.0.14206865
- CMake 3.31.6
- Ninja
- Gradle
- Swift SDK for Android
- Meta Quest Developer Mode and USB debugging

The Quest must be connected to the development computer and authorized for USB debugging before the application can be installed.

## 1. Install AetherCircle

Add the Zodiac Innovations Homebrew tap:

```bash
brew tap zodiac-innovations/tap
```

Install the current AetherCircle CLI:

```bash
brew install --HEAD zodiac-innovations/tap/aethercircle
```

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

## 3. Generate the Meta Quest Project

Generate the Android Studio and OpenXR project:

```bash
aethercircle quest create
```

The default icon is installed automatically from `Shared/Icons`. Replace the appropriate icon files there before regenerating with `aethercircle quest create -d` if you want a custom icon.

Check the project and development environment:

```bash
aethercircle doctor
```

## 4. Open and Run the Application

Open the generated Quest project in Android Studio:

```bash
aethercircle quest ide
```

Or open it in Visual Studio Code:

```bash
aethercircle quest vscode
```

The Quest application is intended to compile and run the shared AetherCircle
Swift application code through the Swift SDK for Android. Kotlin, JNI, C++, and
OpenXR code provide platform integration; they do not replace the shared Swift
application layer.

Connect the Quest by USB, put on the headset, and approve the USB debugging request. Confirm that ADB recognizes it:

```bash
adb devices
```

The headset must appear with the status `device`, not `unauthorized`.

List the connected devices and their authorization state:

```bash
aethercircle quest devices
```

Compile the shared Swift application and native Quest package without installing:

```bash
aethercircle quest compile
```

Build and install without launching:

```bash
aethercircle quest install [device-id]
```

Build, install, and launch:

```bash
aethercircle quest run [device-id]
```

The device ID may be omitted when exactly one authorized device is connected.

View the application log:

```bash
adb logcat -s AetherCircleQuest
```

## Updating AetherCircle

To update the Homebrew-installed command-line tool:

```bash
brew update
brew upgrade --fetch-HEAD zodiac-innovations/tap/aethercircle
```

The Quest runtime and templates are downloaded from the repository and branch in `AetherCircle.info` by `aethercircle quest create`. To regenerate an existing Quest project from the latest repository version, first preserve any project-specific changes and then run:

```bash
aethercircle quest create -d
```

The `-d` option deletes and recreates the existing `Quest` directory.
