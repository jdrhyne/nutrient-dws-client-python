# v1.0.1 - Critical Documentation Fix and Testing Improvements

## 🐛 Critical Bug Fixes

### Documentation Error Fixed
- **Fixed README.md**: Corrected documentation to use `NutrientTimeoutError` instead of `TimeoutError` in import examples and exception handling
- **Resolved Import Error**: Users following README examples will no longer get `ImportError: cannot import name 'TimeoutError'`

### CI/Testing Stability
- **Test Collection**: Fixed pytest collection failures in CI environments
- **TOML Configuration**: Removed duplicate setuptools configuration causing installation errors  
- **Type Checking**: Resolved mypy errors across all modules
- **Linting**: Fixed all ruff linting issues (W292, W293, RUF034, SIM115, B017, E501)

## ✨ New Features

### Testing Infrastructure
- **31 Comprehensive Unit Tests**: Added full test coverage for all major components
  - HTTP client tests (5 tests)
  - File handler tests (5 tests) 
  - Builder API tests (5 tests)
  - Exception handling tests
  - Client functionality tests
- **Integration Test Framework**: New CI workflow for testing against live API
  - Runs on all Python versions (3.8-3.12)
  - Secure API key handling via GitHub secrets
  - Automatic config cleanup
  - Basic smoke test for API connectivity

### Development Quality  
- **Repository Enhancement**: Added badges, issue templates, and documentation
- **CI Pipeline**: Improved workflow with better error handling and debugging

## 🔧 Technical Improvements

- All tests pass on Python 3.8-3.12
- CI pipeline is stable and reliable  
- Integration tests provide continuous API validation
- Code coverage and quality metrics tracked
- Type safety enhanced with better annotations

## 📋 What's Changed

**Full Changelog**: https://github.com/PSPDFKit/nutrient-dws-client-python/compare/v1.0.0...v1.0.1

This patch release fixes a critical documentation bug that would prevent users from successfully importing the library when following README examples. It also adds significant testing infrastructure and stability improvements based on 29 commits of fixes and enhancements.

**Upgrade recommended** for all users to avoid import errors.
EOF < /dev/null