UPLOAD INSTRUCTIONS FOR PR #5
=============================

This folder contains the files you need to upload to update PR #5.

STEP 1: Upload the CI workflow
------------------------------
1. Go to: https://github.com/PSPDFKit/nutrient-dws-client-python/tree/add-integration-tests-ci/.github/workflows
2. Click on "ci.yml" to open it
3. Click the pencil icon to edit
4. Select all (Cmd+A) and delete
5. Copy the entire contents of "ci.yml" from this folder
6. Paste it into the editor
7. Scroll down and commit with message: "feat: enhance integration test workflow"

STEP 2: Upload the test file
-----------------------------
1. Go to: https://github.com/PSPDFKit/nutrient-dws-client-python/tree/add-integration-tests-ci/tests/integration
2. Click "Upload files" or "Add file" → "Create new file"
3. If using "Upload files": Drag "test_smoke.py" from this folder
4. If using "Create new file": 
   - Name it "test_smoke.py"
   - Copy and paste the contents from "test_smoke.py" in this folder
5. Commit with message: "Add basic smoke test for integration setup"

WHAT'S IN THIS FOLDER:
- ci.yml: The complete updated CI workflow file
- test_smoke.py: The new integration test file
- README.txt: This instruction file

The changes add:
✓ Python version matrix for integration tests (3.8-3.12)
✓ API key availability check with graceful skip
✓ Config file cleanup after tests
✓ Basic smoke test to validate setup