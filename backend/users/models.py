from django.contrib.auth.models import AbstractUser
from django.db import models

ROLE_CHOICES = [
    ('jobseeker', 'Jobseeker'),
    ('employer',  'Employer'),
]


class User(AbstractUser):
    fullname=models.CharField(max_length=30, blank=False)
    email  = models.EmailField(unique=True)
    #phone  = models.CharField(max_length=20, blank=True)
    role   = models.CharField(max_length=20, choices=ROLE_CHOICES)
   # avatar = models.ImageField(upload_to='avatars/', blank=True, null=True)
    categories = models.JSONField(default=list)

    USERNAME_FIELD  = 'email'       # login with email not username
    REQUIRED_FIELDS = ['username']

    def __str__(self):
       # return f"{self.email} ({self.username})"
       return f"{self.username} "