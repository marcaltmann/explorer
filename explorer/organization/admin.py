from django.contrib import admin

from .models import Folder, FolderItem, Series, SeriesItem, Tag


class FolderItemInline(admin.TabularInline):
    model = FolderItem
    extra = 0


class SeriesItemInline(admin.TabularInline):
    model = SeriesItem
    fk_name = 'series'
    extra = 0


@admin.register(Folder)
class FolderAdmin(admin.ModelAdmin):
    list_display = ('name', 'library', 'parent')
    list_filter = ('library',)
    search_fields = ('name',)
    inlines = [FolderItemInline]


@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ('name', 'library')
    list_filter = ('library',)
    search_fields = ('name',)
    filter_horizontal = ('resources',)


@admin.register(Series)
class SeriesAdmin(admin.ModelAdmin):
    list_display = ('name', 'library')
    list_filter = ('library',)
    search_fields = ('name',)
    inlines = [SeriesItemInline]
