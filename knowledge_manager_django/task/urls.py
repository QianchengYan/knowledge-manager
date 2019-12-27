from django.conf.urls import url

from task import views

# 将网址映射成一个视图函数：前面是网址；后面是函数
urlpatterns = [
    url('add', views.add),
    url('delete', views.delete),
    url('update', views.update),
    url('get', views.get),
]
