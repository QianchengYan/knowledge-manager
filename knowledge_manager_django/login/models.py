from django.db import models

# Create your models here.
class User(models.Model):
    # 用户唯一ID，自增
    id = models.AutoField(primary_key=True)
    # 用户基本信息 姓名、用户名、密码、手机号
    name = models.CharField(null=False, max_length=20)  # 名字可重复
    username = models.CharField(null=False, max_length=20, unique=True)
    password = models.CharField(null=False, max_length=20)
    phone = models.CharField(null=False, max_length=20)
    email = models.CharField(null=False, max_length=50)