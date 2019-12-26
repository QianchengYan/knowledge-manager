from django.db import models


class UserManager(models.Manager):
    pass


# Create your models here.
class User(models.Model):
    class Meta:
        db_table = 'User'

    # 用户唯一ID，自增
    id = models.AutoField(primary_key=True)
    # 用户基本信息 姓名、用户名、密码、手机号
    username = models.CharField(null=False, max_length=20, unique=True)
    password = models.CharField(null=False, max_length=20)
    name = models.CharField(null=False, max_length=20)  # 名字可重复
    avatar_url = models.CharField(null=True, max_length=100)
    phone = models.CharField(null=True, max_length=20)
    email = models.CharField(null=True, max_length=50)

    manager = UserManager()

    def get_my_info(self):
        return {
            'id': self.id,
            'username': self.username,
            'name': self.name,
            'avatar_url': self.avatar_url,
            'phone': self.phone,
            'email': self.email,
        }

    def get_user_info(self):
        return {
            'id': self.id,
            'username': self.username,
            'name': self.name,
            'avatar_url': self.avatar_url,
        }