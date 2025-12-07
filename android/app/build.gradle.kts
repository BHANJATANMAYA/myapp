plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.lovexl"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // ✅ Force correct NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.lovexl"
        minSdk = 23 // ✅ Firebase Firestore requires at least 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.2.0"))

    // Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // Example: Firestore (add if you plan to track user counts)
    implementation("com.google.firebase:firebase-firestore")
}
