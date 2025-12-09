# Flutter MVVM Template 🚀

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![Completion](https://img.shields.io/badge/Completion-100%25-success)
![Files](https://img.shields.io/badge/Files-33+-blue)
![Lines](https://img.shields.io/badge/Lines-4800+-blue)

A **production-ready** Flutter MVVM template with Clean Architecture patterns. Choose only the features you need - from minimal starter to full-featured app with complete News example (3 screens, pagination, bookmarks).

> **🎉 Status: 100% COMPLETE & READY TO USE!** See [PUBLISH_READY.md](PUBLISH_READY.md) for details.

## ✨ Core Patterns (Always Included)

- � **Result Pattern** - Type-safe error handling
- ⚡ **Command Pattern** - Async operations with loading/error states
- ❌ **Comprehensive Failures** - 10+ ready-to-use failure types
- 🏗️ **Base ViewModel** - Foundation with lifecycle management
- � **Dependency Injection** - GetIt service locator setup
- 🎨 **Clean Architecture** - Domain, Data, Presentation separation

## 🔧 Optional Features (Your Choice)

Choose what you need during generation:

- 🌐 **API Integration** (Dio) - REST API setup with error mapping
- 🧭 **Go Router** - Type-safe navigation and deep linking
- 💾 **Hive Storage** - Local storage with type adapters
- 📰 **News Example** - Complete feature with pagination, bookmarks, tests

## 🎯 Why This Template?

**Flexible:** Not opinionated - choose only what you need
**Production-Ready:** Battle-tested patterns from real projects
**Learn by Example:** Optional complete feature implementation
**Well-Tested:** 79+ unit tests in example feature
**Modern:** Material Design 3, latest packages
**Documented:** Comprehensive guides and examples

## 📦 Customization Options

### Core (Always Included)

**Result Pattern** - Type-safe error handling
```dart
Future<Result<User, Failure>> getUser() {
  // Returns either Success(user) or Failure(error)
}
```

**Command Pattern** - Async operations with state
```dart
class LoadDataCommand extends Command<Data, Failure> {
  bool get isRunning;  // Automatic loading state
  Failure? get error;   // Automatic error handling
}
```

**Failure Classes** - Comprehensive error types
- NetworkFailure, ServerFailure, ClientFailure
- NotFoundFailure, UnauthorizedFailure, ForbiddenFailure
- CacheFailure, ValidationFailure, ParsingFailure

### Optional Features (Configurable)

**🌐 API Integration** (`use_api: true`)
- Dio HTTP client setup
- Base URL configuration
- Timeout settings
- API key integration

**🧭 Go Router** (`use_go_router: true`)
- Type-safe navigation
- Deep linking support
- Route configuration

**💾 Hive Storage** (`use_local_storage: true`)
- Local database setup
- Type adapters
- Box management

**📰 News Feature Example** (`include_example_feature: true`)
- Complete MVVM implementation
- List with infinite scroll pagination
- Detail view with navigation
- Bookmark functionality (with Hive)
- 79+ unit tests
- Real NewsData.io API integration

## 🚀 Quick Start

### Installation

**From GitHub (Recommended):**
```bash
mason add flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
```

**From Local Path:**
```bash
mason add flutter_mvvm_template --path /path/to/Flutter-Starter-Kit
```

### Generate Your Project

```bash
mason make flutter_mvvm_template
```

### Configuration Prompts

You'll be asked to choose your features:

```
✓ Project name: my_awesome_app
✓ Organization: com.mycompany
✓ Description: My production Flutter app
✓ Author: Your Name
✓ Include API integration? (Y/n) Y
✓ API base URL? https://api.myapp.com
✓ Include Go Router? (Y/n) Y
✓ Include Hive local storage? (Y/n) Y
✓ Include example News feature? (Y/n) Y
✓ NewsData.io API key? [press Enter for default]
```

### Setup Generated Project

```bash
cd my_awesome_app
flutter pub get
flutter run
```

**If using Hive (build_runner):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Run tests (if example included):**
```bash
flutter test
```

## � Configuration Examples

### Minimal Starter
Perfect for: Learning, building from scratch
```yaml
use_api: false
use_go_router: false
use_local_storage: false
include_example_feature: false
```
✨ **Result:** Core patterns only (~5 files)

### API-Ready
Perfect for: Backend-driven apps
```yaml
use_api: true
use_go_router: false
use_local_storage: false
include_example_feature: false
```
✨ **Result:** Core + Dio setup

### Full Production
Perfect for: Complete apps, learning by example
```yaml
use_api: true
use_go_router: true
use_local_storage: true
include_example_feature: true
```
✨ **Result:** Complete app with News feature, tests, everything!

## 📚 Generated Project Structure

**Minimal setup:**
```
lib/
├── main.dart
├── core/
│   ├── base/base_viewmodel.dart
│   ├── di/injection_container.dart
│   └── utils/
│       ├── result.dart
│       ├── command.dart
│       └── failures.dart
└── presentation/
    └── app.dart
```

**Full setup (all features):**
```
lib/
├── main.dart
├── core/
│   ├── base/
│   ├── di/
│   ├── utils/
│   └── storage/           # If use_local_storage
├── app/
│   └── router.dart        # If use_go_router
├── domain/news/           # If include_example_feature
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/news/             # If include_example_feature
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── app.dart
    └── news/              # If include_example_feature
        ├── news_list/
        ├── news_detail/
        └── bookmarks/
```

## 📖 Documentation

**Template Documentation:**
- [**Usage Guide**](./docs/USAGE_GUIDE.md) - Complete usage guide with examples
- [**Implementation Status**](./docs/IMPLEMENTATION_STATUS.md) - Current implementation details
- [**GitHub Repository**](https://github.com/abdialidrus/Flutter-Starter-Kit) - This template repository
- [**Example Project**](https://github.com/abdialidrus/Flutter-MVVM-Sample-Project) - Full working MVVM example

**In Generated Project:**
- Core patterns (Result, Command, Failures)
- Dependency injection setup
- Feature structure examples (if News included)
- 79+ unit tests (if News included)

## 💡 Common Use Cases

| Scenario | Recommended Config |
|----------|-------------------|
| **Learning MVVM** | Minimal: All features OFF |
| **REST API App** | API ON, others OFF |
| **Offline-First App** | Storage ON, API OFF |
| **Production App** | Everything ON |
| **Quick Prototype** | Minimal, add features later |
| **Team Standard** | Everything ON as reference |

## 🎓 Learning Path

1. **Start Minimal** - Generate with all OFF, study core patterns
2. **Add API** - Enable use_api, build a simple API feature
3. **Study Example** - Enable all features, explore News implementation
4. **Build Your Own** - Delete example, keep the patterns

## ⚡ What You Get

**Time Savings:**
- Manual setup: ~4 hours
- With template: ~2 minutes
- **Saved: 238 minutes per project!**

**Code Quality:**
- ✅ Production patterns from day 1
- ✅ Type-safe error handling
- ✅ Testable architecture
- ✅ Scalable structure
- ✅ Best practices built-in

## 🤝 Contributing

This Mason template helps you generate projects based on the architecture from [Flutter-MVVM-Sample-Project](https://github.com/abdialidrus/Flutter-MVVM-Sample-Project) - a production-ready MVVM implementation with 79+ tests.

**Repository**: [Flutter-Starter-Kit](https://github.com/abdialidrus/Flutter-Starter-Kit)

## 📄 License

MIT License - See LICENSE file for details

## 🙏 Credits

- **Mason** by Very Good Ventures
- **Clean Architecture** by Robert C. Martin
- **Flutter Team** for the amazing framework

---

## 🚀 Ready to Start?

```bash
# Add template from GitHub
mason add flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# Generate your project
mason make flutter_mvvm_template
```

**Questions? Check the [Usage Guide](./docs/USAGE_GUIDE.md)!**
