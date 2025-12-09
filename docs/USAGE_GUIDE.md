# Template Usage Guide

## 🎯 Overview

This Mason template generates a Flutter project with **MVVM + Clean Architecture** patterns, with fully customizable features based on your needs.

---

## 📦 What's Included

### Core Architecture (Always Included)

Every generated project includes these production-ready patterns:

#### 1. **Result Pattern** (`lib/core/utils/result.dart`)
Type-safe error handling without exceptions:
```dart
Future<Result<User, Failure>> getUser() async {
  try {
    final user = await api.fetchUser();
    return Success(user);
  } catch (e) {
    return Failure(NetworkFailure());
  }
}

// Usage:
final result = await getUser();
result.when(
  success: (user) => print('Got user: ${user.name}'),
  failure: (error) => print('Error: $error'),
);
```

#### 2. **Command Pattern** (`lib/core/utils/command.dart`)
Async operations with built-in loading/error states:
```dart
class LoadUsersCommand extends Command<List<User>, Failure> {
  final GetUsersUseCase _getUsers;
  
  LoadUsersCommand(this._getUsers);
  
  @override
  Future<Result<List<User>, Failure>> execute() => _getUsers();
}

// In ViewModel:
final loadCommand = LoadUsersCommand(getIt());

// In UI:
if (command.isRunning) {
  return CircularProgressIndicator();
}
if (command.hasError) {
  return Text('Error: ${command.error}');
}
ElevatedButton(
  onPressed: () => command.run(),
  child: Text('Load'),
)
```

#### 3. **Comprehensive Failure Classes** (`lib/core/utils/failures.dart`)
Ready-to-use failure types:
- `NetworkFailure` - Connection issues
- `ServerFailure` - Backend errors (5xx)
- `ClientFailure` - Bad requests (4xx)
- `NotFoundFailure` - Resource not found (404)
- `UnauthorizedFailure` - Auth required (401)
- `CacheFailure` - Local storage errors
- `ValidationFailure` - Input validation
- `ParsingFailure` - JSON errors

#### 4. **Base ViewModel** (`lib/core/base/base_viewmodel.dart`)
Foundation for all ViewModels with lifecycle management:
```dart
class MyViewModel extends BaseViewModel {
  // Your state here
  
  @override
  void dispose() {
    // Cleanup
    super.dispose();
  }
}
```

#### 5. **Dependency Injection** (`lib/core/di/injection_container.dart`)
GetIt setup for service locator pattern:
```dart
await initializeDependencies();

// Register your services:
getIt.registerLazySingleton<MyRepository>(() => MyRepositoryImpl());
getIt.registerFactory<MyViewModel>(() => MyViewModel(getIt()));

// Use anywhere:
final viewModel = getIt<MyViewModel>();
```

---

## 🔧 Optional Features

### 1. API Integration (Dio)
**Enable with:** `use_api: true`

Includes:
- Dio setup with base URL
- Timeout configuration
- API key integration (for News example)
- Interceptor setup (commented, ready to use)

**Generated code:**
```dart
getIt.registerLazySingleton<Dio>(() {
  return Dio(BaseOptions(
    baseUrl: 'your-api-url',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
});
```

### 2. Go Router
**Enable with:** `use_go_router: true`

Includes:
- Type-safe routing setup
- Route configuration
- Deep linking ready

**Usage:**
```dart
// Navigate
context.go('/detail/123');
context.push('/settings');

// With parameters
context.go('/detail/${article.id}');
```

### 3. Hive Local Storage
**Enable with:** `use_local_storage: true`

Includes:
- Hive initialization
- Type adapter registration
- Box management

**Usage:**
```dart
// Store data
await box.put('key', value);

// Retrieve data
final value = box.get('key');

// Listen to changes
box.watch(key: 'key').listen((event) {
  print('Value changed: ${event.value}');
});
```

### 4. News Feature Example
**Enable with:** `include_example_feature: true`

Complete production-ready News app with:

