from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User

@admin.register(User)
class CustomUserAdmin(UserAdmin):
    list_display  = ['email', 'username','fullname']
    search_fields = ['email', 'username']
    ordering      = ['email','fullname']



    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'username','fullname', 'password1', 'password2'),
        }),
    )

    fieldsets = UserAdmin.fieldsets + ((None, {'fields': ('fullname',)}),)
        
    




    
