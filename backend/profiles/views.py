
from rest_framework.response import Response
from rest_framework.decorators import api_view ,permission_classes
from  rest_framework.permissions import IsAuthenticate
from .models import WorkerProfile, EmployerProfile
from .serializers import  WorkerProfileSerializer, EmployerProfileSerializer
from users.models import User
#get and update wprofile   
@api_view(["GET","PUT"])    
@permission_classes([IsAuthenticate])
def worker_profile(request):
    profil, created = WorkerProfile.objectsget_or_create( user=request.user)
    if request.method == "GET":
      serializer =  WorkerProfileSerializer(profil)
      return Response(serializer.data)
    if request.method =="PUT":
       serializer = WorkerProfileSerializer(profil,dara=request.data,partial=True)
       if serializer.is_valid():
           serializer.save()
           return Response(serializer.data) 

    return Response(serializer.errors)
   
#get and update Eprofile
@api_view(["GET","PUT"])    
@permission_classes([IsAuthenticate])
def employer_profile(request):
    profil, created = EmployerProfile.objectsget_or_create( user=request.user)
    if request.method == "GET":
      serializer =  EmployerProfileSerializer(profil)
      return Response(serializer.data)
    if request.method =="PUT":
       serializer = EmployerProfileSerializer(profil,dara=request.data,partial=True)
       if serializer.is_valid():
           serializer.save()
           return Response(serializer.data) 

    return Response(serializer.errors)
       
#switch mode
@api_view(["POST"])
@permission_classes([IsAuthenticate])
def switch_mode(request):
   mode = request.data.get("mode")
   if  mode == "worker":
      WorkerProfile.objectsget_or_create( user=request.user)
   if mode == "employer":
       EmployerProfile.objectsget_or_create( user=request.user)
   return Response({"message":"Mode Switched"})

#view someone profile
@api_view(["GET"])    
def view_profile(request,id):
   user = User.objects.get(id=id)
   worker =  WorkerProfile.objects.filter(user=user).first()
   employer = EmployerProfile.objects.filter(user=user).first()
   if worker:
      serializer = WorkerProfileSerializer(worker)
      return Response(serializer.data)
   if employer:
      serializer = EmployerProfileSerializer(employer)
      return Response(serializer.data)
   return Response({"error":"profile not found"})


