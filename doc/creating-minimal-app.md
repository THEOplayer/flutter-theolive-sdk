## Creating a minimal demo app

In this section we start from an empty Flutter project, include a dependency to `flutter_theolive`, and deploy it on an Android or iOS device.

### Table of Contents
- [Setting up a new project](#setting-up-a-new-project)
- [Getting started on Android](#getting-started-on-android)
- [Getting started on iOS](#getting-started-on-ios)

### Setting up a new project

#### Getting a new project ready
After [setting up your Flutter development environment](https://docs.flutter.dev/get-started/install) you can run the following command to create a new project from Terminal. (You can use Android Studio too)

```bash
$ flutter create -a kotlin -i swift -t app --org com.theoplayer --description "New THEOlive project" --project-name "flutter_theolive_sample_app" --platform ios,android flutter_theolive_sample_app
```

This will generate a basic project as a starting point for Android, iOS and Web development.

```bash
Signing iOS app for device deployment using developer identity: "Apple Development: XXXXXXXXXX"
Creating project flutter_theolive_sample_app...
Resolving dependencies in flutter_theolive_sample_app... 
Got dependencies in flutter_theolive_sample_app.
Wrote 81 files.

All done!
You can find general documentation for Flutter at: https://docs.flutter.dev/
Detailed API documentation is available at: https://api.flutter.dev/
If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

In order to run your application, type:

  $ cd flutter_theolive_sample_app
  $ flutter run

Your application code is in flutter_theolive_sample_app/lib/main.dart.
```

Following the guidance from the script you can have your basic app running:

```bash
$ cd flutter_theolive_sample_app
$ flutter run
```

#### Adding THEOlive Flutter SDK
Becuase THEOplayer Flutter SDK is still under development it is not available from public package managers. (e.g. [pub.dev](https://pub.dev)).

To use the SDK, you need to initialize `git` in your project and **add the SDK as a submodule**:

```bash
$ git init
$ git submodule add https://GITHUB_USERNAME:GITHUB_PASSWORD@github.com/THEOplayer/theolive-flutter-sdk.git
```

Your project structure will look like this:

```bash
➜  flutter_theolive_sample_app git:(master) ✗ ls
README.md                       flutter_theolive_sample_app.iml pubspec.yaml
analysis_options.yaml           ios                             test
android                         lib                             theolive-flutter-sdk
build                           pubspec.lock                   

```

After the submodule added, you can add the THEOplayer Flutter SDK as a dependency in your project's `pubspec.yaml` file manually, or just by running this command:

```bash
$ flutte pub add 'flutter_theolive:{"path":"./theolive-flutter-sdk"}' --directory .
```

You should get an output like this after executing the command, meaning `flutter` found and added the SDK as a dependency, and fetched the necessary packages too.

```diff
Resolving dependencies... 
  collection 1.17.2 (1.18.0 available)
  flutter_lints 2.0.3 (3.0.1 available)
+ flutter_theolive 0.0.1 from path theolive-flutter-sdk
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

#### Adding THEOliveView to your view hierarchy

1.) Initialize THEOplayer (e.g. in your StatefulWidget)

```dart
  late THEOliveViewController _theoController;
  late THEOliveView theoLiveView;

  @override
  void initState() {
    super.initState();
    theoLiveView = THEOliveView(key: playerUniqueKey, onTHEOliveViewCreated:(THEOliveViewController controller) {
      // assign the controller to interact with the player
      _theoController = controller;
      // if we would like to listen to events
      //_theoController.eventListener = this;

      // automatically load the channel once the view is ready
      _theoController.loadChannel("YOUR_CHANNEL_ID");

    }
    );

  }
```

2.) Adding THEOliveView to the view hierarchy

```dart
Container(
	width: 300, 
	height: 300, 
	child: theoLiveView
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
    applicationId "com.theoplayer.theoplayer_example"
    // You can update the following values to match your application needs.
    // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
    minSdkVersion 24
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
}
```

THEOlive Android SDK compatible with Kotlin and Kotlin Gradle Plugin 1.8.22+, so if your app is using a lower version, please upgrade. Usually you can find this in the `build.gradle` file in the root android directory, e.g. `android/build.gradle`.

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



By using the `flutter run ios` command, you can try out your applicaiton on an iOS device.

### Demo project

A separate minimal demo project is also available on [https://github.com/THEOplayer/theolive-flutter-sdk-sample-app](https://github.com/THEOplayer/theolive-flutter-sdk-sample-app) that was built by following this guide.