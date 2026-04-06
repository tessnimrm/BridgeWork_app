from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status

from profiles.serializers import WorkerProfileSerializer,EmployerProfileSerializer  
from .models import Interested, Favorite
from .serializers import InterestedSerializer, FavoriteSerializer
from users.models import User
from profiles.models import WorkerProfile, EmployerProfile



@api_view(['POST'])
@permission_classes([IsAuthenticated])
def send_interested(request, user_id):
    # 1. check target user exists
    try:
        to_user = User.objects.get(id=user_id)
    except User.DoesNotExist:
        return Response(
            {'error': 'User not found'},
            status=status.HTTP_404_NOT_FOUND
        )

    # 2. can't send to yourself
    if request.user == to_user:
        return Response(
            {'error': 'You cannot send Interested to yourself'},
            status=status.HTTP_400_BAD_REQUEST
        )

    # 3. check roles are opposite
    if request.user.role == to_user.role:
       return Response(
        {'error': 'You can only send Interested to the opposite role'},
        status=status.HTTP_400_BAD_REQUEST
    )

    # 4. check already sent
    if Interested.objects.filter(from_user=request.user, to_user=to_user).exists():
        return Response(
            {'error': 'Already sent Interested'},
            status=status.HTTP_400_BAD_REQUEST
        )


    # 5. create interested
    Interested.objects.create(from_user=request.user, to_user=to_user)

    # 6. check if mutual → open chat
    is_mutual = Interested.objects.filter(
        from_user=to_user,
        to_user=request.user
    ).exists()

    if is_mutual:
        return Response(
            {'details': 'Interested sent ✅ Mutual match! Chat opened 🎉'},
            status=status.HTTP_201_CREATED
        )

    return Response(
        {'details': 'Interested sent ✅'},
        status=status.HTTP_201_CREATED
    )


@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def remove_interested(request, user_id):
    try:
        interested = Interested.objects.get(
            from_user=request.user,
            to_user__id=user_id
        )
        interested.delete()
        return Response(
            {'details': 'Interested removed ✅'},
            status=status.HTTP_200_OK
        )
    except Interested.DoesNotExist:
        return Response(
            {'error': 'Interested not found'},
            status=status.HTTP_404_NOT_FOUND
        )




@api_view(['POST'])
@permission_classes([IsAuthenticated])
def add_favorite(request, user_id):
    try:
        saved_user = User.objects.get(id=user_id)
    except User.DoesNotExist:
        return Response(
            {'error': 'User not found'},
            status=status.HTTP_404_NOT_FOUND
        )

    # can't save yourself
    if request.user == saved_user:
        return Response(
            {'error': 'You cannot favorite yourself'},
            status=status.HTTP_400_BAD_REQUEST
        )

    # check already saved
    if Favorite.objects.filter(user=request.user, saved_user=saved_user).exists():
        return Response(
            {'error': 'Already in favorites'},
            status=status.HTTP_400_BAD_REQUEST
        )

    Favorite.objects.create(user=request.user, saved_user=saved_user)
    return Response(
        {'details': 'Added to favorites ✅'},
        status=status.HTTP_201_CREATED
    )


@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def remove_favorite(request, user_id):
    try:
        favorite = Favorite.objects.get(
            user=request.user,
            saved_user__id=user_id
        )
        favorite.delete()
        return Response(
            {'details': 'Removed from favorites ✅'},
            status=status.HTTP_200_OK
        )
    except Favorite.DoesNotExist:
        return Response(
            {'error': 'Favorite not found'},
            status=status.HTTP_404_NOT_FOUND
        )


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def list_favorites(request):
    favorites  = Favorite.objects.filter(user=request.user)
    serializer = FavoriteSerializer(favorites, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def home_feed(request):
    user     = request.user
    category = request.query_params.get('category', None)
    search   = request.query_params.get('search', None)

    if not user.role:
        return Response(
            {'error': 'Please set your role first'},
            status=status.HTTP_400_BAD_REQUEST
        )

    
    if not category:
        if user.categories:
            category = user.categories[0]  # أول category
        else:
            category = 'Tech&Digital'  # default

    valid_categories = ['Tech&Digital', 'Retail', 'Hospitality', 'Education', 'Cooking', 'Delivery']
    if category not in valid_categories:
        return Response(
            {'error': f'Category must be one of: {valid_categories}'},
            status=status.HTTP_400_BAD_REQUEST
        )

   
    if user.role == 'jobseeker':
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

    
    elif user.role == 'employer':
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
        'category'          : category,
        'your_categories'   : user.categories,
        'results'           : serializer.data
    }, status=status.HTTP_200_OK)

