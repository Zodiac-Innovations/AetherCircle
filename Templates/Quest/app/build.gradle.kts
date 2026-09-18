plugins { id("com.android.application") }

val buildSwiftQuestApplication by tasks.registering(Exec::class) {
    workingDir(rootProject.projectDir)
    commandLine("bash", "build-swift.sh")
}

android {
    namespace = "{{PACKAGE_NAME}}"
    compileSdk = 36
    ndkVersion = "29.0.14206865"

    defaultConfig {
        applicationId = "{{PACKAGE_NAME}}"
        minSdk = 32
        targetSdk = 36
        versionCode = {{BUILD}}
        versionName = "{{VERSION}}"
        ndk { abiFilters += listOf("arm64-v8a") }
        externalNativeBuild {
            cmake {
                cppFlags += listOf("-std=c++20", "-Wall", "-Wextra")
                arguments += listOf("-DANDROID_STL=c++_shared")
            }
        }
    }

    buildTypes { release { isMinifyEnabled = false } }
    buildFeatures { prefab = true }
    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.31.6"
        }
    }
}

tasks.named("preBuild") {
    dependsOn(buildSwiftQuestApplication)
}

dependencies {
    implementation(
        "org.khronos.openxr:openxr_loader_for_android:1.1.63"
    )
}
