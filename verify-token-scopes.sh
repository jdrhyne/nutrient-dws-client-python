#!/bin/bash

echo "GitHub Token Scope Verification"
echo "==============================="
echo ""

# Get current user and check scopes
echo "Checking current token scopes..."
response=$(gh api user -H "Accept: application/vnd.github.v3+json" --include 2>&1)

# Extract scopes
scopes=$(echo "$response" | grep -i "x-oauth-scopes:" | sed 's/.*x-oauth-scopes: *//' | tr ',' '\n' | sed 's/^ *//')

if [ -z "$scopes" ]; then
    echo "❌ Could not determine token scopes"
else
    echo "Current token scopes:"
    echo "$scopes" | while read -r scope; do
        echo "  - $scope"
    done
fi

echo ""
echo "Required scopes for issue creation:"
echo "  - repo (full access to public and private repos)"
echo "  OR"
echo "  - public_repo (for public repositories only)"
echo ""

# Check if we have the required scope
if echo "$scopes" | grep -qE "(^repo$|^public_repo$)"; then
    echo "✅ Token has required scope for issue creation"
else
    echo "❌ Token is MISSING required scope for issue creation"
    echo ""
    echo "TO FIX THIS:"
    echo "1. Create a new token at: https://github.com/settings/tokens/new"
    echo "2. Select the 'repo' scope (includes all sub-scopes)"
    echo "3. Run: gh auth login"
    echo "4. Choose 'Paste an authentication token'"
    echo "5. Paste your new token"
fi

echo ""
echo "Current authentication method:"
if [ -n "$GITHUB_TOKEN" ]; then
    echo "  Using GITHUB_TOKEN environment variable"
    echo "  Token starts with: $(echo $GITHUB_TOKEN | head -c 20)..."
else
    echo "  Using gh CLI stored credentials"
fi