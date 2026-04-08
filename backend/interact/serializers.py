from rest_framework import serializers
from .models import Interested, Favorite
from users.models import User

class UserCardSerializer(serializers.ModelSerializer):
    class Meta:
        model  = User
        fields = ['id', 'email', 'fullname', 'role']


class InterestedSerializer(serializers.ModelSerializer):
    from_user = UserCardSerializer(read_only=True)
    to_user   = UserCardSerializer(read_only=True)

    class Meta:
        model  = Interested
        fields = ['id', 'from_user', 'to_user', 'created']


class FavoriteSerializer(serializers.ModelSerializer):
    saved_user = UserCardSerializer(read_only=True)

    class Meta:
        model  = Favorite
        fields = ['id', 'saved_user', 'created']