# TLab Feature

Brick untuk membuat feature sesuai dengan Clean Architecture.

## How to use 🚀

### Add Brick
- Remote
```
mason add savrix_feature --git-url https://github.com/ysavr/savrix_brick.git --git-path savrix_feature
```

- Local
```
mason add savrix_feature --path=savrix/savrix_feature
```

### Make
```
mason make savrix_feature
```
atau
```
mason make savrix_feature —feature_name orders
```

### Remove
 ```
mason remove savrix_feature
```

## Outputs 📦

```
├── lib
|   └── data
|   |    - models
|   |    - repositories
|   └── domain
|   |    - entities
|   |    - repositories
|   |    - usecase
|   └── presentation
|   |    - bloc
|   |    - screen
|   |    - widget
└── ...
```
