# AetherCircle

<https://github.com/Zodiac-Innovations/AetherCircle>

AetherCircle provides a shared application model and platform tooling for creating immersive applications for Apple Vision Pro and Meta Quest.

## Documentation

- [Install AetherCircle and Run an AVP Application](Documentation/AVP-Getting-Started.md)
- [Install AetherCircle and Run a Quest Application](Documentation/Quest-Getting-Started.md)

## Platform support

- **Apple Vision Pro** — `AetherCircleCore` provides the platform-independent application model, values, engines, scenes, and objects. `AetherCircleAVP` implements the visionOS platform using SwiftUI and RealityKit.
- **Meta Quest** — `AetherCircleQuest` provides the native C++ OpenXR and Vulkan runtime in this repository. The repository also owns the Android application templates. The AetherCircle CLI downloads these files when it generates a Quest project, substitutes the application metadata, and then uses Gradle to build, install, and launch it on a connected headset.

The CLI contains project-generation logic but does not embed the Quest Gradle, XML, CMake, or C++ source files.
