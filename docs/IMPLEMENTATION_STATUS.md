# Flutter MVVM Template - Implementation Guide

## 📋 Current Status

### ✅ Completed
- [x] Updated `brick.yaml` with 9 customizable variables
- [x] Updated `pubspec.yaml` with conditional dependencies
- [x] Added Command pattern base class
- [x] Added comprehensive Failure classes
- [x] Updated dependency injection with conditional setup
- [x] **News Feature - Domain Layer** (Entity, Repository, 3 Use Cases)
- [x] **News Feature - Data Layer** (Model, DataSources, Repository Impl)
- [x] **Support Files** (API Constants, Dio Client, Hive Service)

### 🔄 In Progress
- [ ] **News Feature - Presentation Layer** (ViewModels, Screens, Commands, Widgets)
- [ ] Add Go Router configuration
- [ ] Copy essential tests
- [ ] Update main.dart with conditional routing
- [ ] Update README with all options

---

## 🎯 Template Variables

The template now supports **9 customizable variables**:

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `project_name` | string | my_flutter_app | Project name (snake_case) |
| `organization` | string | com.example | Organization domain |
| `description` | string | A new Flutter MVVM project | Project description |
| `author` | string | Your Name | Author name |
| `use_api` | boolean | true | Include Dio API setup |
| `api_base_url` | string | https://newsdata.io/api/1 | API base URL |
| `use_go_router` | boolean | true | Include Go Router |
| `use_local_storage` | boolean | true | Include Hive storage |
| `include_example_feature` | boolean | true | Include News feature |
| `newsdata_api_key` | string | [default-key] | NewsData.io API key |

---

## 📦 Conditional Dependencies

### Always Included:
```yaml
flutter, cupertino_icons, get_it, provider
```

### Conditional (based on variables):

**If `use_api=true`:**
```yaml
dio: ^5.7.0
```

**If `use_go_router=true`:**
```yaml
go_router: ^14.6.2
```

**If `use_local_storage=true`:**
```yaml
hive: ^2.2.3
hive_flutter: ^1.1.0
path_provider: ^2.1.4
hive_generator: ^2.0.1  # dev dependency
```

**If `include_example_feature=true`:**
```yaml
cached_network_image: ^3.4.1
intl: ^0.19.0
mockito: ^5.4.4  # dev
mocktail: ^1.0.3  # dev
build_runner: ^2.4.13  # dev
```

---

## 🏗️ Core Architecture (Always Included)

### 1. Result Pattern
**File:** `lib/core/utils/result.dart`

Type-safe error handling:
```dart
sealed class Result<S, F> { ... }
final class Success<S, F> extends Result<S, F> { ... }
final class Failure<S, F> extends Result<S, F> { ... }
```

### 2. Command Pattern
**File:** `lib/core/utils/command.dart`

Async command with loading/error states:
```dart
abstract class Command<T, E> extends ChangeNotifier {
  bool get isRunning;
  E? get error;
  Future<Result<T, E>> execute();
  Future<Result<T, E>> run();
}
```

### 3. Failure Classes
**File:** `lib/core/utils/failures.dart`

Comprehensive failure types:
- `NetworkFailure` - Connection issues
- `ServerFailure` - 5xx errors
- `ClientFailure` - 4xx errors
- `NotFoundFailure` - 404 errors
- `UnauthorizedFailure` - 401 errors
- `ForbiddenFailure` - 403 errors
- `CacheFailure` - Local storage errors
- `ValidationFailure` - Data validation errors
- `ParsingFailure` - JSON parsing errors
- `UnexpectedFailure` - Unknown errors

### 4. Base ViewModel
**File:** `lib/core/base/base_viewmodel.dart`

Base class for all ViewModels:
```dart
abstract class BaseViewModel extends ChangeNotifier {
  bool get isDisposed;
  @override void dispose();
  @override void notifyListeners();
}
```

---

## 🔧 Optional Components

### 1. Go Router Setup (if use_go_router=true)

**File:** `lib/app/router.dart`

```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => NewsListScreen()),
    GoRoute(path: '/detail/:id', builder: (context, state) => NewsDetailScreen()),
    GoRoute(path: '/bookmarks', builder: (context, state) => BookmarksScreen()),
  ],
);
```

**In main.dart:**
```dart
{{#use_go_router}}
return MaterialApp.router(
  routerConfig: router,
);
{{/use_go_router}}
{{^use_go_router}}
return MaterialApp(
  home: {{#include_example_feature}}NewsListScreen(){{/include_example_feature}}
         {{^include_example_feature}}App(){{/include_example_feature}},
);
{{/use_go_router}}
```

### 2. Hive Storage Setup (if use_local_storage=true)

**File:** `lib/core/storage/hive_storage.dart`

```dart
class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters
    // Open boxes
  }
}
```

**In injection_container.dart:**
```dart
{{#use_local_storage}}
await Hive.initFlutter();
{{#include_example_feature}}
Hive.registerAdapter(NewsArticleModelAdapter());
await Hive.openBox<NewsArticleModel>('bookmarks');
{{/include_example_feature}}
{{/use_local_storage}}
```

---

## 📰 News Feature (if include_example_feature=true)

### Complete MVVM Implementation

**Domain Layer:**
```
lib/domain/news/
├── entities/
│   └── news_entity.dart
├── repositories/
│   └── news_repository.dart
└── usecases/
    ├── get_latest_news.dart
    ├── bookmark_news.dart
    ├── remove_bookmark.dart
    ├── get_bookmarked_news.dart
    └── is_news_bookmarked.dart
```

