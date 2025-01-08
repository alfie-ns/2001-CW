from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

# get raw strings thus ensuring the backslashes are treated as literal characters; not escape characters
router = DefaultRouter()
router.register(r'trails', views.TrailViewSet)
router.register(r'locations', views.LocationViewSet)

urlpatterns = [
    path('trails/manage/', views.trail_manage, name='trail_manage'),
    path('', include(router.urls)),
    
    
]