**Features:**
- ✅ News list with infinite scroll
- ✅ Cursor-based pagination
- ✅ Pull-to-refresh
- ✅ News detail view
- ✅ Bookmark functionality (if Hive enabled)
- ✅ Error handling with retry
- ✅ Loading states
- ✅ Empty states

**Architecture:**
- ✅ Complete Clean Architecture (Domain, Data, Presentation)
- ✅ Repository pattern
- ✅ Use cases
- ✅ ViewModels with Commands
- ✅ Reactive UI
- ✅ Comprehensive tests (79+)

**API:**
- Uses NewsData.io free API
- Real-world API integration
- Pagination support
- Error handling

---

## 🎨 Configuration Combinations

### Minimal Setup
Perfect for: Starting from scratch, learning, lightweight apps
```yaml
use_api: false
use_go_router: false
use_local_storage: false
include_example_feature: false
```
**Result:** Just core patterns, ready to build your own features

### API Only
Perfect for: REST API apps without complex navigation
```yaml
use_api: true
use_go_router: false
use_local_storage: false
include_example_feature: false
```
**Result:** Core + Dio for API calls

### Full Stack
Perfect for: Production apps, learning by example
```yaml
use_api: true
use_go_router: true
use_local_storage: true
include_example_feature: true
```
**Result:** Complete production-ready app with News example

### Custom Mix
Enable only what you need:
```yaml
use_api: true          # For backend integration
use_go_router: true    # For navigation
use_local_storage: false  # Don't need local storage
include_example_feature: true  # Want to see examples
```

---

## 📱 Generated Project Structure

```
your_project/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── base/
│   │   │   └── base_viewmodel.dart
│   │   ├── di/
│   │   │   └── injection_container.dart
│   │   ├── utils/
│   │   │   ├── result.dart
│   │   │   ├── command.dart
│   │   │   └── failures.dart
│   │   └── storage/           # If use_local_storage=true
│   │       └── hive_storage.dart
│   ├── app/                   # If use_go_router=true
│   │   └── router.dart
│   ├── domain/                # If include_example_feature=true
│   │   └── news/
│   ├── data/                  # If include_example_feature=true
│   │   └── news/
│   └── presentation/          # If include_example_feature=true
│       ├── app.dart
│       └── news/
└── test/                      # If include_example_feature=true
    ├── domain/
    ├── data/
    └── presentation/
```

---

## 🚀 Getting Started

### 1. Generate Your Project

```bash
mason make flutter_mvvm_template
```

Answer the prompts:
```
? Project name: my_awesome_app
? Organization: com.mycompany
? Description: My production Flutter app
? Author: Your Name
? Include API integration? Y
? API base URL? https://api.myapp.com
? Include Go Router? Y
? Include Hive local storage? Y
? Include example News feature? Y
? NewsData.io API key? [press Enter for default]
```

### 2. Navigate to Project

```bash
cd my_awesome_app
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run Code Generation (if using Hive)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Run the App

```bash
flutter run
```

### 6. Run Tests (if example included)

```bash
flutter test
```

---

## 🎓 Learning Path

### Beginner: Start Minimal
1. Generate with all options = `false`
2. Study core patterns (Result, Command, Failures)
3. Build a simple feature using the patterns
4. Graduate to adding API integration

### Intermediate: API Integration
1. Generate with `use_api=true`, others `false`
2. Study how Dio is configured
3. Create your own repository and API calls
4. Add error handling with Failures

### Advanced: Full Example
1. Generate with all options = `true`
2. Study the complete News feature
3. See how all patterns work together
4. Delete News feature and build your own
5. Keep the patterns and structure

---

## 📝 Common Patterns

### Creating a New Feature

1. **Domain Layer**
```dart
// Entity
class User {
  final String id;
  final String name;
  User({required this.id, required this.name});
}

// Repository Interface
abstract class UserRepository {
  Future<Result<User, Failure>> getUser(String id);
}

// Use Case
class GetUser {
  final UserRepository _repository;
  GetUser(this._repository);
  
  Future<Result<User, Failure>> call(String id) {
    return _repository.getUser(id);
  }
}
```

2. **Data Layer**
```dart
// Model
class UserModel {
  final String id;
  final String name;
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  User toEntity() => User(id: id, name: name);
}

