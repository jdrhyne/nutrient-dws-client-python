#!/bin/bash

echo "Token Type Analysis"
echo "==================="
echo ""

# Check if it's a fine-grained token with specific repo access
echo "Testing token capabilities..."

# Test 1: Can we read issues? (we know this works)
echo -n "Read issues: "
if gh api repos/PSPDFKit/nutrient-dws-client-python/issues --silent 2>/dev/null; then
    echo "✅ YES"
else
    echo "❌ NO"
fi

# Test 2: Can we update repository settings?
echo -n "Update repo settings: "
if gh api repos/PSPDFKit/nutrient-dws-client-python -X PATCH -f description="Test" --silent 2>&1 | grep -q "403"; then
    echo "❌ NO (403 error)"
else
    echo "✅ YES"
fi

# Test 3: Can we create releases?
echo -n "Create releases: "
if gh api repos/PSPDFKit/nutrient-dws-client-python/releases -X POST -f tag_name="test-v0.0.1" -f name="Test" --silent 2>&1 | grep -q "403"; then
    echo "❌ NO (403 error)"
else
    echo "✅ YES (or other error)"
fi

# Test 4: Check specific token metadata
echo ""
echo "Token details:"
echo "Token prefix: $(echo $GITHUB_TOKEN | cut -c1-11)"

# The key insight
echo ""
echo "HYPOTHESIS:"
echo "This might be a fine-grained PAT with:"
echo "- Repository Contents: Write (allows push/PR)"
echo "- Issues: Read (not Write)"
echo "- Metadata: Read"
echo ""
echo "Even though you selected 'All repositories' when creating the token,"
echo "the default permissions for Issues might be 'Read' not 'Write'."
echo ""
echo "TO VERIFY:"
echo "1. Go to: https://github.com/settings/personal-access-tokens"
echo "2. Click on your token"
echo "3. Check 'Repository permissions' section"
echo "4. Specifically look at 'Issues' - it might be set to 'Read' instead of 'Write'"