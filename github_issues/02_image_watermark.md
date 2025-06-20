# Enhancement: Image Watermark Support

## Summary
Extend `watermark_pdf()` to support image watermarks in addition to text watermarks, as specified in the OpenAPI ImageWatermarkAction.

## Current Behavior
- Only supports text watermarks
- No image watermark capability

## Proposed Enhancement
```python
def watermark_pdf(
    self,
    input_file: FileInput,
    output_path: Optional[str] = None,
    # Text watermark parameters (existing)
    text: Optional[str] = None,
    # Image watermark parameters (new)
    image_file: Optional[FileInput] = None,
    image_url: Optional[str] = None,
    # Common parameters
    width: int = 200,
    height: int = 100,
    opacity: float = 1.0,
    position: str = "center",
    rotation: int = 0,  # New parameter
) -> Optional[bytes]:
```

## Benefits
- Logo and branding watermarks
- Complex visual watermarks
- Rotation support for both text and image watermarks
- Maintains backward compatibility

## Implementation Details
- Extend `_map_tool_to_action()` to handle image watermarks
- Add validation for image_file/image_url parameters
- Support rotation parameter for all watermark types
- Handle image file upload in multipart request

## Testing Requirements
- [ ] Test with image file input (PNG, JPEG)
- [ ] Test with image URL
- [ ] Test rotation parameter (0, 90, 180, 270)
- [ ] Test opacity with images
- [ ] Test all position options
- [ ] Verify backward compatibility with text watermarks

## OpenAPI Reference
- BuildAction type: `watermark`
- Subtypes: TextWatermarkAction, ImageWatermarkAction
- Image parameter: `image` (FileHandle)
- New parameter: `rotation`

## Priority
🔵 Priority 1 - Enhancement to existing method

## Labels
- enhancement
- watermark
- openapi-compliance
- backward-compatible