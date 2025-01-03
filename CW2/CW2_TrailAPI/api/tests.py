from django.test import TestCase
from django.contrib.auth.models import User
from rest_framework.test import APIClient
from .models import Trail, Location

# Create your tests here.

'''
    This class handles unit tests for the Django application;

    the class inherits from the Django TestCase class, which 
    provides a set of tools for testing Django applications.
'''

class TrailTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.location = Location.objects.create(
            city='Plymouth',
            county='Devon',
            country='England'
        )
        
    def test_create_trail(self):
        data = {
            'name': 'Test Trail',
            'length': 5.0,
            'difficulty': 'Easy',
            'route_type': 'Loop',
            'location': {
                'city': 'Plymouth',
                'county': 'Devon', 
                'country': 'England'
            }
        }
        response = self.client.post('/api/trails/', data, format='json') # POST request to create a new trail
        self.assertEqual(response.status_code, 201)
        self.assertEqual(Trail.objects.count(), 1)
        self.assertEqual(Trail.objects.get().name, 'Test Trail')

    def test_get_trail(self):
        trail = Trail.objects.create(
            name='Test Trail',
            length=5.0,
            difficulty='Easy',
            location=self.location,
            owner=self.user
        )
        response = self.client.get(f'/api/trails/{trail.id}/') # GET request to retrieve a trail
        self.assertEqual(response.status_code, 200) # ensure response status code is 200
        self.assertEqual(response.data['name'], 'Test Trail') # ensure response data is correct