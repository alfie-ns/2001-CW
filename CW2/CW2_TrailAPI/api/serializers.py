from rest_framework import serializers
from .models import Trail, Location
from django.contrib.auth.models import User

'''
    Serializers are used to convert complex data types, such as querysets and model instances;

    In this instance, it serialises Location, User and Trail models into JSON format for the API to consume;
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
    owner = UserSerializer(read_only=True)

    class Meta:
        model = Trail
        fields = ['id', 'name', 'length', 'elevation_gain', 'route_type', 
                 'description', 'difficulty', 'location', 'owner']

    def create(self, validated_data):
        location_data = validated_data.pop('location')
        # create new location
        location = Location.objects.create(**location_data)
        trail = Trail.objects.create(location=location, **validated_data)
        return trail

    def update(self, instance, validated_data):
        if 'location' in validated_data:
            location_data = validated_data.pop('location')
            # create new location for update instead of get_or_create
            location = Location.objects.create(**location_data)
            instance.location = location
        
        # Update other fields
        instance.name = validated_data.get('name', instance.name)
        instance.length = validated_data.get('length', instance.length)
        instance.difficulty = validated_data.get('difficulty', instance.difficulty)
        instance.route_type = validated_data.get('route_type', instance.route_type)
        instance.description = validated_data.get('description', instance.description)
        instance.elevation_gain = validated_data.get('elevation_gain', instance.elevation_gain)
        
        instance.save()
        return instance