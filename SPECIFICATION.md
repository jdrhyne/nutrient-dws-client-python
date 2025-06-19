# Software Design Specification: Nutrient DWS Python Client
Version: 1.1
Date: June 18, 2024

## 1. Introduction
### 1.1. Project Overview
This document outlines the software design specification for a new Python client library for the Nutrient Document Web Services (DWS) API. The goal of this project is to create a high-quality, lightweight, and intuitive Python package that simplifies interaction with the Nutrient DWS API for developers.

The library will provide two primary modes of interaction:
- A **Direct API** for executing single, discrete document processing tasks (e.g., converting a single file, rotating a page) by wrapping the `/process/{tool}` endpoints.
- A **Builder API** that offers a fluent, chainable interface for composing and executing complex, multi-step document processing workflows, abstracting the `POST /build` endpoint of the Nutrient API.

The final product will be a distributable package suitable for publishing on PyPI, with comprehensive documentation. The design prioritizes ease of use, adherence to Python best practices, and clear documentation consumable by both humans and LLMs.

### 1.2. Scope
This specification covers the design and architecture of the Python client library itself. The scope includes:
- Client authentication and configuration.
- Implementation of static wrappers for individual document processing tools.
- Implementation of the Builder API for multi-step workflows.
- A refined error handling and reporting strategy.
- Flexible file input/output handling.
- Packaging structure for PyPI distribution.
- Documentation generation strategy.

Out of scope for this version are:
- A command-line interface (CLI).
- Support for asynchronous job polling or webhooks. All API calls will be synchronous, holding the HTTP connection open until a final result is returned.
- Implementations in languages other than Python.

### 1.3. References
- **Nutrient DWS OpenAPI Specification**: https://dashboard.nutrient.io/assets/specs/public@1.9.0-dfc6ec1c1d008be3dcb81a72be6346b5.yml
- **Nutrient DWS API Documentation & Guides**: https://www.nutrient.io/api/tools-overview/
- **Target API Endpoint Base**: https://api.pspdfkit.com

## 2. Goals and Objectives
- **Simplicity**: Provide a clean, Pythonic interface that abstracts the complexities of direct HTTP requests, authentication, and file handling.
- **Flexibility**: Offer both a simple, direct API for single tasks and a powerful, fluent Builder API for complex workflows.
- **Lightweight**: The library will have one primary external dependency: the `requests` library for synchronous HTTP communication.
- **Discoverability**: The API design and documentation will be clear and predictable, enabling developers (and LLMs) to easily understand and use its capabilities.
- **Distribution-Ready**: The project will be structured as a standard Python package, complete with a `pyproject.toml` file, ready for publication to PyPI.
- **Well-Documented**: Produce high-quality, auto-generated API documentation from docstrings, supplemented with tutorials and usage examples.

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
1. User instantiates `NutrientClient`.
2. User calls a method, e.g., `client.rotate_pages(input_file='path/to/doc.pdf', degrees=90)`.
3. The method prepares the input file and parameters.
4. It constructs a `multipart/form-data` POST request to `/process/rotate-pages`.
5. It receives the processed file in the HTTP response and returns it.

**Builder API Call:**
1. User instantiates `NutrientClient`.
2. User starts a build chain: `builder = client.build(input_file='path/to/doc.docx')`.
3. User chains operations: `builder.add_step(tool='convert-to-pdf').add_step(tool='rotate-pages', options={'degrees': 90})`.
4. User calls `builder.execute()`.
5. The `execute()` method constructs the `multipart/form-data` request, sending the file(s) and a JSON payload describing the sequence of actions to the `/build` endpoint.
6. It receives the final processed file and returns it.

## 4. Detailed API Design
### 4.1. Client Initialization
The client will be initialized with an optional API key and timeout. It will follow modern Python library best practices for configuration.

```python
from nutrient_dws import NutrientClient, AuthenticationError

# Option 1: API key passed directly (takes precedence)
client = NutrientClient(api_key="YOUR_DWS_API_KEY", timeout=300) 

# Option 2: API key read from NUTRIENT_API_KEY environment variable
# client = NutrientClient()

# No error is raised on init if no key is found.
# An AuthenticationError will be raised on the first API call.
try:
    # This call will fail if the key is invalid or missing.
    client.some_api_call(...) 
except AuthenticationError as e:
    print(f"Authentication failed: {e}")
```

