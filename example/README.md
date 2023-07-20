# Flutter example packages

Demonstrating the operation of Flutter plugins on the Aurora OS.

## Getting Started

```shell
# Add an alias if it doesn't already exist
alias flutter-aurora=$HOME/.local/opt/flutter/bin/flutter

# Get dependencies
flutter-aurora pub get

# Generate internationalizing
flutter-aurora pub run build_runner build

# Run build
flutter-aurora build aurora --release # [--release|--debug|--profile]
```
