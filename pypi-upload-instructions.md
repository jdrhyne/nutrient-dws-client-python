# PyPI Upload Instructions for nutrient-dws v1.0.1

## Package Status
✅ **Package built successfully**: 
- `dist/nutrient_dws-1.0.1.tar.gz` (source distribution)
- `dist/nutrient_dws-1.0.1-py3-none-any.whl` (wheel)

⚠️ **Metadata validation warnings**: The package has some metadata format warnings from newer setuptools versions, but these won't prevent upload or functionality.

## Upload Options

### Option 1: Manual Upload via PyPI Web Interface
1. Go to: https://pypi.org/manage/account/
2. Generate an API token with "Entire account" scope
3. Use twine upload with the token

### Option 2: Command Line Upload
```bash
# Install twine if not already installed
pip install twine

# Upload to TestPyPI first (recommended)
python3 -m twine upload --repository testpypi dist/* --username __token__ --password YOUR_TESTPYPI_TOKEN

# If test upload works, upload to real PyPI
python3 -m twine upload dist/* --username __token__ --password YOUR_PYPI_TOKEN
```

### Option 3: Configure ~/.pypirc file
Create `~/.pypirc` with:
```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = YOUR_PYPI_TOKEN

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = YOUR_TESTPYPI_TOKEN
```

Then upload with:
```bash
twine upload --repository testpypi dist/*  # Test first
twine upload dist/*  # Production
```

## Package Information
- **Name**: `nutrient-dws`
- **Version**: `1.0.1`
- **Description**: Python client library for Nutrient Document Web Services API
- **License**: MIT
- **Python Support**: 3.8+
- **Dependencies**: Only `requests>=2.25.0,<3.0.0`

## After Upload
1. **Verify installation**: `pip install nutrient-dws`
2. **Test basic import**: `python -c "from nutrient_dws import NutrientClient; print('Success!')"`
3. **Check PyPI page**: https://pypi.org/project/nutrient-dws/

## Next Steps After Release
Once the package is live on PyPI, we can:
1. ✅ Mark the release as complete
2. 🔄 Start working on the improvement PRs:
   - Increase test coverage to 80%+
   - Add more integration tests
   - Fix metadata format warnings
   - Add performance benchmarks
   - Consider async support

The package is production-ready and provides significant value to Python developers working with document processing.