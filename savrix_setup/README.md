# Savrix Setup

Brick untuk membuat management folder sesuai dengan Clean Architecture.

## How to use 🚀

### Add Brick
- Remote
```
mason add savrix_setup --git-url https://github.com/ysavr/savrix_brick.git --git-path savrix_setup
```

- Local
```
mason add savrix_setup --path=savrix/savrix_setup
```

### Make
```
mason make savrix_setup
```

### Remove
 ```
mason remove savrix_setup
```

## Outputs 📦

```
├── assets
├── environment
|   └── develop.env
|   └── production.env
|   └── stag.env
├── fonts
├── lib
|   └── core
|   └── utils
|   └── main_develop.dart
|   └── main_production.dart
└── ...
```

## How to build 📦

* Develop
```
flutter build apk --debug --flavor develop -t lib/main_develop.dart
```

* Stag
```
flutter build apk --debug --flavor stag -t lib/main_stag.dart
```

* Production
```
flutter build apk --release --flavor production -t lib/main_production.dart
```

* App Bundle
```
flutter build appbundle --release --flavor production -t lib/main_production.dart
```

* Split per Abi
```
flutter build apk --split-per-abi --release --flavor develop -t lib/main_develop.dart
```
