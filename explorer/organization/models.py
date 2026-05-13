from django.db import models
from django.utils.translation import gettext_lazy as _


class Folder(models.Model):
    library = models.ForeignKey(
        'library.Library',
        on_delete=models.CASCADE,
        related_name='folders',
    )
    parent = models.ForeignKey(
        'self',
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name='children',
    )
    name = models.CharField(max_length=255)

    class Meta:
        verbose_name = _('Folder')
        verbose_name_plural = _('Folders')

    def __str__(self):
        return self.name


class FolderItem(models.Model):
    resource = models.OneToOneField(
        'resources.Resource',
        on_delete=models.CASCADE,
        related_name='folder_item',
    )
    folder = models.ForeignKey(Folder, on_delete=models.CASCADE, related_name='items')

    class Meta:
        verbose_name = _('Folder item')
        verbose_name_plural = _('Folder items')


class Tag(models.Model):
    library = models.ForeignKey(
        'library.Library',
        on_delete=models.CASCADE,
        related_name='tags',
    )
    name = models.CharField(max_length=100)
    resources = models.ManyToManyField(
        'resources.Resource',
        blank=True,
        related_name='tags',
    )

    class Meta:
        verbose_name = _('Tag')
        verbose_name_plural = _('Tags')

    def __str__(self):
        return self.name


class Series(models.Model):
    library = models.ForeignKey(
        'library.Library',
        on_delete=models.CASCADE,
        related_name='series',
    )
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True)

    class Meta:
        verbose_name = _('Series')
        verbose_name_plural = _('Series')

    def __str__(self):
        return self.name


class SeriesItem(models.Model):
    series = models.ForeignKey(Series, on_delete=models.CASCADE, related_name='items')
    resource = models.ForeignKey(
        'resources.Resource',
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name='series_items',
    )
    child_series = models.ForeignKey(
        Series,
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name='parent_items',
    )
    order = models.PositiveIntegerField()

    class Meta:
        verbose_name = _('Series item')
        verbose_name_plural = _('Series items')
        ordering = ['order']
        constraints = [
            models.CheckConstraint(
                condition=(
                    models.Q(resource__isnull=False, child_series__isnull=True)
                    | models.Q(resource__isnull=True, child_series__isnull=False)
                ),
                name='series_item_exactly_one_target',
            )
        ]
