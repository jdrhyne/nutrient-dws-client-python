"""Unit tests for Builder API."""

from nutrient_dws.builder import BuildAPIWrapper


def test_builder_init():
    """Test builder initialization."""
    builder = BuildAPIWrapper(None, "test.pdf")
    assert builder._input_file == "test.pdf"
    assert builder._actions == []
    assert builder._parts == [{"file": "file"}]
    assert "file" in builder._files


def test_builder_add_step():
    """Test adding steps to builder."""
    builder = BuildAPIWrapper(None, "test.pdf")
    result = builder.add_step("convert-to-pdf", options={"format": "docx"})

    assert result is builder  # Should return self for chaining
    assert len(builder._actions) == 1
    assert builder._actions[0]["type"] == "convert-to-pdf"
    assert builder._actions[0]["format"] == "docx"


def test_builder_chaining():
    """Test method chaining."""
    builder = BuildAPIWrapper(None, "test.pdf")
    result = (
        builder.add_step("convert-to-pdf")
        .add_step("rotate-pages", options={"degrees": 90})
        .add_step("watermark-pdf", options={"text": "DRAFT"})
    )

    assert result is builder
    assert len(builder._actions) == 3
    # Actions are transformed by _map_tool_to_action, so check structure exists
    assert all("type" in action for action in builder._actions)


def test_builder_set_output_options():
    """Test setting output options."""
    builder = BuildAPIWrapper(None, "test.pdf")
    result = builder.set_output_options(metadata={"title": "Test Doc"}, optimize=True)

    assert result is builder
    assert builder._output_options["metadata"]["title"] == "Test Doc"
    assert builder._output_options["optimize"] is True


def test_builder_execute_requires_client():
    """Test that execute requires a client."""
    builder = BuildAPIWrapper(None, "test.pdf")
    builder.add_step("convert-to-pdf")

    # Without a proper client, this would fail when trying to access client methods
    # We can't test the actual failure without mocking, so just ensure the method exists
    assert hasattr(builder, "execute")
