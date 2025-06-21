# Fix GitHub Token Permissions for Issue Creation

## Current Problem
Your token can:
- ✅ Push to branches
- ✅ Read issues
- ❌ Create issues (missing scope)

## Quick Fix Options

### Option 1: Use Fine-grained Personal Access Token (Recommended)
1. Go to: https://github.com/settings/personal-access-tokens/new
2. Token name: `nutrient-dws-development`
3. Expiration: 90 days
4. Repository access: Selected repositories
   - Add: `PSPDFKit/nutrient-dws-client-python`
5. Permissions:
   - **Repository permissions:**
     - Contents: Read/Write
     - Issues: Read/Write
     - Pull requests: Read/Write
     - Actions: Read (optional)
     - Metadata: Read (required)
6. Click "Generate token"
7. Copy the token (starts with `github_pat_`)

### Option 2: Use Classic Personal Access Token
1. Go to: https://github.com/settings/tokens/new
2. Note: `nutrient-dws-development`
3. Expiration: 90 days
4. Select scopes:
   - ✅ `repo` (Full control - includes private repos)
   - OR just ✅ `public_repo` (if the repo is public)
5. Generate and copy token

## Apply the New Token

### Method 1: GitHub CLI (Recommended)
```bash
# Re-authenticate with new token
gh auth login

# When prompted:
# - Choose: GitHub.com
# - Choose: Paste an authentication token
# - Paste your new token
```

### Method 2: Environment Variable
```bash
# In your terminal
export GITHUB_TOKEN='your_new_token_here'

# Or add to your shell profile (~/.bashrc, ~/.zshrc, etc.)
echo "export GITHUB_TOKEN='your_new_token_here'" >> ~/.zshrc
source ~/.zshrc
```

## Verify Token Works
```bash
# Test creating a simple issue
gh issue create --repo PSPDFKit/nutrient-dws-client-python \
  --title "Test Issue (Delete Me)" \
  --body "Testing token permissions"

# If successful, close it:
gh issue close <issue-number> --repo PSPDFKit/nutrient-dws-client-python
```

## Security Notes
- Never commit tokens to git
- Use environment variables or gh auth
- Rotate tokens regularly
- Use minimum required scopes