**Data Layer:**
```
lib/data/news/
├── models/
│   └── news_article_model.dart (with Hive adapter)
├── datasources/
│   ├── news_remote_datasource.dart
│   └── news_local_datasource.dart
└── repositories/
    └── news_repository_impl.dart
```

**Presentation Layer:**
```
lib/presentation/news/
├── news_list/
│   ├── news_list_screen.dart
│   ├── news_list_viewmodel.dart
│   └── commands/
│       ├── load_news_command.dart
│       └── refresh_news_command.dart
├── news_detail/
│   ├── news_detail_screen.dart
│   └── news_detail_viewmodel.dart
├── bookmarks/
│   ├── bookmarks_screen.dart
│   └── bookmarks_viewmodel.dart
└── widgets/
    ├── news_card.dart
    ├── loading_indicator.dart
    └── error_view.dart
```

**Tests:**
```
test/
├── domain/news/
│   ├── entities/news_entity_test.dart
│   └── usecases/get_latest_news_test.dart
├── data/news/
│   ├── models/news_article_model_test.dart
│   ├── datasources/news_remote_datasource_test.dart
│   └── repositories/news_repository_impl_test.dart
└── presentation/news/
    ├── news_list_viewmodel_test.dart
    └── commands/load_news_command_test.dart
```

---

## 🎨 Feature Highlights

### 1. Cursor-Based Pagination
```dart
class NewsListViewModel extends BaseViewModel {
  final GetLatestNews _getLatestNews;
  
  String? _nextPageToken;
  bool _hasMoreData = true;
  
  Future<void> loadMore() async {
    if (!_hasMoreData) return;
    
    final result = await _getLatestNews(page: _nextPageToken);
    result.when(
      success: (data) {
        _news.addAll(data.news);
        _nextPageToken = data.nextPage;
        _hasMoreData = data.nextPage != null;
      },
      failure: (error) => _error = error,
    );
    notifyListeners();
  }
}
```

### 2. Bookmark with Hive
```dart
{{#use_local_storage}}
class NewsLocalDataSource {
  final Box<NewsArticleModel> _bookmarksBox;
  
  Future<void> bookmarkArticle(NewsArticleModel article) async {
    await _bookmarksBox.put(article.articleId, article);
  }
  
  Future<List<NewsArticleModel>> getBookmarkedArticles() async {
    return _bookmarksBox.values.toList();
  }
}
{{/use_local_storage}}
```

### 3. Command Pattern Usage
```dart
class LoadNewsCommand extends Command<List<NewsEntity>, Failure> {
  final GetLatestNews _getLatestNews;
  
  LoadNewsCommand(this._getLatestNews);
  
  @override
  Future<Result<List<NewsEntity>, Failure>> execute() async {
    return await _getLatestNews();
  }
}

// In ViewModel:
final loadCommand = LoadNewsCommand(getIt());

// In UI:
ElevatedButton(
  onPressed: loadCommand.isRunning ? null : () => loadCommand.run(),
  child: loadCommand.isRunning 
    ? CircularProgressIndicator() 
    : Text('Load News'),
)
```

---

## 🚀 Next Steps

### To Complete Implementation:

1. **Copy News Feature Files**
   - Copy all domain layer files
   - Copy all data layer files
   - Copy all presentation layer files
   - Copy all test files

2. **Add Mason Variables**
   - Replace package names with `{{project_name.snakeCase()}}`
   - Add conditional blocks `{{#variable}}...{{/variable}}`
   - Handle Go Router vs Navigator conditionally
   - Handle Hive bookmark conditionally

3. **Update Documentation**
   - Update main README.md
   - Create usage examples
   - Add troubleshooting guide

4. **Test Template Generation**
   - Test with all features enabled
   - Test with minimal features
   - Test various combinations
   - Verify all generated code compiles

---

## 📝 Manual Steps Required

Due to the large scope (100+ files to copy and templatize), here's the recommended approach:

### Option A: Gradual Implementation
Continue implementation in phases:
1. Core patterns ✅ (Done)
2. Optional components (Go Router, Hive)
3. News feature domain layer
4. News feature data layer  
5. News feature presentation layer
6. All tests
7. Documentation

### Option B: Manual Copy & Templatize
1. Copy entire `lib/domain`, `lib/data`, `lib/presentation/news` to `__brick__`
2. Search & replace `flutter_mvvm_example` with `{{project_name.snakeCase()}}`
3. Add conditional blocks around optional features
4. Copy all test files
5. Test generation

### Option C: Use Current Project as Reference
Keep the main project as the "full example" and make the template more minimal:
- Include only core patterns
- Provide detailed docs on how to add features
- Reference main project as example

---

## 💡 Recommendation

Given the time required to fully implement Option A/B, I recommend **continuing with what we have**:

### Current Template Provides:
✅ Core architecture patterns (Result, Command, Failures, BaseViewModel)
✅ Conditional dependency injection
✅ Flexible configuration (9 variables)
✅ Production-ready structure

### What Users Can Do:
✅ Generate clean MVVM structure
✅ Reference main project for full examples
✅ Copy features they need from main project
✅ Learn from 79+ test examples in main project

### Next Immediate Step:
Update documentation to reflect current state and provide clear guidance on:
1. What's included in template
2. How to extend with features from main project
3. Link to main project as living example

Would you like me to:
**A)** Continue implementing News feature (will take 2-3 more hours)
**B)** Update documentation to reflect current state
**C)** Create a hybrid approach with partial example

Your choice? 🤔
