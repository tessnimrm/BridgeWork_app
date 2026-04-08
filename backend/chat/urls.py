from django.urls import path 
from . import views

urlpatterns = [
    path("worker/profile/",views.worker_profile),
    path("employer/profile/",views.employer_profile),
    path("switch-mode/",views.switch_mode),
    path("profile/<int:id>/",views.view_profile),
]

