pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://www.jitpack.io") }
        maven { url=uri ("https://jitpack.io")}
        maven { url=uri ("https://storage.googleapis.com/download.flutter.io")}
        maven { url = uri("https://nexus.gravity-engine.com/repository/maven-releases/") }
        maven { url = uri("https://nexus.gravity-engine.com/repository/maven-snapshots/") }
        //解决插件找不到依赖问题
        flatDir {
            dirs(project(":flutter_ffmpeg_kit_full").projectDir.resolve("libs"))
        }
    }
}



plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.6.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
}

include(":app")
