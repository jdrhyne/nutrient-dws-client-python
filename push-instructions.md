# Instructions to Push Your Changes

Since the command line push is failing due to permissions, here are your options:

## Option 1: Push via GitHub Web Interface

1. Go to: https://github.com/PSPDFKit/nutrient-dws-client-python/tree/add-integration-tests-ci
2. Click "Upload files" or use the web editor to make changes
3. Apply the changes from your local commit

## Option 2: Create a New Commit via Web

Since you have the changes locally, you can:

1. View the exact changes:
   ```bash
   git show 444b4aa
   ```

2. Go to the PR: https://github.com/PSPDFKit/nutrient-dws-client-python/pull/5

3. Use GitHub's web interface to:
   - Edit `.github/workflows/ci.yml`
   - Add `tests/integration/test_smoke.py`

## Option 3: Use Personal Access Token

If you have a PAT with the right permissions:
```bash
git push https://YOUR_USERNAME:YOUR_PAT@github.com/PSPDFKit/nutrient-dws-client-python.git add-integration-tests-ci
```

## Your Local Changes Summary

**Commit:** 444b4aa feat: enhance integration test workflow with improvements

**Files changed:**
1. `.github/workflows/ci.yml` - Updated integration-test job
2. `tests/integration/test_smoke.py` - New file

The changes add:
- Python version matrix for integration tests
- API key availability check
- Config file cleanup
- Basic smoke test

All changes are ready in your local branch and just need to be pushed to the remote.