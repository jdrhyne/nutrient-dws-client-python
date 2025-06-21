# SSO Authorization Check

## Method 1: Check Current Token Page
1. Go to: https://github.com/settings/tokens
2. Look for your current token
3. Screenshot what you see - there should be SSO-related text somewhere

## Method 2: Try Manual SSO Auth
1. First, visit: https://github.com/PSPDFKit
2. Make sure you can see the organization page
3. Then try this direct link: https://github.com/settings/connections/applications

## Method 3: Check via Organization Settings (As Admin)
1. Go to: https://github.com/orgs/PSPDFKit/settings/security
2. Look for "SAML single sign-on" section
3. Check if it shows your SSO status

## Method 4: Revoke and Recreate Token
Sometimes the easiest solution:
1. Go to: https://github.com/settings/tokens
2. Delete/revoke your current token
3. Create a new token
4. **BEFORE COPYING IT**, look for SSO options on the creation page
5. There should be a section about "Authorize organizations" or similar

## What to Look For:
- Yellow/amber warning banners about SSO
- "Configure SSO" or "Authorize" buttons
- Organization names with lock icons
- Any mention of SAML or SSO near your token