from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from .models import Trail, Location
from .serializers import TrailSerializer, LocationSerializer

'''
    Define the viewsets for the API which'll handle interactions with the models

    - TrailViewSet: A viewset for managing CRUD operations on the Trail model;
    using the TrailSerializer to validate and structure data, and applies permissions
    so ONLY authenticated users can modify data, while unauthenticated users can still 
    view it.

    - LocationViewSet: A viewset for managing CRUD operations on the Location model; using
    the LocationSerializer for data handling and applies the same permissions as TrailViewSet.
'''

class TrailViewSet(viewsets.ModelViewSet):
    queryset = Trail.objects.all()
    serializer_class = TrailSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]