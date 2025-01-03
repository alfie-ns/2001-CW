from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from django.db import IntegrityError

'''
    This command creates a default user for development purposes.

    I never actually used this in the end, but I kept it here as an example of how to create custom management commands. in Django.
'''

class Command(BaseCommand):
    help = 'Creates a default user for development'

    def handle(self, *args, **kwargs):
        try: # try to create a default user
            if not User.objects.filter(username='default_user').exists():
                User.objects.create_user(
                    username='default_user',
                    email='default@example.com',
                    password='defaultpass123'
                )
                self.stdout.write(self.style.SUCCESS('Default user created successfully'))
            else:
                self.stdout.write(self.style.WARNING('Default user already exists'))
        except IntegrityError as e:
            self.stdout.write(self.style.ERROR(f'Error creating user: {str(e)}'))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Unexpected error: {str(e)}'))