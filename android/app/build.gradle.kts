// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.4.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.10")
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle.kts files
    }
}

plugins {
    // Apply Gradle Kotlin DSL plugin for version management (without applying to submodules by default)
    kotlin("android") version "1.8.10" apply false
    id("com.android.application") version "7.4.2" apply false
    id("com.android.library") version "7.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Force all Android modules to use the same NDK version
import com.android.build.gradle.AppExtension
import com.android.build.gradle.LibraryExtension
import org.gradle.kotlin.dsl.configure

subprojects {
    // Configure application modules
    plugins.withId("com.android.application") {
        extensions.configure<AppExtension> {
            ndkVersion = "27.0.12077973"
        }
    }
    // Configure library modules
    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension> {
            ndkVersion = "27.0.12077973"
        }
    }
}