from django.conf import settings
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('accounts/', include('allauth.urls')),
]

if settings.DJANGO_ENV == 'development':
    urlpatterns.append(path('__debug__/', include('debug_toolbar.urls')))
