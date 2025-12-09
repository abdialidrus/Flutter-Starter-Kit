# 🔧 Installation Troubleshooting Guide

## Common Errors & Solutions

### ❌ Error 1: "Cannot find mason.yaml. Did you forget to run mason init?"

**Cause**: Trying to add template locally without initializing Mason workspace

**Solutions:**

#### Solution A: Use Global Installation (Recommended)
```bash
# Add -g flag to install globally
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
```

#### Solution B: Initialize Mason First
```bash
# Initialize Mason in current directory
mason init

# Then add template locally
mason add flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
```

---

### ❌ Error 2: "Template not found" or "Brick not found"

**Cause**: Template not installed or cache issue

**Solution:**
```bash
# Check installed templates
mason list

# If not found, reinstall
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# If still issues, clear cache
mason cache clear
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
```

---

### ❌ Error 3: Git clone failed or repository not found

**Cause**: Wrong repository URL or network issue

**Solution:**
```bash
# Verify repository URL is correct
# Should be: https://github.com/abdialidrus/Flutter-Starter-Kit

# NOT: https://github.com/abdialidrus/Flutter-MVVM-Sample-Project

# Correct command:
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
```

---

### ❌ Error 4: Permission denied

**Cause**: Insufficient permissions to install globally

**Solution:**
```bash
# Option 1: Use local installation instead
mason init
mason add flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# Option 2: Check Dart pub cache permissions
ls -la ~/.pub-cache/
```

---

## Understanding Global vs Local Installation

### Global Installation (`-g` flag)
```bash
mason add -g flutter_mvvm_template --git-url <URL>
```
- ✅ Can use template from any directory
- ✅ No need to run `mason init`
- ✅ Installed in global Mason cache
- ✅ **Recommended for templates**

### Local Installation (no `-g` flag)
```bash
mason init  # Required first
mason add flutter_mvvm_template --git-url <URL>
```
- ⚠️ Requires `mason.yaml` in current directory
- ⚠️ Must run `mason init` first
- ⚠️ Template only available in that directory
- ℹ️ Good for project-specific bricks

---

## Verification Steps

### Step 1: Check Mason CLI is installed
```bash
mason --version
# Should show version like: mason 0.1.0-dev.52
```

### Step 2: Check template is installed
```bash
mason list
# Should show: flutter_mvvm_template
```

### Step 3: Test generation
```bash
# Create test directory
mkdir test-project && cd test-project

# Generate
mason make flutter_mvvm_template

# Follow prompts and verify files are created
ls -la
```

---

## Complete Fresh Install Process

### For Most Users (Recommended)
```bash
# 1. Ensure Mason CLI is installed
dart pub global activate mason_cli

# 2. Add template globally
mason add -g flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# 3. Verify
mason list

# 4. Generate project anywhere
cd ~/Projects/my-new-app
mason make flutter_mvvm_template
```

### For Local Development
```bash
# 1. Create workspace
mkdir my-mason-workspace
cd my-mason-workspace

# 2. Initialize Mason
mason init

# 3. Add template
mason add flutter_mvvm_template \
  --git-url https://github.com/abdialidrus/Flutter-Starter-Kit

# 4. Generate
mason make flutter_mvvm_template
```

---

## Still Having Issues?

1. **Check Mason CLI version**:
   ```bash
   mason --version
   dart pub global activate mason_cli  # Update if needed
   ```

2. **Clear all caches**:
   ```bash
   mason cache clear
   dart pub cache repair
   ```

3. **Reinstall template**:
   ```bash
   mason remove -g flutter_mvvm_template
   mason add -g flutter_mvvm_template \
     --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
   ```

4. **Verify repository is accessible**:
   ```bash
   git clone https://github.com/abdialidrus/Flutter-Starter-Kit
   # Should successfully clone
   ```

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `mason init` | Initialize Mason workspace (creates mason.yaml) |
| `mason add -g <name> --git-url <url>` | Install template globally |
| `mason add <name> --git-url <url>` | Install template locally |
| `mason list` | List installed templates |
| `mason remove -g <name>` | Remove global template |
| `mason cache clear` | Clear Mason cache |
| `mason make <name>` | Generate project from template |

---

**Need more help? Check the [main README](../README.md) or open an issue on GitHub!**
