# Flutter Setup Guide (Windows) — From Zero to Running the App

This is a complete beginner's walkthrough: install everything needed, get the Flutter SDK working, set up Android Studio, and run this Flutter project on an emulator.

---

## 1. Install Android Studio

Android Studio gives you the Android SDK, an emulator, and an IDE with Flutter support.

1. Download it from https://developer.android.com/studio
2. Run the installer and complete the setup wizard (this installs the base Android SDK for you).
3. Once installed, open Android Studio and install the **Flutter plugin**:
   - Go to **Plugins**
   - Search for **Flutter** and install it (this pulls in the **Dart** plugin automatically)
   - Restart Android Studio when prompted

---

## 2. Get the Flutter SDK

Open **PowerShell** and pick a permanent, non-restricted folder (do **not** run this inside `C:\Windows\System32` or any admin-protected folder).

```powershell
cd C:\
mkdir dev
cd dev
git clone -b stable https://github.com/flutter/flutter.git
```

This downloads the **stable** channel of Flutter (recommended over `main`, which is bleeding-edge and can be unstable).

### Add Flutter to your PATH

So you can type `flutter` from any folder, not just `flutter/bin`:

1. Press `Win`, search **"Environment Variables"**, open **"Edit the system environment variables"**
2. Click **Environment Variables**
3. Under **User variables**, select `Path` → **Edit** → **New**
4. Add: `C:\dev\flutter\bin`
5. Click OK on everything
6. **Close and reopen PowerShell** (required — it won't pick up the change in an already-open window)

### Verify it worked

```powershell
flutter --version
```

You should see a version number and channel (e.g. `Flutter 3.47.3 • channel stable`).

---

## 3. Run Flutter Doctor

This checks your setup and tells you what's missing:

```powershell
flutter doctor
```

If it flags a missing **Android SDK Command-line Tools** component:

1. Open Android Studio → **More Actions** (or **Tools → SDK Manager** if a project is open)
2. Go to the **SDK Tools** tab
3. Check **"Android SDK Command-line Tools (latest)"**
4. Click **Apply** → **OK** to install it

Run `flutter doctor` again afterward to confirm the Android toolchain shows a checkmark. (Newer versions of the Android SDK tools handle license acceptance automatically — if you see a licenses warning, it usually resolves itself once the SDK Command-line Tools are installed.)

---

## 4. Set Up an Emulator

1. In Android Studio, open **Device Manager** (usually a phone icon in the top-right toolbar, or **Tools → Device Manager**)
2. Click **+** to create a new virtual device
3. Pick a phone (e.g. Pixel) and a recent Android system image (download it if prompted)
4. Once created, click the device's **Play/Run** icon to boot it

Give it a minute or two to fully boot to the home screen the first time — this is normal.

---

## 5. Set Up the Project

1. Extract/place the project folder somewhere convenient, e.g. `C:\Users\<you>\Downloads\<project-folder>`
2. Open PowerShell and navigate into the folder that contains `pubspec.yaml`:

```powershell
cd "C:\path\to\your\project-folder"
```

3. **Generate the platform scaffolding** (Android/iOS/Windows/Web folders). This is required if the project only contains `lib/` and `pubspec.yaml` without the platform folders already set up — it fills in what's missing without touching your existing code:

```powershell
flutter create .
```

4. **Fetch dependencies**:

```powershell
flutter pub get
```

---

## 6. Point Your Editor to the Dart SDK (if needed)

If your editor shows a **"Dart SDK is not configured"** banner:

1. Click **"Open Dart settings"** in the banner (or go to **Settings → Languages & Frameworks → Dart**)
2. Check **"Enable Dart support for the project"**
3. In **Dart SDK path**, enter:

```
C:\dev\flutter\bin\cache\dart-sdk
```

4. Check the project's module checkbox under "Enable Dart support for the following modules"
5. Click **Apply** → **OK**

(If this folder doesn't exist yet, run `flutter pub get` first — it populates the Dart SDK cache.)

---

## 7. Fix Java/Gradle Version Mismatch (common on newer PCs)

Modern PCs often come with **Java 25** already installed (or it gets installed via Android Studio's bundled JBR). Gradle 8.x (used by Flutter's Android build) **cannot parse 3-part Java version strings like `25.0.3`** — it throws a cryptic error where the entire message is just the version number, e.g.:

```
FAILURE: Build failed with an exception.
* What went wrong:
25.0.3
```

If you hit this, you need **Java 17** (LTS) instead — this is the safest, most compatible version for Android/Gradle builds.

### Step 1 — Install JDK 17

1. Go to https://adoptium.net/temurin/releases/?version=17
2. Choose: Operating System = **Windows**, Architecture = **x64**, Package Type = **JDK**
3. Download and run the `.msi` installer (default options are fine)
4. Confirm the install folder:
   ```powershell
   dir "C:\Program Files\Eclipse Adoptium"
   ```
   Note the exact folder name, e.g. `jdk-17.0.20.101-hotspot`

### Step 2 — Point Gradle at JDK 17 for this project

```powershell
cd "path\to\your\project\android"
notepad gradle.properties
```

Add (or edit) this line, using your exact JDK 17 folder name:

```
org.gradle.java.home=C:\\Program Files\\Eclipse Adoptium\\jdk-17.0.20.101-hotspot
```

Save and close.

### Step 3 — Restart Gradle's daemon so it picks up the change

```powershell
.\gradlew.bat --stop
cd ..
```

This step matters — Gradle caches a background daemon process, and it won't notice the new JDK setting until that daemon is stopped and restarted.

---

## 8. Run the App

First, confirm Flutter can see your emulator:

```powershell
flutter devices
```

You should see your emulator listed (e.g. `sdk gphone... (emulator)`).

Then run:

```powershell
flutter run
```

Or, in the editor: pick your emulator from the device dropdown in the toolbar and click the green **Run (▶)** button.

First build takes a few minutes. After that, you get **hot reload** — press `r` in the terminal (or the lightning bolt icon in the editor) to instantly apply code changes without restarting the app.

---

## Quick Troubleshooting

| Problem | Fix |
|---|---|
| `flutter --version` fails to download Dart SDK | Usually a network/antivirus/VPN issue — try disabling VPN/antivirus temporarily, or switch networks (e.g. phone hotspot) |
| `cd` says path doesn't exist | Double-check the exact folder name with `dir` in the parent folder — names are often slightly different than expected |
| `flutter run` says "No supported devices" but `flutter devices` sees your emulator | Run `flutter create .` in the project folder to generate missing platform folders |
| "No Connected Devices Found" popup in editor | The emulator is still booting — wait for it to reach the home screen, then retry |
| `flutter doctor` still complains about Android licenses after installing Command-line Tools | Usually resolves automatically with newer SDK tools; otherwise try `flutter doctor --android-licenses` and type `y` at each prompt |
| App builds/runs on Chrome or Windows instead of your phone/emulator | Explicitly target the device: `flutter run -d <device-id>` (get the ID from `flutter devices`) |
| Emulator not showing in `flutter devices` | It's not running yet — launch it with `flutter emulators --launch <emulator-id>` and wait for full boot |
| Gradle build fails with just a bare version number as the error (e.g. `25.0.3`) | Java version mismatch — Gradle 8.x can't parse Java 25's 3-part version string. Install JDK 17 and point `android/gradle.properties` at it (see Section 7) |
| Fixed `gradle.properties` but the build still fails the same way | A stale Gradle daemon is still using the old JDK — run `.\gradlew.bat --stop` inside the `android` folder, then retry |
| Want to use your phone instead of an emulator | Enable Developer Options + USB debugging on the phone, connect (USB or same-WiFi wireless debugging), then `flutter devices` to confirm it's detected |

---

## Summary Command Cheat Sheet

```powershell
# One-time setup
git clone -b stable https://github.com/flutter/flutter.git
flutter doctor

# Per-project
cd "path\to\project"
flutter create .
flutter pub get

# If you hit a Java version error (bare version number like "25.0.3"):
cd android
notepad gradle.properties
# add: org.gradle.java.home=C:\\Program Files\\Eclipse Adoptium\\jdk-17.x.x-hotspot
.\gradlew.bat --stop
cd ..

# Check devices, then run targeting the right one
flutter devices
flutter run -d <device-id>
```