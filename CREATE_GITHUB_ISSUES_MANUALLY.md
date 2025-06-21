# Manual GitHub Issue Creation Guide

Since automatic issue creation requires PSPDFKit organization permissions, please follow these steps to manually create the issues:

## Prerequisites
1. Ensure you have write access to the PSPDFKit/nutrient-dws-client-python repository
2. Or request someone with appropriate permissions to create these issues

## Issue Templates Location
All issue templates are in the `github_issues/` directory with the following structure:
- `00_roadmap.md` - Overall enhancement roadmap (create this first)
- `01_multi_language_ocr.md` - Multi-language OCR support
- `02_image_watermark.md` - Image watermark support
- `03_selective_flattening.md` - Selective annotation flattening
- `04_create_redactions.md` - Create redactions method
- `05_import_annotations.md` - Import annotations feature
- `06_extract_pages.md` - Extract page range method
- `07_convert_to_pdfa.md` - PDF/A conversion
- `08_convert_to_images.md` - Image extraction
- `09_extract_content_json.md` - JSON content extraction
- `10_convert_to_office.md` - Office format conversion
- `11_ai_redaction.md` - AI-powered redaction
- `12_digital_signature.md` - Digital signature support
- `13_batch_processing.md` - Batch processing method

## Steps to Create Issues

### Option 1: Using GitHub Web Interface
1. Go to https://github.com/PSPDFKit/nutrient-dws-client-python/issues
2. Click "New issue"
3. For each template file:
   - Copy the title from the first line (after the #)
   - Copy the entire content into the issue body
   - Add the labels listed at the bottom of each template
   - Click "Submit new issue"

### Option 2: Using GitHub CLI (if you have permissions)
If you get appropriate permissions, you can run:

```bash
cd /Users/admin/Projects/nutrient-dws-client-python

# Create the roadmap issue first
gh issue create \
  --title "Enhancement Roadmap: Comprehensive Feature Plan" \
  --body-file github_issues/00_roadmap.md \
  --label "roadmap,enhancement,documentation"

# Then create individual feature issues
for i in {01..13}; do
  title=$(head -n 1 github_issues/${i}_*.md | sed 's/# //')
  labels=$(tail -n 1 github_issues/${i}_*.md | sed 's/- //')
  gh issue create \
    --title "$title" \
    --body-file github_issues/${i}_*.md \
    --label "$labels"
done
```

### Option 3: Request Organization Access
1. Contact the PSPDFKit organization administrators
2. Request contributor access to the nutrient-dws-client-python repository
3. Once granted, use the GitHub CLI commands above

## Issue Organization

### Priority Labels
- 🔵 `priority-1`: Enhanced existing methods
- 🟢 `priority-2`: Core missing methods
- 🟡 `priority-3`: Format conversion methods
- 🟠 `priority-4`: Advanced features

### Implementation Phases
- **Phase 1** (1-2 months): Issues 01, 02, 04
- **Phase 2** (2-3 months): Issues 07, 08, 05
- **Phase 3** (3-4 months): Issues 09, 10, 11
- **Phase 4** (4-6 months): Issues 12, 13

## Notes
- Create the roadmap issue (00) first as it provides context for all others
- Each issue is self-contained with implementation details, testing requirements, and examples
- Issues are numbered in suggested implementation order within their priority groups
- All issues follow the same format for consistency