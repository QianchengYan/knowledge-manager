from django.db import models
import json


class FlagContainerManager(models.Manager):
    pass


# Create your models here.
class FlagContainer(models.Model):
    class Meta:
        db_table = 'FlagContainer'

    # 唯一ID，自增
    id = models.AutoField(primary_key=True)
    title = models.CharField(null=True, max_length=40, default="未命名")
    description = models.CharField(null=True, max_length=400, default="没有描述~")
    start_time = models.CharField(null=True, max_length=40)
    end_time = models.CharField(null=True, max_length=40)
    status = models.IntegerField(choices=((0, '待完成'), (1, '已完成'), (-1, '超时')), default=0, null=True)
    note = models.CharField(null=True, max_length=20)
    user_username = models.ForeignKey(to="user.User",
                                 to_field="username",
                                 related_name="user_task",  # 反向操作时，使用的字段名，用于代替 【表名_set】 如： obj.表名_set.all()
                                 on_delete=models.CASCADE,
                                 null=False)

    manager = FlagContainerManager()

    def get_task(self):
        return {
            'id': self.id,
            'imageUrl': self.image_url,
            'title': self.title,
            'description': self.description,
            'startTime': self.start_time,
            'endTime': self.end_time,
            'status': self.status,
            'note': self.note,
            'user_username': self.user_username_id,
        }


class FlagManager(models.Manager):
    pass


# Create your models here.
class Flag(models.Model):
    class Meta:
        db_table = 'Flag'

    # 唯一ID，自增
    id = models.AutoField(primary_key=True)
    # 用户基本信息 姓名、用户名、密码、手机号
    image_url = models.CharField(null=True, max_length=100)
    title = models.CharField(null=True, max_length=40, default="未命名")
    description = models.CharField(null=True, max_length=400, default="没有描述~")
    start_time = models.CharField(null=True, max_length=40)
    end_time = models.CharField(null=True, max_length=40)
    status = models.IntegerField(choices=((0, '待完成'), (1, '已完成'), (-1, '超时')), default=0, null=True)
    note = models.CharField(null=True, max_length=20)
    user_username = models.ForeignKey(to="user.User",
                                 to_field="username",
                                 related_name="user_task",  # 反向操作时，使用的字段名，用于代替 【表名_set】 如： obj.表名_set.all()
                                 on_delete=models.CASCADE,
                                 null=False)

    manager = FlagManager()

    def get_task(self):
        return {
            'id': self.id,
            'imageUrl': self.image_url,
            'title': self.title,
            'description': self.description,
            'startTime': self.start_time,
            'endTime': self.end_time,
            'status': self.status,
            'note': self.note,
            'user_username': self.user_username_id,
        }