# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2024-06-20

### Added
- 🎉 First stable release on PyPI
- Comprehensive test suite with 94% coverage (154 tests)
- Full support for Python 3.8 through 3.12
- Type hints for all public APIs
- PyPI package publication

### Fixed
- CI pipeline compatibility for all Python versions
- Package metadata format for older setuptools versions
- Type checking errors with mypy strict mode
- File handler edge cases with BytesIO objects

### Changed
- Improved error messages for better debugging
- Enhanced file handling with proper position restoration
- Updated coverage from 92% to 94%

## [1.0.0] - 2024-06-19

### Added
- Initial implementation of Direct API with 7 methods:
  - `convert_to_pdf` - Convert documents to PDF
  - `convert_from_pdf` - Convert PDFs to other formats
  - `ocr_pdf` - Perform OCR on PDFs
  - `watermark_pdf` - Add watermarks to PDFs
  - `flatten_annotations` - Flatten PDF annotations
  - `rotate_pages` - Rotate PDF pages
  - `merge_pdfs` - Merge multiple PDFs
- Builder API for complex document workflows
- Comprehensive error handling with custom exceptions
- Automatic retry logic with exponential backoff
- File streaming support for large documents
- Full type hints and py.typed marker
- Extensive documentation and examples
- MIT License

### Technical Details
- Built on `requests` library (only dependency)
- Supports file inputs as paths, bytes, or file-like objects
- Memory-efficient processing with streaming
- Connection pooling for better performance

[1.0.1]: https://github.com/PSPDFKit/nutrient-dws-client-python/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/PSPDFKit/nutrient-dws-client-python/releases/tag/v1.0.0