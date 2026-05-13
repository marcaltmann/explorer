from django.db import models
from django.utils.translation import gettext_lazy as _


class Library(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = _('Library')
        verbose_name_plural = _('Libraries')

    def __str__(self):
        return self.name
