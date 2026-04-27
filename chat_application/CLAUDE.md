# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter chat application (Dart SDK ^3.9.2). Currently in initial scaffold state — only `lib/main.dart` exists with a "Hello World" placeholder.

## Common Commands

```bash
# Run the app (choose a target device)
flutter run

# Run on a specific platform
flutter run -d chrome       # Web
flutter run -d macos        # macOS desktop
flutter run -d ios          # iOS simulator
flutter run -d android      # Android emulator

# Build
flutter build apk           # Android
flutter build ios           # iOS
flutter build web           # Web
flutter build macos         # macOS

# Lint / analyze
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/some_test.dart

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

## Architecture

The app entry point is [lib/main.dart](lib/main.dart). `MainApp` is the root `StatelessWidget` wrapping a `MaterialApp`.

Linting follows `package:flutter_lints/flutter.yaml` (configured in [analysis_options.yaml](analysis_options.yaml)).

No state management, routing, or backend integration has been set up yet — these are foundational decisions to make as features are built.
