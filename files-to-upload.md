# Files to Upload to PR #5

You need to upload/modify these 2 files:

## 1. UPDATE EXISTING FILE: `.github/workflows/ci.yml`

This file already exists in the PR. You need to UPDATE it (not upload a new one).

### How to update:
1. Go to the PR files view: https://github.com/PSPDFKit/nutrient-dws-client-python/pull/5/files
2. Click on `.github/workflows/ci.yml`
3. Click the "..." menu and select "Edit file"
4. Replace the entire `integration-test` job (lines ~58-94) with the improved version
5. The key changes are:
   - Added `strategy.matrix` for Python versions
   - Changed `Set up Python 3.12` to `Set up Python ${{ matrix.python-version }}`
   - Added "Check for API key availability" step
   - Added `if: env.skip_tests != 'true'` conditions
   - Added "Cleanup integration config" step at the end

## 2. CREATE NEW FILE: `tests/integration/test_smoke.py`

This is a NEW file that needs to be added.

### How to add:
1. In the PR, click "Add file" → "Create new file"
2. Enter the path: `tests/integration/test_smoke.py`
3. Copy and paste the entire content from your local file

### File locations in your local repo:
- Modified CI workflow: `.github/workflows/ci.yml`
- New test file: `tests/integration/test_smoke.py`

## To see the exact content to upload:

```bash
# View the updated CI workflow
cat .github/workflows/ci.yml

# View the new test file
cat tests/integration/test_smoke.py
```

## Alternative: Upload via GitHub's file upload

1. Go to: https://github.com/PSPDFKit/nutrient-dws-client-python/tree/add-integration-tests-ci
2. Navigate to `tests/integration/`
3. Click "Upload files"
4. Drag and drop `test_smoke.py` from your local `tests/integration/` folder
5. For the CI workflow, you'll still need to edit it manually since it already exists