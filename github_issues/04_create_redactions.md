# Feature: Create Redactions Method

## Summary
Implement `create_redactions()` method to programmatically create redaction annotations using text search, regex patterns, or presets.

## Proposed Implementation
```python
def create_redactions(
    self,
    input_file: FileInput,
    output_path: Optional[str] = None,
    strategy: Literal["text", "regex", "preset"] = "text",
    search_text: Optional[str] = None,  # For text strategy
    regex_pattern: Optional[str] = None,  # For regex strategy
    preset_type: Optional[str] = None,  # For preset strategy
    case_sensitive: bool = False,
    whole_words_only: bool = False,
    # Redaction appearance
    fill_color: Optional[str] = "#000000",
    outline_color: Optional[str] = "#000000",
    overlay_text: Optional[str] = None,
) -> Optional[bytes]:
```

## Benefits
- Automated redaction creation for compliance workflows
- Multiple search strategies (text, regex, presets)
- Customizable redaction appearance
- Preview redactions before permanently applying
- Works with existing `apply_redactions()` method

## Implementation Details
- Use BuildAction type: `createRedactions`
- Support three strategies:
  - `text`: Simple text search
  - `regex`: Regular expression patterns
  - `preset`: Common patterns (SSN, email, phone, etc.)
- Include appearance customization options
- Return PDF with redaction annotations (not yet applied)

## Testing Requirements
- [ ] Test text search strategy
- [ ] Test regex patterns (email, SSN, phone)
- [ ] Test preset types
- [ ] Test case sensitivity options
- [ ] Test appearance customization
- [ ] Integration test with apply_redactions()

## OpenAPI Reference
- BuildAction type: `createRedactions`
- Strategies: text, regex, preset
- Strategy options vary by type
- Includes content appearance configuration

## Use Case Example
```python
# Create redactions for all SSNs
pdf_with_redactions = client.create_redactions(
    "document.pdf",
    strategy="regex",
    regex_pattern=r"\b\d{3}-\d{2}-\d{4}\b",
    overlay_text="[REDACTED]"
)

# Review and then apply
final_pdf = client.apply_redactions(pdf_with_redactions)
```

## Priority
🟢 Priority 2 - Core missing method

## Labels
- feature
- redaction
- security
- openapi-compliance