## Creating a minimal demo app

In this section we start from an empty Flutter project, include a dependency to `theolive`, and deploy it on an Android or iOS device.

### Table of Contents
- [Setting up a new project](#setting-up-a-new-project)
- [Getting started on Android](#getting-started-on-android)
- [Getting started on iOS](#getting-started-on-ios)

### Setting up a new project

#### Getting a new project ready
After [setting up your Flutter development environment](https://docs.flutter.dev/get-started/install)
you can run the following command to create a new project from Terminal. (You can use Android Studio too)

```bash
$ flutter create -a kotlin -i swift -t app --org com.theoplayer --description "New THEOlive project" --project-name "theolive_sample_app" --platform ios,android theolive_sample_app
```

This will generate a basic project as a starting point for Android, iOS and Web development.

```bash
Signing iOS app for device deployment using developer identity: "Apple Development: XXXXXXXXXX"
Creating project theolive_sample_app...
Resolving dependencies in theolive_sample_app... 
Got dependencies in theolive_sample_app.
Wrote 81 files.

All done!
You can find general documentation for Flutter at: https://docs.flutter.dev/
Detailed API documentation is available at: https://api.flutter.dev/
If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

In order to run your application, type:

  $ cd theolive_sample_app
  $ flutter run

Your application code is in theolive_sample_app/lib/main.dart.
```

Following the guidance from the script you can have your basic app running:

```bash
$ cd theolive_sample_app
$ flutter run
```

#### Adding THEOlive Flutter SDK
##### Option 1: Adding THEOlive Flutter SDK as dependency (Recommended)
To add THEOlive Flutter SDK as a dependency, you can simply fetch it from [pub.dev](https://pub.dev) using:

```bash
$ flutter pub add theolive
```

##### Option 2: Adding THEOlive Flutter SDK as submodule
As an alternative, you can add the SDK as a submodule in your git project.
This can be useful if you are trying to fork the project to [contribute](https://github.com/THEOplayer/flutter-theolive-sdk/blob/main/CONTRIBUTING.md) with us.

```bash
$ git submodule add https://GITHUB_USERNAME:GITHUB_PASSWORD@github.com/THEOplayer/flutter-theolive-sdk.git
```

Your project structure will look like this:

```bash
➜  theolive_sample_app git:(master) ✗ ls
README.md                       theolive_sample_app.iml         pubspec.yaml
analysis_options.yaml           ios                             test
android                         lib                             flutter-theolive-sdk
build                           pubspec.lock                   

```

After the submodule added, you can add the THEOplayer Flutter SDK as a dependency in your project's `pubspec.yaml` file manually, or just by running this command:

```bash
$ flutte pub add 'flutter_theolive:{"path":"./flutter-theolive-sdk"}' --directory .
```

You should get an output like this after executing the command, meaning `flutter` found and added the SDK as a dependency, and fetched the necessary packages too.

```diff
Resolving dependencies... 
  collection 1.17.2 (1.18.0 available)
  flutter_lints 2.0.3 (3.0.1 available)
+ theolive 1.0.0 from path flutter-theolive-sdk
  lints 2.1.1 (3.0.0 available)
  material_color_utilities 0.5.0 (0.8.0 available)
  meta 1.9.1 (1.11.0 available)
  path 1.8.3 (1.9.0 available)
+ plugin_platform_interface 2.1.7
  stack_trace 1.11.0 (1.11.1 available)
  stream_channel 2.1.1 (2.1.2 available)
  test_api 0.6.0 (0.6.1 available)
  web 0.1.4-beta (0.4.0 available)
Changed 2 dependencies!

```

To make sure the submodule references the platform-specific SDKs from within the repository run `melos bootstrap`.

If your main project doesn't pick up the changes, it is possible you need to configure `melos` to include your project too.

You can do it in 2 ways.

1. Create your `melos.yaml` file in your root project and configure it according to your setup (including the `theolive` submodule and its packages).
2. Or, modifiy the `flutter-theolive-sdk/melos.yaml` to include your project by adding `../` into the `packages` section of the melos file.

Don't forget to run `melos bootstrap` again in the directory according to your choice from above.

#### Adding THEOliveView to your view hierarchy

1.) Initialize THEOlive (e.g. in your StatefulWidget)

```dart
  late THEOlive _theoLive;

  @override
  void initState() {
    super.initState();
  
    _theoLive = THEOlive(
      playerConfig: PlayerConfig(
        AndroidConfig(),
      ),
      onCreate: () {
        // if you would like to listen to state changes
        _theoLive.setStateListener(() => setState(() {}));

        // automatically load the channel once the view is ready
        _theoLive.loadChannel("2vqqekesftg9zuvxu9tdme6kl");
      });
  }
```

2.) Adding THEOliveView to the view hierarchy

```dart
Container(
	width: 300, 
	height: 300, 
	child: _theoLive.getView()
),
```

3.) Setting a source and start playback on a button press:

```dart
FilledButton(
    onPressed: () {
    	_theoController.loadChannel("YOUR_CHANNEL_ID");
		_theoController.play();
    },
    child: const Text("Load and Play"),
),
```

---
You are (almost) ready to play with THEOlive 😉


Is there anything else to configure on the specific platforms?

Check it below ⬇️

### Getting started on Android

The generated sample project doesn't have Internet permission by default (only in debug/profile mode).

By declaring the `INTERNET` the `AndroidManifest.xml`, your app can reach the Internet.

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

As noted in the [limitations](./limitations.md), THEOlive on Android supports Android 7 (API level 24) and above, so defining this in the `android/app/build.gradle` is necessary:

```java
defaultConfig {
    // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
    applicationId "com.theolive.theolive_example"
    // You can update the following values to match your application needs.
    // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
    minSdkVersion 24
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

THEOlive Android SDK compatible with Kotlin and Kotlin Gradle Plugin 1.8.22+, so if your app is using a lower version, please upgrade. 
Usually you can find this in the `build.gradle` file in the root android directory, e.g. `android/build.gradle`.

```java
buildscript {
    ext.kotlin_version = '1.8.22'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```


By using the `flutter run android` command, you can try out your application on an Android device.

### Getting started on iOS

By default there is no minimum iOS version specified in the Podfile of the project.

As noted in the [limitations](./limitations.md), THEOlive on iOS supports iOS 12 and above, so defining this in the `ios/Podfile` is recommended:

```bash
platform :ios, '12.0'
```


By using the `flutter run ios` command, you can try out your application on an iOS device.

### Demo project

A separate minimal demo project is also available on [https://github.com/THEOplayer/flutter-theolive-sdk-sample-app](https://github.com/THEOplayer/flutter-theolive-sdk-sample-app) that was built by following this guide.