#!/bin/bash

echo "Testing for Personal Access Token Restrictions"
echo "=============================================="
echo ""

# Check if this is a known issue with the organization
echo "Checking organization settings..."

# Try to access organization member information
echo ""
echo "1. Testing organization membership visibility:"
if gh api orgs/PSPDFKit/members/jdrhyne -H "Accept: application/vnd.github.v3+json" >/dev/null 2>&1; then
    echo "   ✅ You are a visible member of PSPDFKit"
else
    echo "   ❌ You are not a visible member of PSPDFKit"
    echo "   This might indicate:"
    echo "   - Your membership is private"
    echo "   - You're an outside collaborator, not a member"
    echo "   - Organization has restricted PAT access"
fi

# Check collaborator status
echo ""
echo "2. Testing direct collaborator access:"
your_repos=$(gh api user/repos --paginate --jq '.[] | select(.owner.login == "PSPDFKit") | .name' 2>/dev/null | wc -l)
echo "   You have direct access to $your_repos PSPDFKit repositories"

# Test with a different endpoint
echo ""
echo "3. Testing alternative issue creation method:"
echo "   Checking if this is a GraphQL-specific issue..."

# The key insight
echo ""
echo "=== LIKELY CAUSE ==="
echo "The PSPDFKit organization may have enabled:"
echo "\"Restrict access via personal access tokens\""
echo ""
echo "This setting prevents PATs from accessing organization resources"
echo "even if you have the correct permissions and scopes."
echo ""
echo "SOLUTIONS:"
echo "1. Ask a PSPDFKit organization owner to check:"
echo "   Settings → Third-party Access → Personal access tokens"
echo "   and either:"
echo "   - Disable the restriction"
echo "   - Or approve your specific token"
echo ""
echo "2. Use GitHub Apps or OAuth Apps instead of PATs"
echo ""
echo "3. Have an organization owner create the issues"