<img src="./doc/theolive_flutter_sdk_logo.png">

# THEOlive Flutter SDK - initial version

## License

This projects falls under the license as defined in https://github.com/THEOplayer/license-and-disclaimer.

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [How to use these guides](#how-to-use-these-guides)
4. [Features](#features)
6. [Getting Started](#getting-started)

## Overview

The `flutter_theolive` package provides a `THEOliveView` component supporting video playback on the
following platforms:

- Android, Android TV & FireTV
- iOS 
- **OUT OF SCOPE**: HTML5 (web, mobile web), Tizen and WebOS (smart TVs, set-top boxes and gaming consoles).

This document covers the creation of a minimal app including a `THEOliveView` component,
and an overview of the accompanying example app.

## Prerequisites
For each platform, a dependency to the corresponding THEOlive SDK is included through a dependency manager:

- Gradle & Maven for Android
- Cocoapods for iOS

If you have no previous experience in Flutter, we encourage you to first explore the
[Flutter Documentation](https://docs.flutter.dev/),
as it gives you a good start on one of the most popular app development frameworks.

## How to use these guides

These are guides on how to use the THEOlive Flutter SDK in your Flutter project(s) and can be used
linearly or by searching the specific section. It is recommended that you have a basic understanding of how
Flutter works to speed up the way of working with THEOlive Flutter SDK.

## Features

Depending on the platform on which the application is deployed, a different set of features can be available.

If a feature missing, additional help is needed, or you need to extend the package,
please reach out to us for support.


## Getting Started

This section starts with creating a minimal demo app that integrates the `flutter_theolive` package.

A minimal example application (used during development) including a basic user interface and a demo source is included in [this git repository](https://github.com/THEOplayer/theolive-flutter-sdk/tree/main/example), and parts of it are discussed in the next section.

- [Creating a minimal demo app](./doc/creating-minimal-app.md)
    - [Getting started on Android](./doc/creating-minimal-app.md#getting-started-on-android)
    - [Getting started on iOS](./doc/creating-minimal-app.md#getting-started-on-ios-and-tvos)

- Knowledge Base
  - TBD
- [Limitations and known issues](./doc/limitations.md)