# 📖 Complete Setup Guide

## Understanding the Workflow

This template is an **architecture overlay** - it adds MVVM patterns to a Flutter project.

---

## 🎯 Two-Phase Setup

### Phase 1: Flutter Project (Flutter CLI)

Create the base Flutter project structure:

```bash
flutter create --empty --org com.yourcompany my_awesome_app
```

**What this creates:**
```
my_awesome_app/
├── android/          # Android native code
├── ios/              # iOS native code
├── lib/
│   └── main.dart    # Default main file
├── test/
├── pubspec.yaml     # Basic dependencies
└── README.md
```

### Phase 2: MVVM Architecture (Mason Template)

Apply the MVVM architecture template:

```bash
cd my_awesome_app
mason make flutter_mvvm_template
```

**What this adds/modifies:**
```
my_awesome_app/
├── android/          # ← Unchanged
├── ios/              # ← Unchanged
├── lib/
│   ├── main.dart    # ← Updated with DI initialization
│   ├── core/        # ← NEW: Base classes, utils
│   ├── domain/      # ← NEW: Business logic (if example enabled)
│   ├── data/        # ← NEW: Data sources (if example enabled)
│   └── presentation/# ← NEW: UI & ViewModels
├── test/            # ← NEW: Test structure
├── pubspec.yaml     # ← Updated with MVVM dependencies
└── README.md        # ← Updated with project info
```

---

## 📋 Complete Step-by-Step

### Step 1: Prerequisites

Ensure you have:
- ✅ Flutter SDK installed
- ✅ Mason CLI installed: `dart pub global activate mason_cli`

### Step 2: Create Flutter Project

```bash
# Navigate to your projects folder
cd ~/Projects

# Create new Flutter project
flutter create --empty --org com.yourcompany my_awesome_app

# Enter project directory
cd my_awesome_app
```

### Step 3: Install Mason Template (One-Time)

```bash
# Install template globally
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# Verify installation
mason list
# Should show: flutter_mvvm_template
```

### Step 4: Apply MVVM Template

```bash
# Make sure you're in your Flutter project directory
pwd  # Should show: /path/to/my_awesome_app

# Apply the template
mason make flutter_mvvm_template
```

### Step 5: Configure Your Project

Answer the prompts:

```
✓ Project name: my_awesome_app
✓ Organization: com.yourcompany
✓ Description: My production Flutter app
✓ Author: Your Name
✓ Include API integration? (Y/n) Y
✓ API base URL? https://api.myapp.com
✓ Include Go Router? (Y/n) Y
✓ Include Hive local storage? (Y/n) Y
✓ Include example News feature? (Y/n) Y
✓ NewsData.io API key? [press Enter for default]
```

### Step 6: Install Dependencies

```bash
flutter pub get
```

### Step 7: Run Code Generation (if using Hive)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 8: Run Your App

```bash
flutter run
```

---

## 🎨 What You Get

### Minimal Configuration (All OFF)
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

### Full Configuration (All ON)
```
lib/
├── main.dart
├── core/
│   ├── base/
│   ├── di/
│   ├── utils/
│   ├── constants/
│   ├── network/
│   └── storage/
├── app/
│   └── router.dart
├── domain/news/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/news/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── app.dart
    └── news/
        ├── news_list/
        ├── news_detail/
        └── bookmarks/
```

---

## 💡 Common Questions

### Q: Can I use this on an existing Flutter project?

**A:** Yes! Just run `mason make flutter_mvvm_template` inside your existing project.

⚠️ **Warning**: This will overwrite:
- `pubspec.yaml`
- `lib/main.dart`
- `lib/app.dart` (if exists)

Backup your files first!

### Q: Do I need to run `flutter create` every time?

**A:** No! Only once per new project.

**Workflow for multiple projects:**
```bash
# Project 1
flutter create --empty project1
cd project1
mason make flutter_mvvm_template

# Project 2
cd ..
flutter create --empty project2
cd project2
mason make flutter_mvvm_template  # Uses same template
```

### Q: Can Mason create the Flutter project too?

**A:** Not out of the box, but you can add a post-generation hook to run `flutter create`. However, the current two-phase approach is cleaner and more flexible.

### Q: What if I want different Android/iOS configurations?

**A:** Use `flutter create` with your preferred options:
```bash
# Custom org and description
flutter create --org com.mycompany --description "My app" my_app

# Specific platforms only
flutter create --platforms=android,ios my_app

# With Swift and Kotlin
flutter create --ios-language swift --android-language kotlin my_app
```

Then apply the Mason template.

---

## 🚀 Quick Reference Card

```bash
# ============================================
# ONE-TIME SETUP
# ============================================

# Install Mason CLI (if not installed)
dart pub global activate mason_cli

# Install template globally
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit


# ============================================
# FOR EACH NEW PROJECT
# ============================================

# 1. Create Flutter project
flutter create --empty --org com.yourcompany my_app
cd my_app

# 2. Apply MVVM template
mason make flutter_mvvm_template

# 3. Install & run
flutter pub get
flutter run
```

---

## 📚 Next Steps

After setup:
1. ✅ Explore the generated code structure
2. ✅ Read the architecture documentation
3. ✅ Study the example News feature (if included)
4. ✅ Start building your own features
5. ✅ Run tests: `flutter test`

---

**Need help? Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)!**
