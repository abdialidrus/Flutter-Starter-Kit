# Publishing Guide to BrickHub

This guide walks you through publishing your Flutter MVVM Template to BrickHub.

## Prerequisites

1. **Mason CLI** installed globally:
   ```bash
   dart pub global activate mason_cli
   ```

2. **GitHub Account** (for authentication)

3. **Complete Brick Structure**:
   - ✅ `brick.yaml` with proper metadata
   - ✅ `README.md` with documentation
   - ✅ `CHANGELOG.md` with version history
   - ✅ `LICENSE` file (MIT License)
   - ✅ `__brick__` directory with template files

## Step-by-Step Publishing

### Step 1: Validate Your Brick

Before publishing, validate that your brick is properly configured:

```bash
cd /Users/towutikaryaabadi/Projects/flutter_mvvm_example/flutter_mvvm_template
mason bundle
```

This will create a `.mason` directory with your bundled brick. If there are any errors, fix them before proceeding.

### Step 2: Test Your Brick Locally

Test that your brick generates correctly:

```bash
# Add locally
mason add flutter_mvvm_template --path .

# Generate a test project
mkdir -p /tmp/test_project
cd /tmp/test_project
mason make flutter_mvvm_template
```

Follow the prompts and verify the generated project works correctly.

### Step 3: Login to BrickHub

Authenticate with BrickHub using your GitHub account:

```bash
mason login
```

This will open your browser and ask you to authorize Mason to access your GitHub account.

### Step 4: Publish Your Brick

From the brick directory, publish to BrickHub:

```bash
cd /Users/towutikaryaabadi/Projects/flutter_mvvm_example/flutter_mvvm_template
mason publish
```

Mason will:
1. Validate your brick configuration
2. Bundle your brick
3. Upload to BrickHub
4. Make it available for everyone to use

### Step 5: Verify Publication

After publishing, verify your brick is available:

1. Visit https://brickhub.dev
2. Search for "flutter_mvvm_template"
3. Verify your brick appears in the results

You can also test installation:

```bash
# Remove local version
mason remove flutter_mvvm_template

# Add from BrickHub
mason add flutter_mvvm_template

# Verify version
mason list
```

## Using Your Published Brick

Once published, anyone can use your brick with:

```bash
# Install Mason CLI (one-time)
dart pub global activate mason_cli

# Add your brick
mason add flutter_mvvm_template

# Generate a new project
mason make flutter_mvvm_template
```

## Updating Your Brick

When you want to publish a new version:

1. **Update version** in `brick.yaml`:
   ```yaml
   version: 0.2.0+1  # Increment version
   ```

2. **Update CHANGELOG.md** with changes:
   ```markdown
   # 0.2.0+1
   
   - ✨ Added new feature
   - 🐛 Fixed bug
   - 📝 Updated documentation
   ```

3. **Publish the update**:
   ```bash
   mason publish
   ```

Users can update to the new version with:
```bash
mason upgrade
```

## Version Numbering

Follow semantic versioning (semver):

- **Major** (1.0.0): Breaking changes
- **Minor** (0.1.0): New features, backward compatible
- **Patch** (0.0.1): Bug fixes
- **Build** (+1): Internal changes

## Alternative: Publish to Git

If you prefer not to use BrickHub, you can publish via Git:

1. **Push to GitHub**:
   ```bash
   git add flutter_mvvm_template/
   git commit -m "Add Mason template"
   git push origin main
   ```

2. **Users can install from Git**:
   ```bash
   mason add flutter_mvvm_template \
     --git-url https://github.com/abdialidrus/Flutter-Starter-Kit
   ```

## Troubleshooting

### "Not logged in" Error

```bash
mason login
```

### "Validation failed" Error

Check:
- ✅ `brick.yaml` has all required fields
- ✅ Version follows semver format
- ✅ `__brick__` directory exists and has content
- ✅ No syntax errors in template files

### "Already exists" Error

The brick name or version already exists. Either:
- Choose a different name in `brick.yaml`
- Increment the version number

## Best Practices

1. ✅ **Test locally** before publishing
2. ✅ **Write clear documentation** in README.md
3. ✅ **Keep CHANGELOG.md updated** with each release
4. ✅ **Use semantic versioning** consistently
5. ✅ **Add screenshots/GIFs** to README for visual appeal
6. ✅ **Tag releases** in Git for version tracking
7. ✅ **Respond to issues** and PRs from community

## Useful Commands

```bash
# Bundle brick locally
mason bundle

# List installed bricks
mason list

# Remove a brick
mason remove <brick_name>

# Upgrade all bricks
mason upgrade

# Search BrickHub
mason search <keyword>

# View brick info
mason info <brick_name>

# Logout from BrickHub
mason logout
```

## Resources

- [Mason Documentation](https://docs.brickhub.dev)
- [BrickHub](https://brickhub.dev)
- [Mason CLI GitHub](https://github.com/felangel/mason)
- [Semantic Versioning](https://semver.org)

---

**Ready to publish? Follow Step 1-5 above! 🚀**
