from django.urls import path 
from . import views

urlpatterns = [
   path('conversations/', views.list_conversations),
    path('conversations/<int:id>/messages/', views.get_message),
    path('messages/send/', views.send_message),
    path('conversations/auto-open/', views.auto_open_conversation),
]

