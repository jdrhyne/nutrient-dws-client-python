#!/bin/bash
# Script to set up the new fine-grained token

echo "Setting up new GitHub token..."
echo ""
echo "Please paste your new fine-grained token when prompted."
echo "The token should start with 'github_pat_' or similar."
echo ""
read -s -p "Enter your new GitHub token: " NEW_TOKEN
echo ""

# Export the new token
export GITHUB_TOKEN="$NEW_TOKEN"

# Update git remote to use the new token
echo "Updating git remote configuration..."
git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/PSPDFKit/nutrient-dws-client-python.git

# Configure gh CLI to use the new token
echo "Configuring GitHub CLI..."
echo $GITHUB_TOKEN | gh auth login --with-token

# Test the new token
echo ""
echo "Testing new token..."
echo "1. Checking API access:"
gh api user --jq '.login' && echo "✅ API access confirmed" || echo "❌ API access failed"

echo ""
echo "2. Checking repository access:"
gh api repos/PSPDFKit/nutrient-dws-client-python --jq '.full_name' && echo "✅ Repository access confirmed" || echo "❌ Repository access failed"

echo ""
echo "3. Checking current branch:"
git branch --show-current

echo ""
echo "Token setup complete! You can now try: git push origin add-integration-tests-ci"