from rest_framework import serializers
from .models import Trail, Location
from django.contrib.auth.models import User

'''
These serialisers convert Django model instances into JSON/XML format, 
and vice versa; they handle the transformation of:

- Model instances to JSON for API responses
- JSON data to model instances for database operations
- Nested relationships between models (Trail -> Location, Trail -> User)
- Data validation and field type conversion

Each serialiser maps specific model fields to ensure proper data representation
whilst also maintaining model relationships and data integrity.
'''

class LocationSerializer(serializers.ModelSerializer): 
    class Meta:
        model = Location
        fields = ['id', 'city', 'county', 'country']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email']

class TrailSerializer(serializers.ModelSerializer):
    location = LocationSerializer()
    owner = UserSerializer(read_only=True) # prevent user from changing owner

    class Meta:
        model = Trail
        fields = ['id', 'name', 'length', 'elevation_gain', 'route_type', 
                 'description', 'difficulty', 'location', 'owner']