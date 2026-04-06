from django.db import models
from users.models import User
# Create your models here.
class Conversation(models.Model):
 user1 = models.ForeignKey(User, on_delete=models.CASCADE, related_name='conversations_as_user1')
 user2 = models.ForeignKey(User, on_delete=models.CASCADE, related_name='conversations_as_user2')
 created = models.DateTimeField(auto_now_add=True)
 is_active =models.BooleanField(default=True)
  
 class Meta:
     unique_together =('user1','user2') # cant have the same conv twice
     ordering =['-created']# the new conversation is first (the order of cnv)

 def __str__(self): # so to know what is this
     return f"conversation between {self.user1.fullname}and{self.user2.fullname} "



class Message(models.Model):
 conversation= models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name='message')
 sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_message')
 content = models.TextField(blank=True)
 sent_at =  models.DateTimeField(auto_now_add=True)
 is_read = models.BooleanField(default=False)
 class Meta:
    ordering =['sent_at'] #message from old to new

 def __str__(self):
    return f"message from{self.sender.fullname}at{self.sent_at}"