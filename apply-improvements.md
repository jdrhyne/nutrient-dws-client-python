# How to Apply the Integration Test Improvements

You have several options to apply these changes:

## Option 1: Apply the Patch File
```bash
# Apply the patch
git apply integration-test-improvements.patch

# Or if you're on a different branch:
git checkout add-integration-tests-ci
git apply integration-test-improvements.patch
```

## Option 2: Cherry-pick the Commit
```bash
# The commit hash is: 444b4aa
git cherry-pick 444b4aa
```

## Option 3: Manual Changes

### 1. Update `.github/workflows/ci.yml`

In the `integration-test` job, make these changes:

**Change 1:** Add Python version matrix after line 60:
```yaml
strategy:
  matrix:
    python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']
```

**Change 2:** Update Python setup (line 65-68):
```yaml
- name: Set up Python ${{ matrix.python-version }}
  uses: actions/setup-python@v5
  with:
    python-version: ${{ matrix.python-version }}
```

**Change 3:** Add API key check after "Install dependencies" step:
```yaml
- name: Check for API key availability
  run: |
    if [ -z "${{ secrets.NUTRIENT_DWS_API_KEY }}" ]; then
      echo "::warning::NUTRIENT_DWS_API_KEY secret not found, skipping integration tests"
      echo "skip_tests=true" >> $GITHUB_ENV
    else
      echo "skip_tests=false" >> $GITHUB_ENV
    fi
```

**Change 4:** Add conditional to "Create integration config" step:
```yaml
- name: Create integration config with API key
  if: env.skip_tests != 'true'
  # ... rest of the step
```

**Change 5:** Add conditional to "Run integration tests" step:
```yaml
- name: Run integration tests
  if: env.skip_tests != 'true'
  run: python -m pytest tests/integration/ -v
```

**Change 6:** Add cleanup step at the end:
```yaml
- name: Cleanup integration config
  if: always()
  run: rm -f tests/integration/integration_config.py
```

### 2. Create `tests/integration/test_smoke.py`

Create this new file with the following content:
```python
"""Basic smoke test to validate integration test setup."""

import pytest

from nutrient_dws import NutrientClient

try:
    from . import integration_config

    API_KEY = integration_config.API_KEY
except (ImportError, AttributeError):
    API_KEY = None


@pytest.mark.skipif(not API_KEY, reason="No API key available")
def test_api_connection():
    """Test that we can connect to the API."""
    client = NutrientClient(api_key=API_KEY)
    # Just verify client initialization works
    assert client._api_key == API_KEY
    assert hasattr(client, "convert_to_pdf")
    assert hasattr(client, "build")
```

## Next Steps

1. Apply the changes using one of the methods above
2. Test locally if needed: `python -m pytest tests/integration/`
3. Commit and push to your fork
4. Update the PR

The improvements ensure:
- Consistent Python version testing
- Graceful handling of missing secrets
- Proper cleanup of sensitive files
- Basic validation that the setup works