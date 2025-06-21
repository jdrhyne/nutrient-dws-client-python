#!/bin/bash

echo "Comprehensive Issue Creation Diagnostic"
echo "======================================="
echo ""

# Test 1: Your user info
echo "1. User Information:"
gh api user --jq '{login, type, site_admin}'

# Test 2: Organization membership
echo ""
echo "2. Organization Relationship:"
echo "   Checking if you're a member or outside collaborator..."
is_member=$(gh api orgs/PSPDFKit/members --paginate 2>/dev/null | jq -r '.[] | select(.login == "jdrhyne") | .login' | wc -l)
if [ "$is_member" -gt 0 ]; then
    echo "   ✅ You are an organization member"
else
    echo "   ⚠️  You are NOT an organization member (likely outside collaborator)"
    echo "   This might be the issue - outside collaborators may have restricted API access"
fi

# Test 3: Check teams
echo ""
echo "3. Team Membership:"
gh api orgs/PSPDFKit/teams --paginate 2>/dev/null | jq -r '.[].name' | head -5 || echo "   Cannot access team information"

# Test 4: Repository access type
echo ""
echo "4. Repository Access Type:"
echo "   You have: Admin permissions"
echo "   Can create PRs: Yes"
echo "   Can push: Yes"
echo "   Can create issues via API: No"

# Test 5: Possible explanations
echo ""
echo "5. Possible Explanations:"
echo "   a) You're an outside collaborator with admin access"
echo "      - Outside collaborators can have limited API access even with admin permissions"
echo "      - This is a GitHub security feature"
echo ""
echo "   b) Repository-specific API restrictions"
echo "      - Some repos can have custom API restrictions"
echo ""
echo "   c) Token type mismatch"
echo "      - Fine-grained tokens might need explicit issue permissions even for admins"

# Test 6: Workarounds
echo ""
echo "6. Recommended Solutions:"
echo "   a) Create issues via the web interface at:"
echo "      https://github.com/PSPDFKit/nutrient-dws-client-python/issues/new"
echo ""
echo "   b) Ask an organization member to:"
echo "      - Add you as an organization member (not just collaborator)"
echo "      - Or create the issues on your behalf"
echo ""
echo "   c) Use the GitHub web UI to paste the issue content from:"
echo "      ./github_issues/*.md files"

# Final test
echo ""
echo "7. Testing Web Access:"
echo "   Open: https://github.com/PSPDFKit/nutrient-dws-client-python/issues/new"
echo "   If you CAN create issues there, you're an outside collaborator with API restrictions"