#!/bin/bash
# Script to switch to your fine-grained token

echo "Switching to fine-grained token..."
echo ""
echo "Please paste your FINE-GRAINED token (the one you just created with PR permissions)"
echo ""
read -s -p "Enter your fine-grained token: " NEW_TOKEN
echo ""
echo ""

# First, let's verify it's different from current token
CURRENT_TOKEN_PREFIX="${GITHUB_TOKEN:0:50}..."
NEW_TOKEN_PREFIX="${NEW_TOKEN:0:50}..."

echo "Current token: $CURRENT_TOKEN_PREFIX"
echo "New token:     $NEW_TOKEN_PREFIX"
echo ""

if [ "$CURRENT_TOKEN_PREFIX" == "$NEW_TOKEN_PREFIX" ]; then
    echo "⚠️  This appears to be the same token. Make sure you're pasting the fine-grained token."
    exit 1
fi

# Export the new token
export GITHUB_TOKEN="$NEW_TOKEN"
echo "✅ Exported new token to GITHUB_TOKEN"

# Update git remote
echo "Updating git remote..."
git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/PSPDFKit/nutrient-dws-client-python.git

# Re-authenticate GitHub CLI
echo "Re-authenticating GitHub CLI..."
echo $GITHUB_TOKEN | gh auth login --with-token

# Test the new token
echo ""
echo "Testing new token..."
gh api user --jq '.login' && echo "✅ API access works" || echo "❌ API access failed"

# Test PR comment access
echo ""
echo "Testing PR comment access..."
gh pr comment 5 --repo PSPDFKit/nutrient-dws-client-python --body "Test comment from fine-grained token" && echo "✅ PR comments work!" || echo "❌ PR comments failed"

echo ""
echo "Token switch complete!"