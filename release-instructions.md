# Manual Release Creation Instructions

Since the GitHub token doesn't have release permissions, please create the release manually:

## Steps:

1. **Go to Releases Page**: https://github.com/PSPDFKit/nutrient-dws-client-python/releases

2. **Click "Create a new release"**

3. **Fill out the form**:
   - **Tag**: `v1.0.1` (already pushed)
   - **Title**: `v1.0.1 - Critical Documentation Fix and Testing Improvements`
   - **Description**: Copy the content from `release-notes-v1.0.1.md`

4. **Set as Latest Release**: ✅ Check this box

5. **Click "Publish release"**

## Release Summary

This v1.0.1 release:
- ✅ Fixes critical documentation bug (TimeoutError → NutrientTimeoutError)
- ✅ Adds 31 comprehensive unit tests
- ✅ Adds integration test framework
- ✅ Resolves all CI/testing stability issues
- ✅ Version bumped to 1.0.1 in all files
- ✅ CHANGELOG.md updated
- ✅ Git tag created and pushed

The tag `v1.0.1` is already available in the repository, so GitHub will automatically detect it when creating the release.

## Verification

After creating the release:
1. Check that it shows as "Latest" on the releases page
2. Verify the tag points to the correct commit (6c09942)
3. Confirm the release notes render correctly