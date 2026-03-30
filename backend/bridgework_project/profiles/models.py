from django.db import models
from users.models import User # i fix it " khaouala :) "
#from django.contrib.auth.models import User  
# Create your models here.
class WorkerProfile(models.Model):
  user = models.OneToOneField(User,on_delete=models.CASCADE)
  bio = models.TextField(blank=True)
  cv_file = models.FileField(upload_to='cvs/',blank=True,null=True)
  education = models.TextField(blank=True)
  experience = models.TextField(blank=True)
  projects = models.TextField(blank=True)
  availability = models.CharField(max_length=100,blank=True)
  languages = models.CharField(max_length=100,blank=True)

  def __str__(self):
    return self.user.fullname
 

class EmployerProfile(models.Model):
  user = models.OneToOneField(User,on_delete=models.CASCADE)
  company_name =  models.CharField(max_length=100,blank=True)
  company_logo = models.ImageField(upload_to='profile_pics/',blank=True,null=True)
  about_company =models.TextField(blank=True)
  services = models.TextField(blank=True)
  achievements = models.TextField(blank=True)
  availability_needed = models.CharField(max_length=100,blank=True)

  def __str__(self):
    return self.company_name
 