from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register,name='register'),
    path('userinfo/', views.current_user,name='userinfo'),
    path('login/',views.login,name='login'),
    path('logout/',views.logout,name='logout'),
    path('change-password/', views.change_password,  name='change_password'),
    path('setRole/', views.setRole, name='setRole'),
    path('set-categories/', views.set_categories, name='set_categories'),
]