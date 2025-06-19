"""Pytest configuration for integration tests."""

import pytest


def pytest_configure(config):
    """Configure pytest for integration tests."""
    # Add custom markers
    config.addinivalue_line(
        "markers", "integration: marks tests as integration tests (may require API key)"
    )


def pytest_collection_modifyitems(config, items):
    """Automatically mark integration tests."""
    for item in items:
        if "integration" in str(item.fspath):
            item.add_marker(pytest.mark.integration)
