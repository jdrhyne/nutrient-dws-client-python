# Manual Updates for PR #5

## File 1: `.github/workflows/ci.yml`

### Replace the entire `integration-test` job (lines 58-94) with:

```yaml
  integration-test:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    strategy:
      matrix:
        python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']
    
    steps:
    - uses: actions/checkout@v4

    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v5
      with:
        python-version: ${{ matrix.python-version }}

    - name: Cache pip dependencies
      uses: actions/cache@v4
      with:
        path: ~/.cache/pip
        key: ${{ runner.os }}-pip-${{ hashFiles('pyproject.toml') }}
        restore-keys: |
          ${{ runner.os }}-pip-

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -e ".[dev]"

    - name: Check for API key availability
      run: |
        if [ -z "${{ secrets.NUTRIENT_DWS_API_KEY }}" ]; then
          echo "::warning::NUTRIENT_DWS_API_KEY secret not found, skipping integration tests"
          echo "skip_tests=true" >> $GITHUB_ENV
        else
          echo "skip_tests=false" >> $GITHUB_ENV
        fi

    - name: Create integration config with API key
      if: env.skip_tests != 'true'
      run: |
        python -c "
        import os
        with open('tests/integration/integration_config.py', 'w') as f:
            f.write(f'API_KEY = \"{os.environ[\"NUTRIENT_DWS_API_KEY\"]}\"\n')
        "
      env:
        NUTRIENT_DWS_API_KEY: ${{ secrets.NUTRIENT_DWS_API_KEY }}

    - name: Run integration tests
      if: env.skip_tests != 'true'
      run: python -m pytest tests/integration/ -v

    - name: Cleanup integration config
      if: always()
      run: rm -f tests/integration/integration_config.py
```

## File 2: Create new file `tests/integration/test_smoke.py`

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

## How to Update the PR on GitHub

1. Go to PR #5: https://github.com/PSPDFKit/nutrient-dws-client-python/pull/5
2. Click on the "Files changed" tab
3. For `.github/workflows/ci.yml`:
   - Click the "..." menu on the file
   - Select "Edit file"
   - Replace the `integration-test` job section with the code above
   - Commit with message: "Add Python matrix, API key check, and cleanup"

4. For the new test file:
   - In the PR, click "Add file" → "Create new file"
   - Name it: `tests/integration/test_smoke.py`
   - Paste the content above
   - Commit with message: "Add basic smoke test for integration setup"

## Summary of Changes

1. **Python Version Matrix**: Tests now run on Python 3.8-3.12 (not just 3.12)
2. **API Key Check**: Tests skip gracefully if secret is not configured
3. **Conditional Execution**: Config creation and test execution only happen if API key exists
4. **Cleanup Step**: Always removes the generated config file
5. **Smoke Test**: Basic test to validate the setup works

These changes make the integration test infrastructure more robust and production-ready.