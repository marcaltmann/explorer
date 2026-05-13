from django.db import models
from django.utils.translation import gettext_lazy as _


class Resource(models.Model):
    class Type(models.TextChoices):
        VIDEO = 'video', _('Video')
        AUDIO = 'audio', _('Audio')
        IMAGE = 'image', _('Image')
        DOCUMENT = 'document', _('Document')

    library = models.ForeignKey(
        'library.Library',
        on_delete=models.CASCADE,
        related_name='resources',
    )
    type = models.CharField(max_length=20, choices=Type)
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    production_date = models.DateField(null=True, blank=True)

    class Meta:
        verbose_name = _('Resource')
        verbose_name_plural = _('Resources')

    def __str__(self):
        return self.name


class VideoFile(models.Model):
    resource = models.ForeignKey(
        Resource, on_delete=models.CASCADE, related_name='video_files'
    )
    filename = models.CharField(max_length=255)
    format = models.CharField(max_length=50, blank=True)
    codec = models.CharField(max_length=50, blank=True)
    resolution = models.CharField(max_length=20, blank=True)
    fps = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    duration = models.DurationField(null=True, blank=True)
    filesize = models.PositiveBigIntegerField(null=True, blank=True)

    class Meta:
        verbose_name = _('Video file')
        verbose_name_plural = _('Video files')

    def __str__(self):
        return self.filename


class AudioFile(models.Model):
    resource = models.ForeignKey(
        Resource, on_delete=models.CASCADE, related_name='audio_files'
    )
    filename = models.CharField(max_length=255)
    format = models.CharField(max_length=50, blank=True)
    codec = models.CharField(max_length=50, blank=True)
    bitrate = models.PositiveIntegerField(null=True, blank=True)
    duration = models.DurationField(null=True, blank=True)
    filesize = models.PositiveBigIntegerField(null=True, blank=True)

    class Meta:
        verbose_name = _('Audio file')
        verbose_name_plural = _('Audio files')

    def __str__(self):
        return self.filename


class ImageFile(models.Model):
    resource = models.ForeignKey(
        Resource, on_delete=models.CASCADE, related_name='image_files'
    )
    filename = models.CharField(max_length=255)
    format = models.CharField(max_length=50, blank=True)
    width = models.PositiveIntegerField(null=True, blank=True)
    height = models.PositiveIntegerField(null=True, blank=True)
    filesize = models.PositiveBigIntegerField(null=True, blank=True)

    class Meta:
        verbose_name = _('Image file')
        verbose_name_plural = _('Image files')

    def __str__(self):
        return self.filename


class DocumentFile(models.Model):
    resource = models.ForeignKey(
        Resource, on_delete=models.CASCADE, related_name='document_files'
    )
    filename = models.CharField(max_length=255)
    format = models.CharField(max_length=50, blank=True)
    page_count = models.PositiveIntegerField(null=True, blank=True)
    filesize = models.PositiveBigIntegerField(null=True, blank=True)

    class Meta:
        verbose_name = _('Document file')
        verbose_name_plural = _('Document files')

    def __str__(self):
        return self.filename
