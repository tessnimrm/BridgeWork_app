from django.urls import path
from . import views

urlpatterns = [
    path('interest/<int:user_id>/',views.send_interested,name='send_interested'),
    path('interest/<int:user_id>/remove/', views.remove_interested, name='remove_interested'),
    path('favorite/<int:user_id>/',views.add_favorite,name='add_favorite'),
    path('favorite/<int:user_id>/remove/', views.remove_favorite,name='remove_favorite'),
    path('favorites/',views.list_favorites,name='list_favorites'),
    
]