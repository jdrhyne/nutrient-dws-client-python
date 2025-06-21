# Step-by-Step Guide to Publish nutrient-dws to PyPI

## Prerequisites Check
- [ ] Python 3.8+ installed
- [ ] Package built in `dist/` directory
- [ ] All tests passing (154 tests)
- [ ] CI pipeline green

## Step 1: Create PyPI Accounts (if needed)

### 1.1 Create TestPyPI Account (for testing)
1. Go to https://test.pypi.org/account/register/
2. Fill in the registration form
3. Verify your email

### 1.2 Create PyPI Account (for production)
1. Go to https://pypi.org/account/register/
2. Fill in the registration form
3. Verify your email

## Step 2: Generate API Tokens

### 2.1 TestPyPI Token
1. Log in to https://test.pypi.org/
2. Go to Account Settings → API tokens
3. Click "Add API token"
4. Token name: `nutrient-dws-upload`
5. Scope: "Entire account" (first time only)
6. Copy the token (starts with `pypi-`)
7. Save it securely (you won't see it again!)

### 2.2 PyPI Token
1. Log in to https://pypi.org/
2. Go to Account Settings → API tokens
3. Click "Add API token"
4. Token name: `nutrient-dws-upload`
5. Scope: "Entire account" (first time only)
6. Copy the token (starts with `pypi-`)
7. Save it securely (you won't see it again!)

## Step 3: Install Upload Tools

```bash
# Ensure twine is installed
pip3 install --upgrade twine

# Verify installation
python3 -m twine --version
```

## Step 4: Test Upload to TestPyPI

### 4.1 Upload to TestPyPI
```bash
cd /Users/admin/Projects/nutrient-dws-client-python

# Upload both wheel and source distribution
python3 -m twine upload --repository testpypi dist/* \
  --username __token__ \
  --password <YOUR_TESTPYPI_TOKEN>
```

Expected output:
```
Uploading distributions to https://test.pypi.org/legacy/
Uploading nutrient_dws-1.0.1-py3-none-any.whl
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 17.3/17.3 kB
Uploading nutrient_dws-1.0.1.tar.gz
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 17.9/17.9 kB
```

### 4.2 Verify TestPyPI Upload
1. Visit: https://test.pypi.org/project/nutrient-dws/
2. Check that version 1.0.1 is shown
3. Review the project description

### 4.3 Test Installation from TestPyPI
```bash
# Create a test virtual environment
python3 -m venv test_env
source test_env/bin/activate  # On Windows: test_env\Scripts\activate

# Install from TestPyPI
pip install --index-url https://test.pypi.org/simple/ \
  --extra-index-url https://pypi.org/simple/ \
  nutrient-dws

# Test the import
python -c "from nutrient_dws import NutrientClient; print('✅ Import successful!')"

# Test basic functionality
python -c "
from nutrient_dws import NutrientClient
client = NutrientClient(api_key='test')
print('✅ Client created successfully!')
"

# Deactivate test environment
deactivate
rm -rf test_env
```

## Step 5: Publish to Production PyPI

### 5.1 Final Checks
- [ ] TestPyPI upload successful
- [ ] Test installation works
- [ ] No critical issues found

### 5.2 Upload to PyPI
```bash
cd /Users/admin/Projects/nutrient-dws-client-python

# Upload to production PyPI
python3 -m twine upload dist/* \
  --username __token__ \
  --password <YOUR_PYPI_TOKEN>
```

Expected output:
```
Uploading distributions to https://upload.pypi.org/legacy/
Uploading nutrient_dws-1.0.1-py3-none-any.whl
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 17.3/17.3 kB
Uploading nutrient_dws-1.0.1.tar.gz
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 17.9/17.9 kB

View at:
https://pypi.org/project/nutrient-dws/1.0.1/
```

## Step 6: Verify Production Release

### 6.1 Check PyPI Page
1. Visit: https://pypi.org/project/nutrient-dws/
2. Verify version 1.0.1 is live
3. Check that description renders correctly
4. Verify all metadata is correct

### 6.2 Test Installation from PyPI
```bash
# Create a fresh virtual environment
python3 -m venv prod_test
source prod_test/bin/activate  # On Windows: prod_test\Scripts\activate

# Install from PyPI
pip install nutrient-dws

# Verify installation
pip show nutrient-dws

# Test import and basic usage
python -c "
from nutrient_dws import NutrientClient
print('✅ Import successful!')
print(f'Version: {__import__(\"nutrient_dws\").__version__}')
"

# Cleanup
deactivate
rm -rf prod_test
```

## Step 7: Post-Publication Tasks

### 7.1 Create Git Tag
```bash
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```

### 7.2 Create GitHub Release
1. Go to https://github.com/PSPDFKit/nutrient-dws-client-python/releases
2. Click "Create a new release"
3. Choose tag: `v1.0.1`
4. Release title: `v1.0.1`
5. Description:
```markdown
## nutrient-dws v1.0.1

First stable release of the Python client library for Nutrient Document Web Services API.

### Features
- Direct API for simple operations
- Builder API for complex workflows
- Comprehensive error handling
- Full type hints support
- 94% test coverage

### Installation
```bash
pip install nutrient-dws
```

### Documentation
See the [README](https://github.com/PSPDFKit/nutrient-dws-client-python) for usage examples.
```

### 7.3 Update Repository (Optional)
Add PyPI badges to README.md:
```markdown
[![PyPI version](https://badge.fury.io/py/nutrient-dws.svg)](https://pypi.org/project/nutrient-dws/)
[![Python versions](https://img.shields.io/pypi/pyversions/nutrient-dws.svg)](https://pypi.org/project/nutrient-dws/)
```

## Troubleshooting

### "Invalid distribution metadata" Warning
- This warning from twine can be ignored
- It doesn't prevent upload or affect functionality

### Authentication Failed
- Ensure you're using `__token__` as username
- Token must include the `pypi-` prefix
- Check for extra spaces or newlines in token

### Package Already Exists
- You can't re-upload the same version
- Increment version in pyproject.toml and rebuild

### Network/Proxy Issues
```bash
# If behind proxy
export HTTPS_PROXY=http://your-proxy:port
python3 -m twine upload --repository-url https://upload.pypi.org/legacy/ dist/*
```

## Security Notes
- Never commit tokens to git
- Use environment variables for automation:
  ```bash
  export TWINE_USERNAME=__token__
  export TWINE_PASSWORD=your-token-here
  python3 -m twine upload dist/*
  ```
- Consider using keyring for token storage:
  ```bash
  pip install keyring
  keyring set https://upload.pypi.org/legacy/ __token__
  ```

## Success Checklist
- [ ] Package visible on PyPI
- [ ] Installation works: `pip install nutrient-dws`
- [ ] Import works: `from nutrient_dws import NutrientClient`
- [ ] Git tag created and pushed
- [ ] GitHub release created
- [ ] Team notified of release

---
**Note**: This guide is for local use only. Do not commit to repository.