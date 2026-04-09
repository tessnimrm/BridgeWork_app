from rest_framework import serializers
from .models import User

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=6)

    class Meta:
        model  = User
        fields = ['email', 'username', 'password']
        extra_kwargs = {
            'email'    : {'required': True},
            'username' : {'required': True},
            'password' : {'required': True},
            'fullname' : {'required': True},
        }



    def validate_email(self, value):
        if '@' not in value or '.' not in value:
            raise serializers.ValidationError("Enter a valid email")
        return value

    def create(self, validated_data):
        user = User.objects.create_user(
            email    = validated_data['email'],
            username = validated_data['username'],
            password = validated_data['password'],
            fullname = validated_data['fullname'],

        )
        return user
    
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model  = User
        fields = ['id', 'email', 'username', 'fullname']


class LoginSerializer(serializers.Serializer):
    email    = serializers.EmailField(required=True)
    password = serializers.CharField(required=True)


class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True,min_length=6)
    new_password = serializers.CharField(required=True, min_length=6)


class SetRoleSerializer(serializers.Serializer):
    role = serializers.ChoiceField(choices=['jobseeker', 'employer'])

class SetCategoriesSerializer(serializers.Serializer):
    categories = serializers.ListField(
        child=serializers.ChoiceField(choices=[
            'Tech&Digital',
            'Retail',
            'Hospitality',
            'Education',
            'Cooking',
        ]),
        min_length=1
    )