"""Unit tests for file handling utilities."""

import io

from nutrient_dws.file_handler import (
    prepare_file_input,
)


def test_prepare_file_input_from_bytes():
    """Test preparing file input from bytes."""
    content = b"Hello, World!"
    result, filename = prepare_file_input(content)
    assert result == content
    assert filename == "document"


def test_prepare_file_input_from_string_io():
    """Test preparing file input from StringIO-like object."""
    # Using BytesIO instead of StringIO for binary compatibility
    content = b"Test content"
    file_obj = io.BytesIO(content)
    result, filename = prepare_file_input(file_obj)
    assert result == content
    assert filename == "document"


def test_get_file_size_from_bytes():
    """Test getting file size from bytes."""
    from nutrient_dws.file_handler import get_file_size

    content = b"Hello, World!"
    size = get_file_size(content)
    assert size == 13


def test_get_file_size_from_bytesio():
    """Test getting file size from BytesIO."""
    from nutrient_dws.file_handler import get_file_size

    content = b"Test content"
    file_obj = io.BytesIO(content)
    size = get_file_size(file_obj)
    assert size == 12
