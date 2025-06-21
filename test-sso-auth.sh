#!/bin/bash
# Test script to verify SSO authorization

echo "Testing SSO authorization for PSPDFKit..."
echo ""

# Test 1: Check if we can see PSPDFKit in authorized orgs
echo "1. Checking organization membership:"
gh api user/orgs --jq '.[] | select(.login=="PSPDFKit") | .login' || echo "   ❌ PSPDFKit not found in authorized orgs"
echo ""

# Test 2: Try to access the repo
echo "2. Testing repository access:"
gh api repos/PSPDFKit/nutrient-dws-client-python --jq '.full_name' && echo "   ✅ Repository access confirmed" || echo "   ❌ Cannot access repository"
echo ""

# Test 3: Check if we can view PR
echo "3. Testing PR access:"
gh pr view 5 --repo PSPDFKit/nutrient-dws-client-python --json number --jq '.number' && echo "   ✅ Can view PR #5" || echo "   ❌ Cannot view PR"
echo ""

# Test 4: Final test - try to push
echo "4. Testing push access:"
echo "   Run 'git push origin add-integration-tests-ci' to test push access"