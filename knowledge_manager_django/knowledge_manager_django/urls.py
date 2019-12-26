"""knowledge_manager_django URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from user import views

urlpatterns = [
    path('admin/', admin.site.urls),


    # url(r'^api/user', views.user),

    # path('api/user', views.user),
    url('api/user/', include('user.urls')),
    # url('api/subject_group/', include('subject_group.urls')),
    # url('api/subject/', include('subject.urls')),
    # url('api/lecture/', include('lecture.urls')),
    # url('api/knowledge_node/', include('knowledge_node.urls')),
    # url('api/leaning_record/', include('leaning_record.urls')),
    # url('api/contact_group/', include('contact_group.urls')),
    # url('api/contact/', include('contact.urls')),
    # url('api/chating_record/', include('chating_record.urls')),
]
