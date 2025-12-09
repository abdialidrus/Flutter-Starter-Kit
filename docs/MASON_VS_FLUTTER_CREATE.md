# 🎯 Mason Can Create Complete Flutter Projects!

## The Problem

Your current Mason template generates:
- ✅ Dart files (lib/, test/)
- ✅ pubspec.yaml
- ✅ analysis_options.yaml
- ❌ **NO** Android/iOS native folders
- ❌ **NO** platform setup

**This means**: User must run `flutter create` first, then apply your template.

---

## The Solution: Mason Post-Generation Hooks

Mason supports **hooks** - scripts that run AFTER generation!

### How It Works

1. Mason generates your files
2. Mason runs a post-generation hook
3. Hook executes `flutter create` command
4. Result: Complete Flutter project with your architecture!

---

## Implementation

### Option A: Post-Generation Hook (Recommended)

Create `hooks/post_gen.dart`:

```dart
import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  final progress = context.logger.progress('Creating Flutter project');
  
  try {
    // Run flutter create
    final result = await Process.run(
      'flutter',
      [
        'create',
        '--empty',
        '--platforms=android,ios',
        '.',
      ],
    );
    
    if (result.exitCode == 0) {
      progress.complete('Flutter project created successfully!');
    } else {
      progress.fail('Failed to create Flutter project');
      context.logger.err(result.stderr.toString());
    }
  } catch (e) {
    progress.fail('Error: $e');
  }
}
```

### Option B: Pre-Generation Hook

Create `hooks/pre_gen.dart`:

```dart
import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final projectName = context.vars['project_name'];
  
  // Check if Flutter is installed
  final flutterCheck = await Process.run('which', ['flutter']);
  
  if (flutterCheck.exitCode != 0) {
    context.logger.err('Flutter SDK not found!');
    context.logger.info('Please install Flutter: https://flutter.dev');
    exit(1);
  }
  
  context.logger.info('Flutter SDK found ✓');
}
```

---

## Better Approach: Two-Phase Generation

### Phase 1: Create Flutter Project

User runs standard Flutter command:
```bash
flutter create --empty --org com.mycompany my_app
cd my_app
```

### Phase 2: Apply MVVM Architecture

User runs Mason inside the project:
```bash
mason make flutter_mvvm_template
```

Mason then:
1. Generates all your architecture files
2. **Overwrites** pubspec.yaml with dependencies
3. Adds your lib/ structure
4. Adds your test/ structure

---

## Recommendation for Your Template

### Current Approach (Keep It!)

**Why it's GOOD**:
- ✅ User has control over Flutter project creation
- ✅ Follows standard Flutter workflow
- ✅ No conflicts with existing projects
- ✅ Can be applied to existing apps
- ✅ Simpler to maintain

**User Flow**:
```bash
# Step 1: Create Flutter project
flutter create --empty my_app
cd my_app

# Step 2: Apply MVVM template
mason make flutter_mvvm_template
```

### Alternative: All-in-One (More Complex)

Mason creates everything including Flutter project structure.

**Pros**:
- ✅ One command
- ✅ Simpler for users

**Cons**:
- ❌ More complex template
- ❌ Harder to maintain
- ❌ Can't apply to existing projects
- ❌ Less flexible

---

## My Recommendation

**Update your README to clarify the workflow:**

```markdown
## 🚀 Quick Start

### Step 1: Create Flutter Project

First, create a new Flutter project:

\`\`\`bash
# Create empty Flutter project
flutter create --empty --org com.yourcompany my_awesome_app
cd my_awesome_app
\`\`\`

### Step 2: Apply MVVM Template

Then, apply the MVVM architecture template:

\`\`\`bash
# Add Mason template (one-time)
mason add -g flutter_mvvm_template \\
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# Apply template to your project
mason make flutter_mvvm_template
\`\`\`

### Step 3: Configure & Run

\`\`\`bash
# Install dependencies
flutter pub get

# Run the app
flutter run
\`\`\`
```

This makes it CRYSTAL CLEAR that:
1. User creates Flutter project FIRST
2. Then applies your architecture template

---

## What Your Template Actually Does

Your template is an **"Architecture Overlay"**:

```
User's Project          Your Template         Result
---------------         -------------         ------
(empty Flutter)    +    (MVVM files)    =    (MVVM Flutter App)
```

**Before Mason:**
```
my_app/
├── android/
├── ios/
├── lib/
│   └── main.dart
└── pubspec.yaml
```

**After Mason:**
```
my_app/
├── android/               # From flutter create
├── ios/                   # From flutter create
├── lib/
│   ├── main.dart         # Your template
│   ├── core/             # Your template
│   ├── domain/           # Your template
│   ├── data/             # Your template
│   └── presentation/     # Your template
├── test/                 # Your template
└── pubspec.yaml          # Your template (overwritten)
```

---

## Action Items

1. **Update README** to show 2-step process clearly
2. **Add section** explaining what the template does/doesn't do
3. **Optional**: Add post_gen hook to verify Flutter SDK
4. **Optional**: Add warning if not in Flutter project directory

Want me to update the README with this clarification?
