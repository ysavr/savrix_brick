# Savrix Core

Brick untuk generate project template

## How to use 🚀
### Add Brick 
- Globally
```
mason add -g savrix_core --git-url https://github.com/ysavr/savrix_brick.git --git-path savrix_core
```

### Make
```
mason make savrix_core
```

### Remove
```
mason remove -g savrix_core
```

## Variables 
 Variable | Description                     | Type                                        | 
| - | - | - |
| project_name | The project name | String |
| application_name | The application name | String |
| org_name | The organization name | String |
| application_id | The application id on Android, Bundle ID on iOS and company name on Windows. If omitted value will be formed by org_name + . + project_name. | String |
| description | A short project description | String |