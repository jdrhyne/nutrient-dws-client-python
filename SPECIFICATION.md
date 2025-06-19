# Software Design Specification: Nutrient DWS Python Client
Version: 1.2
Date: December 19, 2024

## 1. Introduction
### 1.1. Project Overview
This document outlines the software design specification for a new Python client library for the Nutrient Document Web Services (DWS) API. The goal of this project is to create a high-quality, lightweight, and intuitive Python package that simplifies interaction with the Nutrient DWS API for developers.

The library will provide two primary modes of interaction:
- A **Direct API** for executing single, discrete document processing tasks (e.g., converting a single file, rotating a page).
- A **Builder API** that offers a fluent, chainable interface for composing and executing complex, multi-step document processing workflows, abstracting the `POST /build` endpoint of the Nutrient API.

The final product will be a distributable package suitable for publishing on PyPI, with comprehensive documentation. The design prioritizes ease of use, adherence to Python best practices, and clear documentation consumable by both humans and LLMs.

### 1.2. Scope
This specification covers the implemented Python client library:
- Client authentication and configuration
- Direct API methods for common document operations
- Builder API for multi-step workflows
- Comprehensive error handling with custom exceptions
- Optimized file input/output handling
- Standard Python package structure

Out of scope:
- Command-line interface (CLI)
- Asynchronous operations (all calls are synchronous)
- Non-Python implementations

### 1.3. References
- **Nutrient DWS OpenAPI Specification**: https://dashboard.nutrient.io/assets/specs/public@1.9.0-dfc6ec1c1d008be3dcb81a72be6346b5.yml
- **Nutrient DWS API Documentation**: https://www.nutrient.io/api/reference/public/
- **Nutrient DWS List of Tools**: https://www.nutrient.io/api/tools-overview/
- **Target API Endpoint**: https://api.pspdfkit.com

## 2. Goals and Objectives
- **Simplicity**: Clean, Pythonic interface abstracting HTTP requests, authentication, and file handling
- **Flexibility**: Direct API for single operations and Builder API for complex workflows
- **Lightweight**: Single external dependency on `requests` library
- **Performance**: Optimized file handling with streaming for large files (>10MB)
- **Distribution-Ready**: Standard Python package structure with `pyproject.toml`

## 3. High-Level Architecture
The library is architected around a central `NutrientClient` class, which is the main entry point for all interactions.

### 3.1. Core Components
**NutrientClient (The Main Client):**
- Handles initialization and configuration, including a configurable timeout for API calls.
- Manages the API key for authentication. All outgoing requests will include the `X-Api-Key` header.
- Contains static methods for the Direct API (e.g., `client.rotate_pages(...)`), which are derived from the OpenAPI specification.
- Acts as a factory for the Builder API via the `client.build()` method.

**Direct API (Static Methods):**
- A collection of methods attached directly to the `NutrientClient` object.
- Each method corresponds to a specific tool available in the OpenAPI specification (e.g., `ocr_pdf`, `rotate_pages`).
- These methods abstract the `POST /process/{tool}` endpoint. They handle file preparation, making the request, and returning the processed file.

**BuildAPIWrapper (Builder API):**
- A separate class, instantiated via `client.build()`.
- Implements the Builder design pattern with a fluent, chainable interface.
- The `execute()` method compiles the workflow into a `multipart/form-data` request for the `POST /build` endpoint, including a JSON part for actions and the necessary file parts.

### 3.2. Data Flow
**Direct API Call:**
1. User calls method like `client.rotate_pages(input_file='path/to/doc.pdf', degrees=90)`
2. Method internally uses Builder API with single step
3. File is processed via `/build` endpoint
4. Returns processed file bytes or saves to `output_path`

**Builder API Call:**
1. User chains operations: `client.build(input_file='doc.docx').add_step(tool='rotate-pages', options={'degrees': 90})`
2. `execute()` sends `multipart/form-data` request to `/build` endpoint
3. Returns processed file bytes or saves to `output_path`

## 4. API Design
### 4.1. Client Initialization
```python
from nutrient_dws import NutrientClient, AuthenticationError

# API key from parameter (takes precedence) or NUTRIENT_API_KEY env var
client = NutrientClient(api_key="YOUR_DWS_API_KEY", timeout=300)

# Context manager support
with NutrientClient() as client:
    result = client.convert_to_pdf("document.docx")
```

- **API Key**: Parameter takes precedence over `NUTRIENT_API_KEY` environment variable
- **Timeout**: Default 300 seconds, configurable per client
- **Error Handling**: `AuthenticationError` raised on first API call if key invalid

### 4.2. File Handling
**Input Types**:
- `str` or `Path` for local file paths
- `bytes` objects
- File-like objects (`io.IOBase`)

**Output Behavior**:
- Returns `bytes` by default
- Saves to `output_path` and returns `None` when path provided
- Large files (>10MB) use streaming to optimize memory usage

### 4.3. Direct API Design
Method names are snake_case versions of operations. Tool-specific parameters are keyword-only arguments.

**Example Usage:**
```python
# User Story: Convert a DOCX to PDF and rotate it.

# Step 1: Convert DOCX to PDF
pdf_bytes = client.convert_to_pdf(
    input_file="path/to/document.docx"
)

# Step 2: Rotate the newly created PDF from memory
client.rotate_pages(
    input_file=pdf_bytes,
    output_path="path/to/rotated_document.pdf",
    degrees=90  # keyword-only argument
)

print("File saved to path/to/rotated_document.pdf")
```

### 4.4. Builder API Design
Fluent interface for multi-step workflows with single API call:

- `client.build(input_file)`: Starts workflow
- `.add_step(tool, options=None)`: Adds processing step
- `.execute(output_path=None)`: Executes workflow
- `.set_output_options(**options)`: Sets output metadata/optimization

**Example Usage:**
```python
from nutrient_dws import APIError

# User Story: Convert a DOCX to PDF and rotate it (Builder version)
try:
    client.build(input_file="path/to/document.docx") \
          .add_step(tool="rotate-pages", options={"degrees": 90}) \
          .execute(output_path="path/to/final_document.pdf")

    print("Workflow complete. File saved to path/to/final_document.pdf")

except APIError as e:
    print(f"An API error occurred: Status {e.status_code}, Response: {e.response_body}")
```

### 4.5. Error Handling
The library provides a comprehensive set of custom exceptions for clear error feedback:

- `NutrientError(Exception)`: The base exception for all library-specific errors.
- `AuthenticationError(NutrientError)`: Raised on 401/403 HTTP errors, indicating an invalid or missing API key.
- `APIError(NutrientError)`: Raised for general API errors (e.g., 400, 422, 5xx status codes). Contains `status_code`, `response_body`, and optional `request_id` attributes.
- `ValidationError(NutrientError)`: Raised when request validation fails, with optional `errors` dictionary.
- `NutrientTimeoutError(NutrientError)`: Raised when requests timeout.
- `FileProcessingError(NutrientError)`: Raised when file processing operations fail.
- `FileNotFoundError` (Built-in): Standard Python exception for missing file paths.

## 5. Implementation Details

### 5.1. Package Structure
- **Layout**: Standard `src` layout with `nutrient_dws` package
- **Configuration**: `pyproject.toml` for project metadata and dependencies
- **Dependencies**: `requests` as sole runtime dependency
- **Versioning**: Semantic versioning starting at `1.0.0`

### 5.2. File Handling Optimizations
- **Large Files**: Files >10MB are streamed rather than loaded into memory
- **Input Types**: Support for `str` paths, `bytes`, `Path` objects, and file-like objects
- **Output**: Returns `bytes` by default, or saves to `output_path` when provided
