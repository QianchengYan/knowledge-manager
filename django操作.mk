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
2、创建应用命令：python manage.py startapp demo
3、运行服务器命令：python manage.py runsever 
(runserver 后面可以跟地址:端口号，如果不写默认本地8000端口启动)
4、生成数据迁移文件：python manage.py makemigrations
5、迁移数据：python manage.py migrate
6、创建管理员命令：python manage.py createsuperuser
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