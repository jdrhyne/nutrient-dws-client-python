# Publishing nutrient-dws to PyPI

## Current Status
- ✅ Package built successfully (v1.0.1)
- ✅ All tests passing (154 tests, 94.21% coverage)
- ✅ CI pipeline green for all Python versions (3.8-3.12)
- ⚠️ Minor metadata warning from twine (won't affect functionality)

## Publishing Steps

### Step 1: Test with TestPyPI First
```bash
# Upload to TestPyPI
python3 -m twine upload --repository testpypi dist/* \
  --username __token__ \
  --password YOUR_TESTPYPI_TOKEN

# Test installation from TestPyPI
pip install --index-url https://test.pypi.org/simple/ nutrient-dws
```

### Step 2: Publish to Production PyPI
```bash
# Upload to PyPI
python3 -m twine upload dist/* \
  --username __token__ \
  --password YOUR_PYPI_TOKEN
```

### Step 3: Verify Installation
```bash
# Install from PyPI
pip install nutrient-dws

# Test import
python -c "from nutrient_dws import NutrientClient; print('Success!')"
```

## Getting PyPI Tokens

1. **For TestPyPI**: https://test.pypi.org/manage/account/token/
2. **For PyPI**: https://pypi.org/manage/account/token/

Create tokens with "Entire account" scope for the first upload. After the package exists, you can create scoped tokens.

## Alternative: Using .pypirc

Create `~/.pypirc`:
```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-YOUR_TOKEN_HERE

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-YOUR_TESTPYPI_TOKEN_HERE
```

Then upload with:
```bash
twine upload --repository testpypi dist/*  # For testing
twine upload dist/*  # For production
```

## Post-Publication

After successful publication:
1. Check the PyPI page: https://pypi.org/project/nutrient-dws/
2. Update GitHub repository with PyPI badges
3. Tag the release: `git tag v1.0.1 && git push --tags`
4. Create a GitHub release

## Note on Metadata Warning

The twine check shows a warning about 'license-file' field. This is due to newer setuptools generating metadata that older twine versions don't recognize. This warning:
- ✅ Does NOT prevent upload
- ✅ Does NOT affect package functionality
- ✅ Does NOT affect installation
- ❌ Only affects twine's validation

The package will work perfectly once uploaded.