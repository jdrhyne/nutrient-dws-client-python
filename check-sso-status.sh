#!/bin/bash

echo "Checking SSO Status for PSPDFKit Organization"
echo "============================================="
echo ""

# Check if the token needs SSO authorization
response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -I https://api.github.com/repos/PSPDFKit/nutrient-dws-client-python 2>&1)

if echo "$response" | grep -q "X-GitHub-SSO:"; then
    sso_url=$(echo "$response" | grep "X-GitHub-SSO:" | sed 's/.*authorize?//')
    echo "❌ SSO Authorization Required!"
    echo ""
    echo "The PSPDFKit organization requires SAML SSO authorization."
    echo ""
    echo "To fix this:"
    echo "1. Go to: https://github.com/settings/tokens"
    echo "2. Find your current token"
    echo "3. Click 'Configure SSO' next to the token"
    echo "4. Authorize for 'PSPDFKit' organization"
    echo ""
    echo "Or visit this URL to authorize:"
    echo "https://github.com/orgs/PSPDFKit/sso?authorization_request=$(echo $sso_url | cut -d'=' -f2)"
else
    echo "✅ No SSO requirement detected in headers"
fi

echo ""
echo "Testing repository access..."
if gh api repos/PSPDFKit/nutrient-dws-client-python >/dev/null 2>&1; then
    echo "✅ Can read repository"
else
    echo "❌ Cannot read repository"
fi

echo ""
echo "Testing issue list access..."
if gh issue list --repo PSPDFKit/nutrient-dws-client-python --limit 1 >/dev/null 2>&1; then
    echo "✅ Can list issues"
else
    echo "❌ Cannot list issues"
fi

echo ""
echo "Testing push access..."
if git ls-remote origin >/dev/null 2>&1; then
    echo "✅ Can push to repository"
else
    echo "❌ Cannot push to repository"
fi

echo ""
echo "Most likely cause: SAML SSO authorization needed"
echo "Solution: Authorize your PAT for the PSPDFKit organization"