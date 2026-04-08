from rest_framework import serializers
from .models import Conversation, Message
from users.models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=['id','avatar','fullname']

class CoversationSerializer(serializers.ModelSerializer):
    user1 =UserSerializer(read_only=True)
    user2= UserSerializer(read_only=True)
    last_message = serializers.SerializerMethodField()
    class Meta:
      model=Conversation
      fields = ['id','user1',"user2",'created','is_active','last_message']

    def get_last_message(self,obj):
      last = obj.message.order_by("-sent_at").first()
      if last :
          return last.content
      return None

class MessageSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)
    class Meta:
        model=Message
        fields = ['id','conversation','sender','content','sent_at','is_read']
        read_only_fields =['sender','sent_at']