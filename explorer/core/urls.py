from django.urls import path

from . import views

app_name = "core"

urlpatterns = [
    path("", views.welcome, name="welcome"),
    path("accessibility/", views.accessibility, name="accessibility"),
    path("contact/", views.contact, name="contact"),
    path("legal-notice/", views.legal_notice, name="legal-notice"),
    path("privacy/", views.privacy, name="privacy"),
    path("terms/", views.terms, name="terms"),
]
