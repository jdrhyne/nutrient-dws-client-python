# Changelog

All notable changes to the nutrient-dws Python client library will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-06-20

### Fixed

#### Critical Bug Fixes
- **Documentation Error**: Fixed README.md to correctly use `NutrientTimeoutError` instead of `TimeoutError` in import examples and exception handling
- **Exception Naming**: Resolved inconsistency where code exported `NutrientTimeoutError` but documentation referenced `TimeoutError`

#### CI/Testing Improvements
- **Test Collection**: Fixed pytest collection failures in CI environments with proper setuptools configuration
- **TOML Configuration**: Removed duplicate setuptools configuration that caused parsing errors during installation
- **Type Checking**: Resolved mypy errors across all modules with proper type annotations
- **Linting**: Fixed all ruff linting issues (W292, W293, RUF034, SIM115, B017, E501)
- **Test Dependencies**: Simplified test suite to remove problematic mock dependencies

### Added

#### Testing Infrastructure
- **Comprehensive Unit Tests**: Added 31 unit tests covering all major components:
  - HTTP client tests (5 tests)
  - File handler tests (5 tests) 
  - Builder API tests (5 tests)
  - Exception handling tests
  - Client functionality tests
- **Integration Test Framework**: Added CI workflow for integration testing against live API
  - Runs on all Python versions (3.8-3.12)
  - Secure API key handling via GitHub secrets
  - Automatic config cleanup after tests
  - Basic smoke test for API connectivity

#### Development Quality
- **Repository Setup**: Enhanced GitHub repository with proper badges, issue templates, and documentation
- **CI Pipeline**: Improved CI workflow with better error handling and debugging capabilities

### Changed

#### Internal Improvements
- **Error Handling**: Improved error messages and exception context throughout the codebase
- **Code Quality**: Applied consistent formatting and linting across all files
- **Type Safety**: Enhanced type annotations for better IDE support and static analysis

### Technical Details
- All tests now pass on Python 3.8-3.12
- CI pipeline is stable and reliable
- Integration tests provide continuous API validation
- Code coverage and quality metrics are consistently tracked

## [1.0.0] - 2025-06-17

### Added

#### Core Features
- **NutrientClient**: Main client class with support for both Direct API and Builder API patterns
- **Direct API Methods**: Convenient methods for single operations:
  - `convert_to_pdf()` - Convert Office documents to PDF (uses implicit conversion)
  - `flatten_annotations()` - Flatten PDF annotations and form fields
  - `rotate_pages()` - Rotate specific or all pages
  - `ocr_pdf()` - Apply OCR to make PDFs searchable
  - `watermark_pdf()` - Add text or image watermarks
  - `apply_redactions()` - Apply existing redaction annotations
  - `merge_pdfs()` - Merge multiple PDFs and Office documents

- **Builder API**: Fluent interface for chaining multiple operations:
  ```python
  client.build(input_file="document.docx") \
      .add_step("rotate-pages", {"degrees": 90}) \
      .add_step("ocr-pdf", {"language": "english"}) \
      .execute(output_path="processed.pdf")
  ```

#### Infrastructure
- **HTTP Client**: 
  - Connection pooling for performance
  - Automatic retry logic with exponential backoff
  - Bearer token authentication
  - Comprehensive error handling

- **File Handling**:
  - Support for multiple input types (paths, Path objects, bytes, file-like objects)
  - Automatic streaming for large files (>10MB)
  - Memory-efficient processing

- **Exception Hierarchy**:
  - `NutrientError` - Base exception
  - `AuthenticationError` - API key issues
  - `APIError` - General API errors with status codes
  - `ValidationError` - Request validation failures
  - `TimeoutError` - Request timeouts
  - `FileProcessingError` - File operation failures

#### Development Tools
- **Testing**: 82 unit tests with 92.46% code coverage
- **Type Safety**: Full mypy type checking support
- **Linting**: Configured with ruff
- **Pre-commit Hooks**: Automated code quality checks
- **CI/CD**: GitHub Actions for testing, linting, and releases
- **Documentation**: Comprehensive README with examples

### Changed
- Package name updated from `nutrient` to `nutrient-dws` for PyPI
- Source directory renamed from `src/nutrient` to `src/nutrient_dws`
- API endpoint updated to https://api.pspdfkit.com
- Authentication changed from X-Api-Key header to Bearer token

### Discovered
- **Implicit Document Conversion**: The API automatically converts Office documents (DOCX, XLSX, PPTX) to PDF when processing, eliminating the need for explicit conversion steps

### Fixed
- Watermark operation now correctly requires width/height parameters
- OCR language codes properly mapped (e.g., "en" → "english")
- All API operations updated to use the Build API endpoint
- Type annotations corrected throughout the codebase

### Security
- API keys are never logged or exposed
- Support for environment variable configuration
- Secure handling of authentication tokens

[1.0.0]: https://github.com/jdrhyne/nutrient-dws-client-python/releases/tag/v1.0.0