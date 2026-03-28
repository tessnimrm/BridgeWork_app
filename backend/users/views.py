from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import make_password
from .serializers import LoginSerializer, RegisterSerializer, SetRoleSerializer, UserSerializer,ChangePasswordSerializer
from .models import User
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from google.auth.transport import requests as google_requests
from django.conf import settings
from google.oauth2 import id_token
from profiles.models import WorkerProfile, EmployerProfile
from profiles.serializers import WorkerProfileSerializer, EmployerProfileSerializer

@api_view(['POST'])
def register(request):
    data = request.data
    serializer = RegisterSerializer(data=data)

    if serializer.is_valid():
        if not User.objects.filter(email=data['email']).exists():
            User.objects.create_user(
                email    = data['email'],
                username = data['username'],
                password = data['password'],
                fullname = data['fullname'],
            )
            return Response(
                {'details': 'Your account registered successfully!'},
                status=status.HTTP_201_CREATED
            )
        else:
            return Response(
                {'error': 'This email already exists!'},
                status=status.HTTP_400_BAD_REQUEST
            )
    else:
        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )
    


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def current_user(request):
    user = UserSerializer(request.user, many=False)
    return Response(user.data)


@api_view(['POST'])
def login(request):
    data       = request.data
    serializer = LoginSerializer(data=data)

    if serializer.is_valid():
        # 1 check if email exists
        try:
            user = User.objects.get(email=data['email'])
        except User.DoesNotExist:
            return Response(
                {'error': 'Email not found'},
                status=status.HTTP_404_NOT_FOUND
            )

        # 2 check password
        user = authenticate(email=data['email'], password=data['password'])
        if user is None:
            return Response(
                {'error': 'Wrong password'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # 3 generate token
        refresh = RefreshToken.for_user(user)
        return Response({
            'details' : 'Login successful ✅',
            'token'   : str(refresh.access_token),
            'refresh' : str(refresh),
            'user'    : {
                'id'      : user.id,
                'email'   : user.email,
                'username': user.username,
                'fullname': user.fullname,
            }
        }, status=status.HTTP_200_OK)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def logout(request):
    try:
        refresh_token = request.data.get('refresh')
        token = RefreshToken(refresh_token)
        token.blacklist()
        return Response(
            {'details': 'Logout successful ✅'},
            status=status.HTTP_200_OK
        )
    except Exception as e:
        return Response(
            {'error': 'Something went wrong'},
            status=status.HTTP_400_BAD_REQUEST
        )
    
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def change_password(request):
    data       = request.data
    serializer = ChangePasswordSerializer(data=data)

    if serializer.is_valid():
        # 1. check passwords match
        if data['new_password'] != data['confirm_password']:
            return Response(
                {'error': 'Passwords do not match'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # 2. set new password
        user = request.user
        user.set_password(data['new_password'])
        user.save()

        return Response(
            {'details': 'Password changed successfully ✅'},
            status=status.HTTP_200_OK
        )

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)




@api_view(['POST'])
@permission_classes([IsAuthenticated])
def setRole(request):
    serializer = SetRoleSerializer(data=request.data)

    if serializer.is_valid():
        user = request.user
        user.role = serializer.validated_data['role']
        user.save()
        return Response(
            {'details': f'Role set to {user.role} ✅'},
            status=status.HTTP_200_OK
        )

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def guest_access(request):
    return Response({
        'details': 'Welcome as guest 👋',
    }, status=status.HTTP_200_OK)


@api_view(['POST'])
def guest_set_role(request):
    role = request.data.get('role', None)

    if not role:
        return Response(
            {'error': 'Please choose work or hire'},
            status=status.HTTP_400_BAD_REQUEST
        )

    if role not in ['jobseeker', 'employer']:
        return Response(
            {'error': 'Role must be jobseeker or employer'},
            status=status.HTTP_400_BAD_REQUEST
        )

    return Response({
        'details': f'Role set to {role} ✅',
        'role'   : role,
        'note'   : 'Register to use Interested, Favorite and Chat',
    }, status=status.HTTP_200_OK)


@api_view(['GET'])
def guest_home(request):
    role     = request.query_params.get('role', None)
    category = request.query_params.get('category', 'Tech&Digital')
    search   = request.query_params.get('search', None)

    if not role:
        return Response(
            {'error': 'Please choose work or hire'},
            status=status.HTTP_400_BAD_REQUEST
        )

    if role not in ['jobseeker', 'employer']:
        return Response(
            {'error': 'Role must be jobseeker or employer'},
            status=status.HTTP_400_BAD_REQUEST
        )

    valid_categories = ['Tech&Digital', 'Retail', 'Hospitality', 'Education']
    if category not in valid_categories:
        return Response(
            {'error': f'Category must be one of: {valid_categories}'},
            status=status.HTTP_400_BAD_REQUEST
        )

  

    if role == 'jobseeker':
        profiles = EmployerProfile.objects.filter(
            category__icontains=category
        )
        if search:
            profiles = profiles.filter(
                company_name__icontains=search
            ) | profiles.filter(
                about_company__icontains=search
            )
        serializer = EmployerProfileSerializer(profiles, many=True)

    elif role == 'employer':
        profiles = WorkerProfile.objects.filter(
            category__icontains=category
        )
        if search:
            profiles = profiles.filter(
                user__fullname__icontains=search
            ) | profiles.filter(
                bio__icontains=search
            )
        serializer = WorkerProfileSerializer(profiles, many=True)

    return Response({
        'category': category,
        'results' : serializer.data,
        'note'    : 'Register to use Interested, Favorite and Chat'
    }, status=status.HTTP_200_OK)



@api_view(['POST'])
def google_login(request):
    token = request.data.get('token')

    if not token:
        return Response(
            {'error': 'Token is required'},
            status=status.HTTP_400_BAD_REQUEST
        )

    try:
        # 1. verify google token
        google_info = id_token.verify_oauth2_token(
            token,
            google_requests.Request(),
            settings.GOOGLE_CLIENT_ID
        )

        email    = google_info['email']
        fullname = google_info.get('name', '')

        # 2. get or create user
        user, created = User.objects.get_or_create(
            email=email,
            defaults={
                'username': email.split('@')[0],
                'fullname': fullname,
            }
        )

        # 3. generate token
        refresh = RefreshToken.for_user(user)
        return Response({
            'details' : 'Google login successful ✅',
            'token'   : str(refresh.access_token),
            'refresh' : str(refresh),
            'created' : created,  # True = new user, False = existing user
            'user'    : {
                'id'      : user.id,
                'email'   : user.email,
                'username': user.username,
                'fullname': user.fullname,
                'role'    : user.role,
            }
        }, status=status.HTTP_200_OK)

    except ValueError:
        return Response(
            {'error': 'Invalid Google token'},
            status=status.HTTP_400_BAD_REQUEST
        )