# Flutter Clean Architecture Feature Generator

A powerful bash script that generates complete Flutter features following clean architecture principles with intelligent Beamer routing integration.

## Features

- 🏗️ **Complete Clean Architecture**: Generates Domain, Data, and Presentation layers
- 🔄 **CRUD Operations**: Automatic Create, Read, Update, Delete use cases
- 🗺️ **Smart Beamer Integration**: Intelligent routing setup with error handling
- 🛡️ **Intelligent Guardrails**: Handles existing files and consecutive generations
- 🎨 **Professional Error Page**: Responsive error handling with Material Design 3
- 📦 **Dependency Injection**: Injectable/GetIt ready components
- 🧪 **Build Runner Integration**: Automatic model code generation

## Quick Setup

### 1. Clone or Download
```bash
git clone <repository-url>
cd flutter_clean_arch_generator
```

### 2. Make Script Executable
```bash
chmod +x generate_feature.sh
```

### 3. Create Shell Alias

#### For Bash Users
Add to your `~/.bashrc` or `~/.bash_profile`:
```bash
# Flutter Clean Architecture Generator
alias cf='~/Documents/flutter_clean_arch_generator/generate_feature.sh'
```

#### For Zsh Users (macOS default)
Add to your `~/.zshrc`:
```bash
# Flutter Clean Architecture Generator
alias cf='~/Documents/flutter_clean_arch_generator/generate_feature.sh'
```

#### For Fish Users
Add to your `~/.config/fish/config.fish`:
```fish
# Flutter Clean Architecture Generator
alias cf='~/Documents/flutter_clean_arch_generator/generate_feature.sh'
```

### 4. Reload Your Shell
```bash
# For bash/zsh
source ~/.bashrc  # or ~/.zshrc

# Or simply restart your terminal
```

### 5. Verify Setup
```bash
cf --help  # Should show usage information
```

## Usage

### Basic Syntax
```bash
cf [project_path] <feature_name> <entity_name> [package_name]
```

### Examples

#### In Current Directory (Most Common)
```bash
# Navigate to your Flutter project root
cd /path/to/your/flutter/project

# Generate features - automatically reads package name from pubspec.yaml
cf user User                    # Uses package name from pubspec.yaml
cf account Account              # Uses package name from pubspec.yaml
cf product Product              # Simple entity
cf dashboard Dashboard          # Dashboard feature
cf settings Settings            # Settings feature
```

#### With Custom Package Name (Override)
```bash
cf user User com.custom.package    # Override package name from pubspec.yaml
```

#### With Specific Project Path
```bash
cf /path/to/flutter/project user User              # Uses pubspec.yaml from project path
cf ~/projects/my_app order Order com.company.app   # Override with custom package
```

### Generated Structure

For `cf user User` (assuming package name "my_app" in pubspec.yaml):

```
lib/
├── features/
│   └── user/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── user_remote_datasource.dart
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories/
│       │       └── user_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user.dart
│       │   ├── repositories/
│       │   │   └── user_repository.dart
│       │   └── usecases/
│       │       ├── create_user_usecase.dart
│       │       ├── delete_user_usecase.dart
│       │       ├── get_user_usecase.dart
│       │       └── update_user_usecase.dart
│       └── presentation/
│           ├── bloc/
│           │   └── user/
│           │       ├── user_bloc.dart
│           │       ├── user_event.dart
│           │       └── user_state.dart
│           ├── pages/
│           │   └── user_page.dart
│           └── widgets/
└── core/
    ├── services/
    │   ├── location_provider.dart      # Beamer imports & part declaration
    │   ├── location_provider.main.dart # Beamer location classes
    │   └── router_delegate.dart        # Router configuration
    └── common/
        └── views/
            └── error_page.dart         # Professional error page
```

## Intelligent Features

### 🧠 Smart File Handling
- **First Run**: Creates all files from templates
- **Consecutive Runs**: Intelligently updates existing files without conflicts
- **Import Management**: Adds new imports after existing ones
- **Location Registration**: Appends new Beamer locations automatically

### 🎯 Automatic Integration
- **Beamer Routing**: Auto-registers routes in router delegate
- **Error Handling**: Professional 404/error page with responsive design
- **Code Generation**: Runs build_runner automatically for models
- **Clean Architecture**: Enforces proper separation of concerns

### 🛡️ Guardrails & Safety
- **Duplicate Prevention**: Checks for existing locations before adding
- **File Structure**: Maintains proper import order and formatting
- **Error Recovery**: Graceful handling of edge cases
- **Validation**: Ensures proper file placement and naming

## Dependencies

Your Flutter project should include these dependencies:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  beamer: ^1.7.0
  dartz: ^0.10.1
  equatable: ^2.0.5
  injectable: ^2.3.2

dev_dependencies:
  build_runner: ^2.4.7
  injectable_generator: ^2.4.1
  json_serializable: ^6.7.1
  json_annotation: ^4.9.0  # Use 4.9.0+ to avoid warnings
```

## Next Steps After Generation

1. **Dependency Injection**: Add generated components to your DI container
2. **Main.dart Setup**: Ensure you're using the `routerDelegate` from `router_delegate.dart`
3. **Implementation**: Fill in the TODO comments in generated bloc and use case files
4. **Testing**: Add tests for your new feature components
5. **API Integration**: Implement the remote data source methods

### Example main.dart Integration
```dart
import 'package:flutter/material.dart';
import 'package:your_app/core/services/router_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,  // Use generated router delegate
      routeInformationParser: BeamerParser(),
    );
  }
}
```

## Troubleshooting

### Build Runner Issues
If build_runner fails, run manually:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Version Constraint Warnings
Update your pubspec.yaml:
```yaml
json_annotation: ^4.9.0  # Not ^4.8.1
```

### Permission Denied
Make the script executable:
```bash
chmod +x generate_feature.sh
```

### Alias Not Found
Reload your shell configuration:
```bash
source ~/.zshrc  # or ~/.bashrc
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Test your changes with multiple feature generations
4. Submit a pull request

## License

MIT License - feel free to use in your projects!

---

**Generated with ❤️ for Flutter Clean Architecture**