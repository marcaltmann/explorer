import datetime

from django.core.management.base import BaseCommand

from explorer.library.models import Library
from explorer.organization.models import Folder, FolderItem, Series, SeriesItem, Tag
from explorer.resources.models import AudioFile, DocumentFile, ImageFile, Resource, VideoFile


class Command(BaseCommand):
    help = 'Seed the database with sample data for development'

    def add_arguments(self, parser):
        parser.add_argument(
            '--clear',
            action='store_true',
            help='Delete existing data before seeding',
        )

    def handle(self, *args, **options):
        if options['clear']:
            Library.objects.all().delete()
            self.stdout.write('Cleared existing data.')

        lib = Library.objects.create(
            name='Nature Documentary Archive',
            description='A collection of nature and wildlife documentary material.',
        )

        # --- Resources ---
        video1 = Resource.objects.create(
            library=lib,
            type=Resource.Type.VIDEO,
            name='Arctic Wolf Pack',
            description='Tracking a wolf pack across the frozen tundra.',
            production_date=datetime.date(2023, 3, 15),
        )
        VideoFile.objects.create(
            resource=video1,
            filename='arctic_wolf_pack_4k.mp4',
            format='MP4',
            codec='H.264',
            resolution='3840x2160',
            fps=25,
            duration=datetime.timedelta(minutes=52, seconds=18),
            filesize=18_432_000_000,
        )

        video2 = Resource.objects.create(
            library=lib,
            type=Resource.Type.VIDEO,
            name='Migration: The Great Wildebeest',
            description='Annual migration across the Serengeti.',
            production_date=datetime.date(2022, 8, 1),
        )
        VideoFile.objects.create(
            resource=video2,
            filename='wildebeest_migration_hd.mp4',
            format='MP4',
            codec='H.265',
            resolution='1920x1080',
            fps=50,
            duration=datetime.timedelta(minutes=47, seconds=5),
            filesize=6_200_000_000,
        )

        audio1 = Resource.objects.create(
            library=lib,
            type=Resource.Type.AUDIO,
            name='Rainforest Ambience',
            description='Field recording from the Amazon basin at dawn.',
            production_date=datetime.date(2023, 6, 20),
        )
        AudioFile.objects.create(
            resource=audio1,
            filename='amazon_dawn_ambience.wav',
            format='WAV',
            codec='PCM',
            bitrate=1411,
            duration=datetime.timedelta(minutes=30),
            filesize=317_520_000,
        )

        image1 = Resource.objects.create(
            library=lib,
            type=Resource.Type.IMAGE,
            name='Snow Leopard Portrait',
            description='Close-up portrait taken in the Himalayas.',
            production_date=datetime.date(2023, 1, 8),
        )
        ImageFile.objects.create(
            resource=image1,
            filename='snow_leopard_portrait.tiff',
            format='TIFF',
            width=6000,
            height=4000,
            filesize=72_000_000,
        )

        doc1 = Resource.objects.create(
            library=lib,
            type=Resource.Type.DOCUMENT,
            name='Production Script – Wolf Pack',
            description='Final shooting script for the Arctic Wolf Pack episode.',
            production_date=datetime.date(2022, 11, 30),
        )
        DocumentFile.objects.create(
            resource=doc1,
            filename='arctic_wolf_pack_script_final.pdf',
            format='PDF',
            page_count=38,
            filesize=2_400_000,
        )

        # --- Folders ---
        footage = Folder.objects.create(library=lib, name='Footage')
        audio_folder = Folder.objects.create(library=lib, name='Audio')
        images_folder = Folder.objects.create(library=lib, name='Images')
        docs_folder = Folder.objects.create(library=lib, name='Documents')

        arctic = Folder.objects.create(library=lib, parent=footage, name='Arctic')
        africa = Folder.objects.create(library=lib, parent=footage, name='Africa')

        FolderItem.objects.create(folder=arctic, resource=video1)
        FolderItem.objects.create(folder=africa, resource=video2)
        FolderItem.objects.create(folder=audio_folder, resource=audio1)
        FolderItem.objects.create(folder=images_folder, resource=image1)
        FolderItem.objects.create(folder=docs_folder, resource=doc1)

        # --- Tags ---
        tag_wildlife = Tag.objects.create(library=lib, name='wildlife')
        tag_wildlife.resources.set([video1, video2, image1])

        tag_arctic = Tag.objects.create(library=lib, name='arctic')
        tag_arctic.resources.set([video1])

        tag_africa = Tag.objects.create(library=lib, name='africa')
        tag_africa.resources.set([video2, audio1])

        tag_4k = Tag.objects.create(library=lib, name='4K')
        tag_4k.resources.set([video1])

        # --- Series ---
        series = Series.objects.create(
            library=lib,
            name='Wild Earth – Season 1',
            description='A three-part series exploring extreme environments.',
        )
        SeriesItem.objects.create(series=series, resource=video1, order=1)
        SeriesItem.objects.create(series=series, resource=video2, order=2)

        self.stdout.write(self.style.SUCCESS(
            f'Seeded library "{lib.name}" with '
            f'{Resource.objects.filter(library=lib).count()} resources, '
            f'{Folder.objects.filter(library=lib).count()} folders, '
            f'{Tag.objects.filter(library=lib).count()} tags, '
            f'{Series.objects.filter(library=lib).count()} series.'
        ))
