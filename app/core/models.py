from django.db import models


class Sample(models.Model):
    # models.FileField() files uploaded by users
    attachment = models.FileField()
