
from django.db import models
from users.models import User

class Interested(models.Model):
    from_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_interests')
    to_user   = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_interests')
    created   = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('from_user', 'to_user')  # can't press twice

    def __str__(self):
        return f"{self.from_user} → {self.to_user}"


class Favorite(models.Model):
    user       = models.ForeignKey(User, on_delete=models.CASCADE, related_name='favorites')
    saved_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='saved_by')
    created    = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'saved_user')  # can't save twice

    def __str__(self):
        return f"{self.user} ♥ {self.saved_user}"
