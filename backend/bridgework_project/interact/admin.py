from django.contrib import admin
from .models import Interested, Favorite

@admin.register(Interested)
class InterestedAdmin(admin.ModelAdmin):
    list_display  = ['from_user', 'to_user', 'created']
    search_fields = ['from_user__email', 'to_user__email']
    ordering      = ['-created']

@admin.register(Favorite)
class FavoriteAdmin(admin.ModelAdmin):
    list_display  = ['user', 'saved_user', 'created']
    search_fields = ['user__email', 'saved_user__email']
    ordering      = ['-created']
