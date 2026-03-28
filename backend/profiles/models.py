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

  def update_profile(self,bio,education,experience,projects,languages,availability) :
   self.bio = bio
   self.education = education
   self.experience = experience
   self.projects = projects
   self.languages = languages
   self.availability = availability
   self.save()
   
  def upload_cv(self,file):
   self.cv_file = file
   self.save ()

  def get_profile(self):
   return {
   "bio":self.bio ,
  "education" :self.education ,
   "experience": self.experience, 
   "projects":self.projects ,
   "languages":self.languages ,
   "availability":self.availability,
   "cv_file":self.cv_file.url if self.cv_file else None # to know if cv is there or no so it can display it
 }

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

  def update_profile(self,company_name,company_logo,services,about_company,achievements, availability_needed) :
    self.company_name = company_name
    self.company_logo = company_logo
    self.services  = services
    self.about_company= about_company
    self.achievements = achievements
    self. availability_needed =  availability_needed
    self.save()
   

  def get_profile(self):
    return {
      "company_name":self.company_name ,
     "about_company" :self.about_company ,
        "services": self.services, 
     "achievements":self.achievements ,
     "availability_needed":self.availability_needed ,
     "company_logo ":self.company_logo.url if self.company_logo else None # to know if cv is there or no so it can display it
 }

  def __str__(self):
    return self.company_name
 