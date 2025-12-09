# Flutter MVVM Template 🚀

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A production-ready Flutter MVVM template with Clean Architecture, comprehensive testing, and industry best practices.

## ✨ Features

- 🏗️ **MVVM Architecture** with Clean Architecture principles
- 📱 **Unidirectional Data Flow** using Command pattern
- 🔄 **Infinite Scroll Pagination** with cursor-based tokens
- 🧪 **79+ Unit Tests** covering core business logic
- 🎨 **Modern UI** with Material Design 3
- 🌐 **API Integration** with Dio
- 💾 **Local Storage** with Hive
- 🧭 **Type-safe Routing** with Go Router
- 📦 **State Management** with Provider
- ✅ **Result Pattern** for error handling
- � **Comprehensive Documentation**

## 📦 What's Included

### Architecture
- Clean Architecture (Domain, Data, Presentation layers)
- MVVM pattern with ChangeNotifier
- Command pattern for user interactions
- Result pattern for type-safe error handling
- Repository pattern for data abstraction

### Testing
- Unit tests for all layers
- Mock setup with Mocktail
- Test coverage tracking
- Testing documentation and best practices

### Features
- List view with infinite scroll
- Detail view with bookmark functionality
- Bookmark management
- Pull-to-refresh
- Toast notifications
- Error handling

### Documentation
- Architecture guide
- Development guide
- Testing guide
- Navigation patterns
- Pagination implementation

## 🚀 Getting Started

### Prerequisites
- Mason CLI installed globally:
  ```bash
  dart pub global activate mason_cli
  ```

### Generate a New Project

1. **Add the template to Mason** (one-time setup):
   ```bash
   mason add flutter_mvvm_template --path /path/to/this/template
   ```

2. **Generate your project**:
   ```bash
   mason make flutter_mvvm_template
   ```

3. **Follow the prompts**:
   - Project name (snake_case)
   - Organization domain (com.example)
   - Project description
   - Author name
   - Include API integration? (yes/no)
   - API base URL (if applicable)

4. **Navigate to your project**:
   ```bash
   cd your_project_name
   ```

5. **Install dependencies**:
   ```bash
   flutter pub get
   ```

6. **Run code generation**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

7. **Run the app**:
   ```bash
   flutter run
   ```

## 📚 Project Structure

```
your_project/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   └── router.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── network/
│   │   ├── storage/
│   │   ├── utils/
│   │   └── di/
│   ├── data/
│   │   ├── models/
│   │   ├── datasources/
│   │   └── repositories/
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   └── presentation/
│       ├── global/
│       └── [features]/
│           ├── commands/
│           ├── widgets/
│           ├── [feature]_screen.dart
│           └── [feature]_viewmodel.dart
├── test/
│   ├── core/
│   ├── data/
│   ├── domain/
│   └── presentation/
└── docs/
```

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/path/to/test_file.dart
```

## 📖 Documentation

Generated project includes comprehensive documentation:
- `ARCHITECTURE.md` - Architecture patterns and data flow
- `DEVELOPMENT.md` - Development guide and best practices
- `TESTING_GUIDE.md` - Testing strategy and examples
- `NAVIGATION.md` - Navigation patterns
- `PAGINATION_IMPLEMENTATION.md` - Pagination guide

## 🎯 Use Cases

Perfect for:
- ✅ Production Flutter applications
- ✅ Learning Clean Architecture
- ✅ Implementing MVVM pattern
- ✅ Setting up comprehensive testing
- ✅ Building scalable apps
- ✅ Establishing team coding standards

## 🤝 Contributing

This template is based on the [Flutter MVVM Sample Project](https://github.com/abdialidrus/Flutter-MVVM-Sample-Project).

## 📄 License

This template is available under the MIT License.

## 🙏 Acknowledgments

- Very Good Ventures for Mason
- Flutter team for the amazing framework
- Clean Architecture principles by Robert C. Martin

---

**Generated with ❤️ using Mason**
