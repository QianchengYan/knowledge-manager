### linux相关操作

**1. linux运行django，如何杀掉**

```
netstat -lnp|grep 8000 // 查看哪个端口在占用8000
结果：
root@izuf64w3dmoozw957twotbz knowledge_manager_django # netstat -lnp|grep 8000
tcp        0      0 0.0.0.0:8000            0.0.0.0:*               LISTEN      17175/python3
```

然后

```
kill -9 17175
```

**2. linux 上使用 screen**

```
新建screen
screen -S name // name 自定义

查看screen
screen -ls

切换screen
screen -r xxx // xxx是list出来的screen前面的编号
screen -r -S name // name是list出来的screen后面的名字
screen -d -r xxx //踢掉ateched

中止screen
exit 或 快捷键：Ctrl+d
```

### Django命令

django常用命令
1、创建项目命令：django-admin startproject demo
2、创建应用命令：python3 manage.py startapp demo
3、运行服务器命令：python3 manage.py runsever 
(runserver 后面可以跟地址:端口号，如果不写默认本地8000端口启动)
4、生成数据迁移文件：python3 manage.py makemigrations
5、迁移数据：python3 manage.py migrate
6、创建管理员命令：python3 manage.py createsuperuser
根据提示输入账号、密码

**1. 自动构建app文件夹**

```
python manage.py startapp xxxxx
```
**2. 数据库初始化**

```
python manage.py makemigrations 
python manage.py migrate # 生成数据表
```

### ORM

**1. 外键的使用**

```python
user_username = models.ForeignKey(to="user.User", # user:(app名（文件夹名为user）) User:(model名)
                             to_field="username", # 字段名（User中的username字段）
                             on_delete=models.CASCADE) # 关联删除
```

外键这个字段命名特别坑，它只有在model定义时是，`user_name` ，其他任何地方使用都需要用 `user_username_id`

**2. 如何优雅得传querySet中查询结果**

`model.py`

```python
# Create your models here.
class Task(models.Model):
    xxxx
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
```

`view.py`

```python
tasks = models.Task.manager.filter(user_username_id=user_username)
task_list = [i.get_task() for i in tasks]
params = {
    'data': task_list,
    'success': True,
    'message': '用户信息获取成功',
}
return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                    content_type='application/json;charset=utf-8')
```