// Data Source
class UserRemoteDataSource {
  final Dio _dio;
  
  Future<UserModel> fetchUser(String id) async {
    final response = await _dio.get('/users/$id');
    return UserModel.fromJson(response.data);
  }
}

// Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _dataSource;
  
  @override
  Future<Result<User, Failure>> getUser(String id) async {
    try {
      final model = await _dataSource.fetchUser(id);
      return Success(model.toEntity());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Failure(NetworkFailure());
      }
      return Failure(ServerFailure());
    }
  }
}
```

3. **Presentation Layer**
```dart
// Command
class LoadUserCommand extends Command<User, Failure> {
  final GetUser _getUser;
  final String userId;
  
  LoadUserCommand(this._getUser, this.userId);
  
  @override
  Future<Result<User, Failure>> execute() {
    return _getUser(userId);
  }
}

// ViewModel
class UserViewModel extends BaseViewModel {
  User? _user;
  User? get user => _user;
  
  late final LoadUserCommand loadCommand;
  
  UserViewModel(GetUser getUser, String userId) {
    loadCommand = LoadUserCommand(getUser, userId);
  }
  
  Future<void> loadUser() async {
    final result = await loadCommand.run();
    result.when(
      success: (user) {
        _user = user;
        notifyListeners();
      },
      failure: (error) {
        // Error already in command.error
        notifyListeners();
      },
    );
  }
}

// Screen
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<UserViewModel>()..loadUser(),
      child: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loadCommand.isRunning) {
            return CircularProgressIndicator();
          }
          
          if (viewModel.loadCommand.hasError) {
            return Text('Error: ${viewModel.loadCommand.error}');
          }
          
          return Text('User: ${viewModel.user?.name}');
        },
      ),
    );
  }
}
```

4. **Register in DI**
```dart
// In injection_container.dart
getIt.registerLazySingleton<UserRemoteDataSource>(
  () => UserRemoteDataSource(getIt()),
);
getIt.registerLazySingleton<UserRepository>(
  () => UserRepositoryImpl(getIt()),
);
getIt.registerLazySingleton(() => GetUser(getIt()));
getIt.registerFactory(() => UserViewModel(getIt(), 'user-id'));
```

---

## 🧪 Testing Patterns

### Unit Test Example
```dart
void main() {
  group('GetUser UseCase', () {
    late MockUserRepository mockRepository;
    late GetUser useCase;
    
    setUp(() {
      mockRepository = MockUserRepository();
      useCase = GetUser(mockRepository);
    });
    
    test('should return User when repository returns success', () async {
      // Arrange
      final user = User(id: '1', name: 'John');
      when(() => mockRepository.getUser('1'))
          .thenAnswer((_) async => Success(user));
      
      // Act
      final result = await useCase('1');
      
      // Assert
      expect(result, Success(user));
      verify(() => mockRepository.getUser('1')).called(1);
    });
  });
}
```

---

## 💡 Tips & Best Practices

### 1. Keep Domain Pure
✅ No Flutter imports in `domain/`
✅ No external packages in entities
✅ Only business logic

### 2. Use Result Pattern Consistently
✅ Always return `Result<Success, Failure>`
✅ Handle all error cases
✅ Use appropriate Failure types

### 3. Commands for User Actions
✅ One command per user action
✅ Command handles loading state
✅ ViewModel orchestrates multiple commands

### 4. ViewModels are Thin
✅ Delegate to use cases
✅ Transform data for UI
✅ No business logic

### 5. Test Coverage
✅ Unit test all use cases
✅ Test repository error handling
✅ Test ViewModel state changes
✅ Mock dependencies

---

## 🔗 Resources

- **Main Project:** [Flutter-MVVM-Sample-Project](https://github.com/abdialidrus/Flutter-MVVM-Sample-Project)
- **Mason Docs:** [docs.brickhub.dev](https://docs.brickhub.dev)
- **Clean Architecture:** [blog.cleancoder.com](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- **MVVM Pattern:** [Microsoft Docs](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm)

---

**Need help? Check the main project for complete working examples!**
