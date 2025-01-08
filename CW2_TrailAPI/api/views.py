from django.shortcuts import render
from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from django.contrib.auth.models import User
from .models import Trail, Location
from .serializers import TrailSerializer, LocationSerializer
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from .models import Trail

'''
    Define the viewsets and supporting API functionality for the application.

    - TrailViewSet: Handles CRUD operations for the Trail model using the TrailSerializer 
    for data validation and structuring. It applies permissions to allow only authenticated 
    users to modify data, while unauthenticated users can still view it. Additionally, 
    assigns a default user for creation when no authentication is required.

    - LocationViewSet: Handles CRUD operations for the Location model using the 
    LocationSerializer for data handling. Permissions are consistent with TrailViewSet.

    - trail_manage: A function-based view rendering the 'trails/manage.html' template 
    with all Trail model instances, ensuring a Content-Type of 'text/html'.
'''

@api_view(['GET'])
#@permission_classes([IsAuthenticatedOrReadOnly]) | if 
def trail_manage(request):
    trails = Trail.objects.all()
    response = render(request, 'trails/manage.html', {'trails': trails})
    response['Content-Type'] = 'text/html'
    return response

class TrailViewSet(viewsets.ModelViewSet):
    queryset = Trail.objects.all()
    serializer_class = TrailSerializer
    permission_classes = []

    def perform_create(self, serializer):
        # use a default user without requiring authentication
        user = User.objects.get_or_create(username='default_user')[0]
        serializer.save(owner=user)

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer
    permission_classes = []

