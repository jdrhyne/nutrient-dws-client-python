# Feature: Extract Page Range Method

## Summary
Implement `extract_pages()` as a simpler alternative to `split_pdf()` for extracting a continuous range of pages.

## Proposed Implementation
```python
def extract_pages(
    self,
    input_file: FileInput,
    start_page: int,
    end_page: Optional[int] = None,  # None means to end
    output_path: Optional[str] = None,
) -> Optional[bytes]:
```

## Benefits
- Simpler API than split_pdf for common use case
- More intuitive for single range extraction
- Clear intent and usage
- Memory efficient for large documents

## Implementation Details
- Use Build API with single FilePart and page range
- Support negative indexing (-1 for last page)
- Handle "to end" extraction with None
- Clear error messages for invalid ranges

## Testing Requirements
- [ ] Test single page extraction
- [ ] Test range extraction
- [ ] Test "to end" extraction (end_page=None)
- [ ] Test negative page indexes
- [ ] Test invalid ranges (start > end)
- [ ] Test out of bounds pages

## OpenAPI Reference
- Uses FilePart with `pages` parameter
- Page ranges use start/end format
- Build API with single part

## Use Case Example
```python
# Extract first 10 pages
first_chapter = client.extract_pages(
    "book.pdf",
    start_page=0,
    end_page=10
)

# Extract from page 50 to end
appendix = client.extract_pages(
    "book.pdf", 
    start_page=50
    # end_page=None means to end
)

# Extract single page
cover = client.extract_pages(
    "book.pdf",
    start_page=0,
    end_page=1
)
```

## Relationship to split_pdf
- `split_pdf`: Multiple ranges, multiple outputs
- `extract_pages`: Single range, single output
- This method is essentially `split_pdf` with a single range

## Priority
🟢 Priority 2 - Core missing method

## Labels
- feature
- pdf-manipulation
- pages
- openapi-compliance