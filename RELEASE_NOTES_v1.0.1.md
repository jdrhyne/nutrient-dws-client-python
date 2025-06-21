# Release v1.0.1

## 🎉 First Stable Release on PyPI

We're excited to announce the first stable release of `nutrient-dws`, the official Python client library for Nutrient Document Web Services API!

## 📦 Installation

```bash
pip install nutrient-dws
```

## ✨ Features

### Direct API
Simple, straightforward methods for common operations:
```python
from nutrient_dws import NutrientClient

client = NutrientClient("your-api-key")
pdf_bytes = client.convert_to_pdf("document.docx")
```

### Builder API
Fluent interface for complex document workflows:
```python
result = client.build("input.pdf") \
    .add_step("rotate-pages", options={"degrees": 90}) \
    .add_step("watermark-pdf", options={"text": "CONFIDENTIAL"}) \
    .execute("output.pdf")
```

### Comprehensive Features
- 🔧 **7 Direct API methods** for common operations
- 🔗 **Chainable Builder API** for complex workflows
- 🛡️ **Robust error handling** with custom exceptions
- 📝 **Full type hints** for better IDE support
- 🧪 **94% test coverage** with 154 tests
- 🐍 **Python 3.8-3.12** support
- 📚 **Minimal dependencies** (only requires `requests`)

## 📋 Available Operations

- **convert_to_pdf** - Convert documents to PDF
- **convert_from_pdf** - Convert PDFs to other formats
- **ocr_pdf** - Perform OCR on PDFs
- **watermark_pdf** - Add watermarks to PDFs
- **flatten_annotations** - Flatten PDF annotations
- **rotate_pages** - Rotate PDF pages
- **merge_pdfs** - Merge multiple PDFs

## 🔧 Improvements in v1.0.1

- ✅ Comprehensive test suite with 94% coverage
- ✅ Fixed CI pipeline for all Python versions
- ✅ Resolved package metadata compatibility
- ✅ Enhanced file handling with better error messages
- ✅ Improved type checking with mypy

## 📖 Documentation

For detailed usage examples and API documentation, visit our [GitHub repository](https://github.com/PSPDFKit/nutrient-dws-client-python).

## 🙏 Acknowledgments

Thank you to everyone who contributed to making this release possible!

---

**Full Changelog**: https://github.com/PSPDFKit/nutrient-dws-client-python/commits/v1.0.1