from django.conf.urls import url

from flag import views

# 将网址映射成一个视图函数：前面是网址；后面是函数
urlpatterns = [
    url('add_container', views.add_container),
    url('delete_container', views.delete_container),
    url('update_container', views.update_container),
    url('get_container', views.get_container),
    url('add_flag', views.add_flag),
    url('delete_flag', views.delete_flag),
    url('update_flag', views.update_flag),
    url('get_flag', views.get_flag),
]
