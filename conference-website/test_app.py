import pytest
from app import app, TALKS_DATABASE

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_page_status(client):
    """Test that the homepage load returns a 200 status code and expected elements."""
    response = client.get('/')
    assert response.status_code == 200
    # Check if the title/theme or key conference content is present in the response
    html = response.data.decode('utf-8')
    assert 'Google Cloud Summit 2026' in html
    assert 'Google Cloud Tech Center' in html

def test_api_all_talks(client):
    """Test that the API endpoint returns all talks plus lunch break (9 entries total)."""
    response = client.get('/api/talks')
    assert response.status_code == 200
    data = response.json
    assert len(data) == 9
    # Check if a specific talk is in the database
    assert data[0]['title'] == "Introdução ao Google Cloud: Primeiros Passos e Arquitetura Global"

def test_api_category_filter(client):
    """Test category filtering via the API."""
    # Filter by category 1 (Cloud & Infra)
    response = client.get('/api/talks?category=1')
    assert response.status_code == 200
    data = response.json
    # Should contain category 1 talks + lunch break (id 99)
    for talk in data:
        assert talk['category_id'] == 1 or talk['id'] == 99

    # Filter by category 2 (Data & AI)
    response_cat2 = client.get('/api/talks?category=2')
    data_cat2 = response_cat2.json
    for talk in data_cat2:
        assert talk['category_id'] == 2 or talk['id'] == 99

def test_api_text_search(client):
    """Test searching by speaker name or title keywords."""
    # Search by speaker first name
    response = client.get('/api/talks?q=Amanda')
    assert response.status_code == 200
    data = response.json
    assert len(data) == 1
    assert data[0]['speakers'][0]['first_name'] == 'Amanda'

    # Search by title keyword
    response_keyword = client.get('/api/talks?q=Serverless')
    assert response_keyword.status_code == 200
    data_keyword = response_keyword.json
    assert len(data_keyword) == 1
    assert "Serverless" in data_keyword[0]['title']

def test_lunch_break_duration(client):
    """Verify that the lunch break is exactly 60 minutes long."""
    lunch = next((talk for talk in TALKS_DATABASE if talk['id'] == 99), None)
    assert lunch is not None
    assert lunch['time'] == "12:00 - 13:00"
    # 12:00 to 13:00 is exactly 1 hour (60 minutes)
