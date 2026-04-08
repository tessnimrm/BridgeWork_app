from django.contrib import admin
from .models import WorkerProfile,EmployerProfile

# Register your models here.
@admin.register(WorkerProfile)
class WorkerProfileAdmin(admin.ModelAdmin):
  list_display = ["user","skills","availability"]
  search_fields = ["user__username","skills","availability"]
  ordering = ["user"]
  fieldsets =(
    ("basic info",{"fields":("user","skills","availability")}),
    ("profile details",{"fields":("bio","education","experience")}
    ),
  )
@admin.register(EmployerProfile)
class EmployerProfiledelAdmin(admin.ModelAdmin):
  list_display = ["company_name","availability_needed"]
  search_fields = ["company_name","availability_needed"]
  ordering = ["company_name"]
  fieldsets =(
        ( "company info",{"fields":("company_name"," availability_needed")}),
     ("more details",{"fields":("servicesn","about_company")}),
  )
  