- **Precedence**: The `api_key` argument in the constructor takes priority over the `NUTRIENT_API_KEY` environment variable.
- **Timeout**: The `timeout` argument (in seconds) is passed to the underlying `requests` calls.

### 4.2. File Handling
**Input Types**: Methods that accept file inputs will support:
- A `str` representing a local file path.
- A raw `bytes` object.
- A file-like object that supports reading in binary mode (an instance of `io.IOBase`).

**Output Behavior**: Methods that return a file will:
- Return a `bytes` object by default.
- If an `output_path` string argument is provided, the method will save the file directly to that path and return `None` to conserve memory.

### 4.3. Direct API Design
Method names will be snake_case versions of the tool identifiers from the OpenAPI specification. All tool-specific parameters will be keyword-only arguments.

**Example Usage:**
```python
# User Story: Convert a DOCX to PDF and rotate it.

# Step 1: Convert DOCX to PDF
pdf_bytes = client.convert_to_pdf(
    input_file="path/to/document.docx"
)

# Step 2: Rotate the newly created PDF from memory
# The 'degrees' parameter is a required, keyword-only argument for this tool.
client.rotate_pages(
    input_file=pdf_bytes,
    output_path="path/to/rotated_document.pdf", # Save the final result
    degrees=90
)

print("File saved to path/to/rotated_document.pdf")
```

### 4.4. Builder API Design
The Builder API provides a more elegant and efficient solution for multi-step workflows by making a single API call.

- `client.build(input_file)`: Starts a new build workflow.
- `.add_step(tool: str, options: dict = None)`: Adds a processing step. `tool` is the string identifier from the API. `options` is a dictionary of parameters for that tool.
- `.execute(output_path: str = None)`: Finalizes the chain, sends the request to the `/build` endpoint, and returns the result.

**Example Usage:**
```python
from nutrient_dws import APIError

# User Story: Convert a DOCX to PDF and rotate it (Builder version)
try:
    client.build(input_file="path/to/document.docx") \
          .add_step(tool="convert-to-pdf") \
          .add_step(tool="rotate-pages", options={"degrees": 90}) \
          .execute(output_path="path/to/final_document.pdf")

    print("Workflow complete. File saved to path/to/final_document.pdf")

except APIError as e:
    print(f"An API error occurred: Status {e.status_code}, Response: {e.response_body}")
```

### 4.5. Error Handling
The library will use a specific set of custom exceptions for clear error feedback.

- `NutrientError(Exception)`: The base exception for all library-specific errors.
- `AuthenticationError(NutrientError)`: Raised on 401/403 HTTP errors, indicating an invalid or missing API key.
- `APIError(NutrientError)`: Raised for all other general API errors (e.g., 400, 422, 5xx status codes). It will contain the `status_code` and the raw `response_body` from the API for debugging.
- `FileNotFoundError` (Built-in): This standard Python exception will be allowed to propagate if a string path provided as `input_file` does not exist.

## 5. Packaging and Distribution
- **Structure**: The project will follow the standard `src` layout for Python packages.
- **Configuration**: A `pyproject.toml` file will manage project metadata, build configurations, and dependencies.
- **Dependencies**: `requests` will be the only primary runtime dependency.
- **Versioning**: The project will use semantic versioning (e.g., `1.0.0`).
- **Publication**: The package will be configured for easy building (`python -m build`) and uploading to PyPI using `twine`.

## 6. Documentation
- **Tool**: Sphinx or MkDocs will be used to generate the documentation website.
- **API Reference**: An "API Reference" section will be generated automatically from the Python docstrings using `sphinx.ext.autodoc`. Docstrings will be written in a clear, structured format (e.g., Google Style).
- **Tutorials/Guides**: The documentation will include a "Quickstart" guide, a detailed page explaining the Direct vs. Builder APIs, and code examples for common use cases.
- **Deployment**: Documentation will be automatically built and deployed to GitHub Pages via GitHub Actions on merges to the `main` branch.
