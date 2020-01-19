# 前端

lib/model/schedule/Task.dart
lib/model/schedule/Task.g.dart
lib/model/schedule/TaskList.dart

lib/dao/schedule/task_dao.dart

lib/pages/schedule/schedule_page.dart
lib/pages/schedule/task_edit_dialog.dart

## models设计



## dao设计



## pages设计



# 后端

task/models.py

task/urls.py

task/views.py



## models设计

### 1 Task类

#### 1.1 表名

`Task`

#### 1.2 属性

属性名|解释|字段
-|-|-
id||AutoField(primary_key=True)
image_url|图标|models.CharField(null=True, max_length=100)
title|标题|CharField(null=True, max_length=40, default="未命名")
description|描述|CharField(null=True, max_length=400, default="没有描述~")
start_time|开始时间|CharField(null=True, max_length=40)
end_time|结束时间|CharField(null=True, max_length=40)
status|状态|IntegerField(choices=((0, '待完成'), (1, '已完成'), (-1, '超时')), default=0, null=True)
note|完成笔记|CharField(null=True, max_length=20)
user_username|用户名|ForeignKey(to="user.User",to_field="username",related_name="user_task", on_delete=models.CASCADE,null=False)

#### 1.3 方法

`get_task`

> ```python
> def get_task(self):
>     return {
>         'id': self.id,
>         'imageUrl': self.image_url,
>         'title': self.title,
>         'description': self.description,
>         'startTime': self.start_time,
>         'endTime': self.end_time,
>         'status': self.status,
>         'note': self.note,
>         'user_username': self.user_username_id,
>     }
> ```



## urls设计

#### 1 父url映射

文件 `knowledge_manager_django/urls.py`

```python
urlpatterns = [
    url('api/task/', include('task.urls')),
```

#### 2 子url映射

文件 `task/urls.py`

```python
urlpatterns = [
    url('add', views.add),
    url('delete', views.delete),
    url('update', views.update),
    url('get', views.get),
]
```



## views设计

#### 1 方法总览

方法名|方法描述
-|-
add|增加task卡片
delete|删除task卡片
update|更新task卡片
get|查询task卡片

#### 2 方法具体实现






