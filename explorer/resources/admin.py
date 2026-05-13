from django.contrib import admin

from .models import AudioFile, DocumentFile, ImageFile, Resource, VideoFile


class VideoFileInline(admin.StackedInline):
    model = VideoFile
    extra = 0


class AudioFileInline(admin.StackedInline):
    model = AudioFile
    extra = 0


class ImageFileInline(admin.StackedInline):
    model = ImageFile
    extra = 0


class DocumentFileInline(admin.StackedInline):
    model = DocumentFile
    extra = 0


@admin.register(Resource)
class ResourceAdmin(admin.ModelAdmin):
    list_display = ('name', 'type', 'library', 'production_date')
    list_filter = ('type', 'library')
    search_fields = ('name',)
    inlines = [VideoFileInline, AudioFileInline, ImageFileInline, DocumentFileInline]
