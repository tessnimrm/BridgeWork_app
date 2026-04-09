from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from rest_framework_simplejwt.views import TokenObtainPairView
from django.conf.urls.static import static


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/users/', include('users.urls')),
    path('api/users/token/', TokenObtainPairView.as_view()),
    path('api/interact/', include('interact.urls')),
    path('api/chat/', include('chat.urls')),
    path('api/profiles/', include('profiles.urls')),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


