from rest_framework import serializers
from .models import WorkerProfile, EmployerProfile

class WorkerProfileSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()
    avatar = serializers.ImageField(source='user.avatar', read_only=True)

    class Meta:
        model = WorkerProfile
        fields = [
            'id', 'full_name', 'bio', 'avatar', 'cv_file', 
            'education', 'experience', 'availability', 'skills'
        ]
        read_only_fields = ['full_name','avatar']

    def get_full_name(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"


class EmployerProfileSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()
    avatar = serializers.ImageField(source='user.avatar', read_only=True)

    class Meta:
        model = EmployerProfile
        fields = [
            'id', 'full_name', 'company_name', 'company_logo',
            'about_company', 'services', 'achievements', 'availability_needed'
        ]
        read_only_fields = ['full_name','avatar']

    def get_full_name(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"










