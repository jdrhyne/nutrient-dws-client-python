# Feature: Batch Processing Method

## Summary
Implement `batch_process()` for efficient processing of multiple files with the same operations.

## Proposed Implementation
```python
def batch_process(
    self,
    input_files: List[FileInput],
    operations: List[Dict[str, Any]],  # List of operations to apply
    output_dir: Optional[str] = None,
    output_format: str = "{name}_{index}{ext}",  # Naming pattern
    parallel: bool = True,
    max_workers: int = 4,
    continue_on_error: bool = True,
    progress_callback: Optional[Callable[[int, int], None]] = None,
) -> BatchResult:
```

## Benefits
- Process hundreds of files efficiently
- Parallel processing for performance
- Consistent operations across files
- Progress tracking and reporting
- Error recovery and partial results
- Memory-efficient streaming

## Implementation Details
- Client-side enhancement (not in OpenAPI)
- Use ThreadPoolExecutor for parallel processing
- Implement retry logic for transient failures
- Stream results to avoid memory issues
- Provide detailed error reporting

## BatchResult Structure
```python
@dataclass
class BatchResult:
    successful: List[Tuple[str, Union[bytes, str]]]  # (input_file, output)
    failed: List[Tuple[str, Exception]]  # (input_file, error)
    total_processed: int
    processing_time: float
    
    @property
    def success_rate(self) -> float:
        return len(self.successful) / self.total_processed * 100
```

## Testing Requirements
- [ ] Test sequential processing
- [ ] Test parallel processing
- [ ] Test error handling and recovery
- [ ] Test progress callback
- [ ] Test memory usage with large batches
- [ ] Test interruption and resume
- [ ] Test various operation combinations

## Use Case Example
```python
# Add watermark to all PDFs in directory
files = glob.glob("documents/*.pdf")
result = client.batch_process(
    input_files=files,
    operations=[
        {"method": "watermark_pdf", "params": {"text": "CONFIDENTIAL"}}
    ],
    output_dir="watermarked/",
    parallel=True,
    max_workers=8
)

print(f"Processed {result.total_processed} files")
print(f"Success rate: {result.success_rate}%")

# OCR and flatten multiple documents
operations = [
    {"method": "ocr_pdf", "params": {"language": "english"}},
    {"method": "flatten_annotations", "params": {}}
]

def progress_update(current, total):
    print(f"Processing {current}/{total}...")

result = client.batch_process(
    input_files=["scan1.pdf", "scan2.pdf", "scan3.pdf"],
    operations=operations,
    output_dir="processed/",
    progress_callback=progress_update
)

# Complex workflow with error handling
result = client.batch_process(
    input_files=large_file_list,
    operations=[
        {"method": "rotate_pages", "params": {"degrees": 90, "page_indexes": [0]}},
        {"method": "ocr_pdf", "params": {"language": ["english", "spanish"]}},
        {"method": "convert_to_pdfa", "params": {"conformance": "pdfa-2b"}}
    ],
    continue_on_error=True,  # Don't stop on individual failures
    output_format="processed_{name}_{index}{ext}"
)

# Review failures
for file, error in result.failed:
    print(f"Failed to process {file}: {error}")
```

## Operation Format
```python
{
    "method": "method_name",  # Direct API method name
    "params": {               # Method parameters
        "param1": value1,
        "param2": value2
    }
}
```

## Performance Considerations
- Default 4 workers balances speed and API limits
- Automatic retry with exponential backoff
- Memory streaming for large files
- Progress callback doesn't impact performance

## Error Handling
- Individual file failures don't stop batch
- Detailed error information per file
- Automatic retry for transient errors
- Optional stop-on-error mode

## Priority
🟠 Priority 4 - Advanced feature

## Labels
- feature
- performance
- batch-processing
- client-enhancement