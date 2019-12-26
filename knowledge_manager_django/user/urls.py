from django.conf.urls import url

from user import views

# 将网址映射成一个视图函数：前面是网址；后面是函数
urlpatterns = [
    url('login', views.login),
    url('signup', views.signup),
    url('my_info', views.my_info),
    url('user_info', views.user_info),
    url('update', views.update),
]
