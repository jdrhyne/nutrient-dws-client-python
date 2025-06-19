"""Unit tests for HTTPClient."""

from nutrient_dws.http_client import HTTPClient


def test_http_client_init():
    """Test HTTP client initialization."""
    client = HTTPClient(api_key="test-key")
    assert client._api_key == "test-key"
    assert client._base_url == "https://api.pspdfkit.com"
    assert client._timeout == 300


def test_http_client_init_custom_timeout():
    """Test HTTP client with custom timeout."""
    client = HTTPClient(api_key="test-key", timeout=60)
    assert client._timeout == 60


def test_http_client_init_no_api_key():
    """Test HTTP client initialization without API key."""
    client = HTTPClient(api_key=None)
    assert client._api_key is None


def test_http_client_init_empty_api_key():
    """Test HTTP client initialization with empty API key."""
    client = HTTPClient(api_key="")
    assert client._api_key == ""


def test_http_client_context_manager():
    """Test HTTP client can be used as context manager."""
    with HTTPClient(api_key="test-key") as client:
        assert client is not None
        assert hasattr(client, "_session")
