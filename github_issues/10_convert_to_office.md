# Feature: Convert to Office Formats Method

## Summary
Implement `convert_to_office()` to export PDFs to Microsoft Office formats (DOCX, XLSX, PPTX).

## Proposed Implementation
```python
def convert_to_office(
    self,
    input_file: FileInput,
    output_path: Optional[str] = None,
    format: Literal["docx", "xlsx", "pptx"] = "docx",
    ocr_language: Optional[Union[str, List[str]]] = None,  # Auto-OCR if needed
) -> Optional[bytes]:
```

## Benefits
- Edit PDFs in familiar Office applications
- Preserve formatting and layout where possible
- Automatic OCR for scanned documents
- Workflow integration with Office 365
- Accessibility improvements

## Implementation Details
- Use Build API with output type: `docx`, `xlsx`, or `pptx`
- Automatic format detection based on content
- OCR integration for scanned PDFs
- Handle complex layouts gracefully

## Testing Requirements
- [ ] Test DOCX conversion (text documents)
- [ ] Test XLSX conversion (tables/data)
- [ ] Test PPTX conversion (presentations)
- [ ] Test with scanned documents (OCR)
- [ ] Test formatting preservation
- [ ] Test with complex layouts
- [ ] Test with forms and tables

## OpenAPI Reference
- Output types: `docx`, `xlsx`, `pptx`
- Part of BuildOutput options
- Supports OCR language parameter

## Use Case Example
```python
# Convert PDF to Word for editing
word_doc = client.convert_to_office(
    "report.pdf",
    format="docx",
    output_path="report.docx"
)

# Convert scanned document with OCR
editable_doc = client.convert_to_office(
    "scanned_contract.pdf",
    format="docx",
    ocr_language=["english", "spanish"]
)

# Convert data PDF to Excel
spreadsheet = client.convert_to_office(
    "financial_data.pdf",
    format="xlsx",
    output_path="data.xlsx"
)

# Convert to PowerPoint
presentation = client.convert_to_office(
    "slides.pdf",
    format="pptx"
)
```

## Format Selection Guide
- **DOCX**: Text-heavy documents, reports, contracts
- **XLSX**: Data tables, financial reports, lists
- **PPTX**: Presentations, slide decks

## Known Limitations
- Complex layouts may not convert perfectly
- Some PDF features have no Office equivalent
- Font substitution may occur
- Interactive elements may be lost

## Priority
🟡 Priority 3 - Format conversion method

## Labels
- feature
- conversion
- office
- docx
- xlsx
- pptx
- openapi-compliance