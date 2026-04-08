from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Conversation, Message
from .serializers import CoversationSerializer, MessageSerializer
from users.models import User
# Create your views here.
#get list of conv
@api_view(['GET'])
def list_conversations(request):
    conversations = Conversation.objects.filter(user1=request.user)|Conversation.objects.filter(user2=request.user)
    serializer = CoversationSerializer(conversations,many=True)
    return Response(serializer.data)
#get message
@api_view(['GET'])
def get_message(request,id):
    try:
        conversation = Conversation.objects.get(id=id)
    except Conversation.DoesNotExist:
        return Response({"error":"conversation not found"},status=status.HTTP_404_NOT_FOUND)
    message=Message.objects.filter(conversation=conversation)
    serializer = MessageSerializer(message,many=True)
    return Response(serializer.data)
#send message
@api_view(['POST'])
def send_message(request):
    conversation_id = request.data.get("conversation")
    content = request.data.get("content")
    try:
        conversation = Conversation.objects.get(id=conversation_id)
    except Conversation.DoesNotExist:
         return Response({"error":"conversation not found"},status=status.HTTP_404_NOT_FOUND)
    message = Message.objects.create(conversation=conversation,sender=request.user,content=content)
    serializer = MessageSerializer(message)
    return Response(serializer.data,status=status.HTTP_201_CREATED)
#create conv if 2 user like each other
@api_view(['POST'])
def auto_open_conversation(request):
    user1=request.user
    user2_id=request.data.get("user2")
    user2= User.objects.get(id=user2_id)
    conversation, created=Conversation.objects.get_or_create(user1=user1,user2=user2)
    serializer =CoversationSerializer(conversation)
    return Response(serializer.data)

