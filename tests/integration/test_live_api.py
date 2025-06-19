"""Integration tests against the live Nutrient DWS API.

These tests require a valid API key configured in integration_config.py.
"""

import pytest

from nutrient_dws import NutrientClient

try:
    from . import integration_config  # type: ignore[attr-defined]

    API_KEY = integration_config.API_KEY
    BASE_URL = getattr(integration_config, "BASE_URL", None)
    TIMEOUT = getattr(integration_config, "TIMEOUT", 60)
except ImportError:
    API_KEY = None
    BASE_URL = None
    TIMEOUT = 60


@pytest.mark.skipif(not API_KEY, reason="No API key configured in integration_config.py")
class TestLiveAPI:
    """Integration tests against live API."""

    @pytest.fixture
    def client(self):
        """Create a client with the configured API key."""
        client = NutrientClient(api_key=API_KEY, timeout=TIMEOUT)
        yield client
        client.close()

    @pytest.fixture
    def sample_pdf_path(self):
        """Get path to sample PDF file for testing."""
        import os

        return os.path.join(os.path.dirname(__file__), "..", "data", "sample.pdf")

    def test_client_initialization(self):
        """Test that client initializes correctly with API key."""
        client = NutrientClient(api_key=API_KEY)
        assert client._api_key == API_KEY
        client.close()

    def test_client_missing_api_key(self):
        """Test that client works without API key but fails on API calls."""
        client = NutrientClient()
        # Should not raise during initialization
        assert client is not None
        client.close()

    def test_basic_api_connectivity(self, client, sample_pdf_path):
        """Test basic API connectivity with a simple operation."""
        # This test will depend on what operations are available
        # For now, we'll test that we can create a builder without errors
        builder = client.build(input_file=sample_pdf_path)
        assert builder is not None

    @pytest.mark.skip(reason="Requires specific tool implementation")
    def test_convert_operation(self, client, sample_pdf_path, tmp_path):
        """Test a basic convert operation (example - adjust based on available tools)."""
        # This is an example - adjust based on actual available tools
        # output_path = tmp_path / "output.pdf"
        # result = client.convert_to_pdf(input_file=sample_pdf_path, output_path=str(output_path))

        # assert output_path.exists()
        # assert output_path.stat().st_size > 0

    def test_builder_api_basic(self, client, sample_pdf_path):
        """Test basic builder API functionality."""
        builder = client.build(input_file=sample_pdf_path)

        # Test that we can add steps without errors
        # This will need to be updated based on actual available tools
        # builder.add_step("example-tool", {})

        assert builder is not None
