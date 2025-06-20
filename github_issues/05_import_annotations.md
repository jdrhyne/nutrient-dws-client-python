# Feature: Import Annotations Method

## Summary
Implement `import_annotations()` to import annotations from Instant JSON or XFDF formats into PDFs.

## Proposed Implementation
```python
def import_annotations(
    self,
    input_file: FileInput,
    annotation_file: FileInput,
    output_path: Optional[str] = None,
    format: Literal["instant", "xfdf"] = "instant",
    merge_strategy: Literal["overwrite", "append"] = "append",
) -> Optional[bytes]:
```

## Benefits
- Enable annotation portability between systems
- Support collaborative annotation workflows
- Backup and restore annotations
- Integration with external annotation tools
- Support both Nutrient Instant JSON and standard XFDF

## Implementation Details
- Use BuildAction types: `applyInstantJson` or `applyXfdf`
- Handle annotation file as additional multipart upload
- Support merge strategies for existing annotations
- Auto-detect format if not specified (by file extension)

## Testing Requirements
- [ ] Test Instant JSON import
- [ ] Test XFDF import
- [ ] Test merge strategies (append/overwrite)
- [ ] Test with empty annotation files
- [ ] Test format auto-detection
- [ ] Test error handling for invalid formats

## OpenAPI Reference
- BuildAction types: `applyInstantJson`, `applyXfdf`
- File parameter required for annotation data
- Both formats fully supported by API

## Use Case Example
```python
# Import annotations from another system
client.import_annotations(
    "document.pdf",
    "annotations.json",
    format="instant",
    merge_strategy="append"
)

# Restore backed-up annotations
client.import_annotations(
    "document.pdf", 
    "backup_annotations.xfdf",
    format="xfdf",
    merge_strategy="overwrite"
)
```

## Priority
🟢 Priority 2 - Core missing method

## Labels
- feature
- annotations
- collaboration
- openapi-compliance