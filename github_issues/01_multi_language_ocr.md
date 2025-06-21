# Enhancement: Multi-Language OCR Support

## Summary
Enhance the `ocr_pdf()` method to support multiple languages simultaneously, as supported by the OpenAPI specification.

## Current Behavior
- `ocr_pdf()` accepts only a single language string
- Limited to one language per document

## Proposed Enhancement
```python
def ocr_pdf(
    self,
    input_file: FileInput,
    output_path: Optional[str] = None,
    language: Union[str, List[str]] = "english",  # Now accepts list
    enable_structure: bool = False,  # New parameter
) -> Optional[bytes]:
```

## Benefits
- Process multi-lingual documents accurately
- Better OCR accuracy with proper language hints
- Optional structured text extraction
- Backward compatible with existing single-language usage

## Implementation Details
- Modify `_map_tool_to_action()` in builder.py to handle language arrays
- Update parameter validation to accept both string and list
- Add `enable_structure` parameter for structured output
- Extend language mapping to support all 30+ OpenAPI languages

## Testing Requirements
- [ ] Test single language string (backward compatibility)
- [ ] Test multiple languages as list
- [ ] Test structured output option
- [ ] Test all supported language codes
- [ ] Update integration tests

## OpenAPI Reference
- BuildAction type: `ocr`
- Parameter: `language` - can be single OcrLanguage or array
- Supports: english, spanish, french, german, italian, portuguese, chinese, japanese, korean, russian, arabic, hindi, and more

## Priority
🔵 Priority 1 - Enhancement to existing method

## Labels
- enhancement
- ocr
- openapi-compliance
- backward-compatible