# Automated News Feature Copy Script

## 🤖 Quick Implementation Guide

Karena scope yang sangat besar (100+ files), berikut adalah **automated script** untuk copy News feature ke template:

---

## 📝 Script 1: Copy Domain Layer

```bash
#!/bin/bash

# Navigate to template brick
cd /Users/towutikaryaabadi/Projects/flutter_mvvm_example/flutter_mvvm_template/__brick__

# Create directories
mkdir -p lib/domain/news/{entities,repositories,usecases}

# Copy files from main project (will be wrapped in conditional)
SOURCE="/Users/towutikaryaabadi/Projects/flutter_mvvm_example"

# Note: Files already created manually with Mason variables
echo "✅ Domain layer structure created"
echo "✅ news_entity.dart - Created with conditional"
echo "✅ news_repository.dart - Created with conditional"
echo "⏳ Need to create use cases..."
```

---

## 📝 Use Cases to Create

### 1. Get Latest News
**File:** `lib/domain/news/usecases/get_latest_news.dart`

```dart
{{#include_example_feature}}
{{#use_api}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../repositories/news_repository.dart';

/// Use case to get latest news with pagination support
class GetLatestNews {
  final NewsRepository _repository;

  GetLatestNews(this._repository);

  /// Execute use case
  /// [page] is the token to load the next page
  Future<Result<PaginatedNewsResult, Failure>> call({String? page}) async {
    return await _repository.getLatestNews(page: page);
  }
}
{{/use_api}}
{{/include_example_feature}}
```

### 2. Bookmark Article
**File:** `lib/domain/news/usecases/bookmark_article_usecase.dart`

```dart
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case to bookmark a news article
class BookmarkArticleUseCase {
  final NewsRepository _repository;

  BookmarkArticleUseCase(this._repository);

  Future<Result<void, Failure>> call(NewsEntity news) async {
    return await _repository.bookmarkNews(news);
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
```

### 3. Remove Bookmark
**File:** `lib/domain/news/usecases/remove_bookmark_usecase.dart`

```dart
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../repositories/news_repository.dart';

/// Use case to remove a bookmark
class RemoveBookmarkUseCase {
  final NewsRepository _repository;

  RemoveBookmarkUseCase(this._repository);

  Future<Result<void, Failure>> call(String articleId) async {
    return await _repository.removeBookmark(articleId);
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
```

### 4. Get Bookmarked Articles
**File:** `lib/domain/news/usecases/get_bookmarked_articles_usecase.dart`

```dart
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case to get all bookmarked articles
class GetBookmarkedArticlesUseCase {
  final NewsRepository _repository;

  GetBookmarkedArticlesUseCase(this._repository);

  Future<Result<List<NewsEntity>, Failure>> call() async {
    return await _repository.getBookmarkedNews();
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
```

### 5. Is News Bookmarked
**File:** `lib/domain/news/usecases/is_news_bookmarked_usecase.dart`

```dart
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../repositories/news_repository.dart';

/// Use case to check if a news article is bookmarked
class IsNewsBookmarkedUseCase {
  final NewsRepository _repository;

  IsNewsBookmarkedUseCase(this._repository);

  Future<Result<bool, Failure>> call(String articleId) async {
    return await _repository.isNewsBookmarked(articleId);
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
```

---

## 📝 Script 2: Generate All Use Case Files

```bash
#!/bin/bash

cd /Users/towutikaryaabadi/Projects/flutter_mvvm_example/flutter_mvvm_template/__brick__/lib/domain/news/usecases

# Create get_latest_news.dart
cat > get_latest_news.dart << 'EOF'
{{#include_example_feature}}
{{#use_api}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../repositories/news_repository.dart';

class GetLatestNews {
  final NewsRepository _repository;
  GetLatestNews(this._repository);
  Future<Result<PaginatedNewsResult, Failure>> call({String? page}) async {
    return await _repository.getLatestNews(page: page);
  }
}
{{/use_api}}
{{/include_example_feature}}
EOF

# Create bookmark_article_usecase.dart
cat > bookmark_article_usecase.dart << 'EOF'
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

class BookmarkArticleUseCase {
  final NewsRepository _repository;
  BookmarkArticleUseCase(this._repository);
  Future<Result<void, Failure>> call(NewsEntity news) async {
    return await _repository.bookmarkNews(news);
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
EOF

# Create get_bookmarked_articles_usecase.dart
cat > get_bookmarked_articles_usecase.dart << 'EOF'
{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

class GetBookmarkedArticlesUseCase {
  final NewsRepository _repository;
  GetBookmarkedArticlesUseCase(this._repository);
  Future<Result<List<NewsEntity>, Failure>> call() async {
    return await _repository.getBookmarkedNews();
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
EOF

echo "✅ Use cases created"
```

---

## 🎯 Simplified Recommendation

Given the massive scope, I recommend **3 options**:

### Option A: Complete Manual Copy (Current Path) ⏰ 2-3 hours
Continue copying all 100+ files manually with Mason variables

**Pros:** Complete example
**Cons:** Very time consuming, many files to maintain

### Option B: Use Shell Script 🤖 30 minutes
Run the scripts above to generate files automatically

**Pros:** Faster
**Cons:** Still needs testing and validation

### Option C: Hybrid - Essential Files Only ⭐ RECOMMENDED
Copy only the **most essential files** that demonstrate the pattern:

**Essential Files (15-20 files):**
1. ✅ Domain: Entity, Repository interface, 2 use cases
2. ✅ Data: Model, Remote DataSource, Repository Impl
3. ✅ Presentation: 1 ViewModel, 1 Screen, 1 Command
4. ✅ Tests: 3-5 key tests

**Benefits:**
- Shows complete MVVM flow
- Much smaller scope (~20 files vs 100+)
- Easier to maintain
- Users can extend from example
- Reference main project for full implementation

---

## 💡 My Strong Recommendation

**Option C - Essential Files Only**

Copy these key files to show the pattern:

### Domain (5 files):
- ✅ news_entity.dart (done)
- ✅ news_repository.dart (done)
- ⏳ get_latest_news.dart
- ⏳ bookmark_article_usecase.dart
- ⏳ get_bookmarked_articles_usecase.dart

### Data (3 files):
- ⏳ news_article_model.dart
- ⏳ news_remote_datasource.dart
- ⏳ news_repository_impl.dart

### Presentation (5 files):
- ⏳ news_list_viewmodel.dart
- ⏳ news_list_screen.dart
- ⏳ load_news_command.dart
- ⏳ news_card.dart (widget)
- ⏳ app.dart (updated with routing)

### Tests (3 files):
- ⏳ news_entity_test.dart
- ⏳ news_repository_impl_test.dart
- ⏳ news_list_viewmodel_test.dart

**Total: ~16 essential files**
**Time: ~1 hour**
**Result: Complete working example that demonstrates all patterns**

---

## 🤔 What do you prefer?

**A)** Continue with full implementation (100+ files, 2-3 hours)
**B)** Use shell scripts (faster but needs testing)
**C)** Essential files only (recommended, ~16 files, 1 hour) ⭐

Let me know and I'll proceed accordingly!
