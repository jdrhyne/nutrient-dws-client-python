# Enhancement: Selective Annotation Flattening

## Summary
Enhance `flatten_annotations()` to support selective flattening by annotation IDs, as supported by the OpenAPI FlattenAction.

## Current Behavior
- Flattens all annotations and form fields
- No selective control

## Proposed Enhancement
```python
def flatten_annotations(
    self,
    input_file: FileInput,
    output_path: Optional[str] = None,
    annotation_ids: Optional[List[Union[str, int]]] = None,  # New parameter
) -> Optional[bytes]:
```

## Benefits
- Preserve specific annotations while flattening others
- More granular control over document processing
- Better support for complex form workflows
- Backward compatible (None = flatten all)

## Implementation Details
- Modify BuildAction to include `annotationIds` when provided
- Support both string and integer IDs
- Handle empty list (flatten none) vs None (flatten all)
- Update parameter documentation

## Testing Requirements
- [ ] Test with None (flatten all - current behavior)
- [ ] Test with specific annotation IDs
- [ ] Test with mix of valid and invalid IDs
- [ ] Test with empty list
- [ ] Test with different annotation types

## OpenAPI Reference
- BuildAction type: `flatten`
- Parameter: `annotationIds` (optional array of string/integer)
- Behavior: If not specified, flattens all annotations

## Priority
🔵 Priority 1 - Enhancement to existing method

## Labels
- enhancement
- annotations
- openapi-compliance
- backward-compatible