from django.db import models
from django.contrib.auth.models import User

# note that the max_lengths for each attribute are only as big as they need to be

# location model/table to store location details of the trail
class Location(models.Model):
    city = models.CharField(max_length=100, default='Plymouth')
    county = models.CharField(max_length=100, default='Devon')
    country = models.CharField(max_length=100, default='England')

    def __str__(self):
        return f"{self.city}, {self.county}, {self.country}"

# trail model/table to store trail details
class Trail(models.Model):
    ROUTE_CHOICES = [
        ('Out & Back', 'Out & Back'),
        ('Loop', 'Loop'),
        ('Point to Point', 'Point to Point')
    ]
    
    DIFFICULTY_CHOICES = [
        ('Easy', 'Easy'),
        ('Moderate', 'Moderate'),
        ('Hard', 'Hard')
    ]

    name = models.CharField(max_length=75)
    length = models.FloatField(default=0.0)
    elevation_gain = models.IntegerField(default=0)
    route_type = models.CharField(max_length=15, choices=ROUTE_CHOICES, default='Loop')
    description = models.TextField(max_length=500, blank=True, null=True)
    difficulty = models.CharField(max_length=10, choices=DIFFICULTY_CHOICES, default='Moderate')
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.name