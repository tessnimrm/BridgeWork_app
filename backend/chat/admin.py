from django.contrib import admin
from .models import Conversation, Message

# Register your models here.
@admin.register(Conversation)
class ConversationAdmin(admin.ModelAdmin):
  list_display=['id','user1',"user2",'created','is_active']  #see in admin this fields
  search_fields =['user1__fullname','user2__fullname'] #find cnv by name
  list_filter =['is_active','created'] #

@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
  list_display =['id','conversation','sender','sent_at','is_read']
  search_fields =['sender__fullname','content']
  list_filter= ['is_read','sent_at']