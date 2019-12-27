from django.shortcuts import render, HttpResponse, redirect
from django.core import serializers
from django.http import JsonResponse

import json
from task import models


# Create your views here.

# 添加
def add(request):
    print("===============task/add:")
    if request.method == "POST":
        user = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        image_url = user.get('imageUrl', None)
        title = user.get('title', None)
        description = user.get('description', None)
        start_time = user.get('startTime', None)
        end_time = user.get('endTime', None)
        status = user.get('status', None)
        note = user.get('note', None)
        user_username_id = user.get('user_username', None)
        if status == None:
            status = 0
        if user_username_id:
            # try:
            task = models.Task.manager.create(image_url=image_url, title=title, description=description,
                                              start_time=start_time, end_time=end_time, status=status,
                                              note=note, user_username_id=user_username_id)
            params = {
                'data': task.get_task(),
                'success': True,
                'message': '添加任务成功',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')
        # except Exception:
        #     params = {
        #         'data': None,
        #         'success': False,
        #         'message': '数据库操作失败',
        #     }
        #     return HttpResponse(content=json.dumps(params, ensure_ascii=False),
        #                         content_type='application/json;charset=utf-8')

    print('请求错误')
    params = {
        'data': None,
        'success': False,
        'message': '请求错误',

    }
    return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                        content_type='application/json;charset=utf-8')


# 更改个人信息
def update(request):
    print("===============user/update:")
    if request.method == "POST":
        user = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        username = user.get('username', None)
        password = user.get('password', None)
        name = user.get('name', None)
        phone = user.get('phone', None)
        email = user.get('email', None)
        if username and password and name:
            user = models.User.manager.filter(username=username)
            if user:
                # 用户名存在
                user = user[0]
                user.password = password
                user.name = name
                user.phone = phone
                user.email = email
                user.save()
                params = {
                    'data': user.get_my_info(),
                    'success': True,
                    'message': '修改成功',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')

            else:
                params = {
                    'data': None,
                    'success': False,
                    'message': '用户名不存在',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')

    print('请求错误')
    params = {
        'data': None,
        'success': False,
        'message': '请求错误',

    }
    return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                        content_type='application/json;charset=utf-8')


def delete(request):
    return None


# 获取 task
# TODO：task的过滤，返回近期有效task/返回历史所有task
def get(request):
    print("===============task/get:")
    if request.method == "GET":
        print(request.GET)
        data = request.GET
        # data = json.loads(request.GET)
        user_username = data.get('user_username', None)
        if user_username:
            tasks = models.Task.manager.filter(user_username_id=user_username)
            task_list = [i.get_task() for i in tasks]
            params = {
                'data': task_list,
                'success': True,
                'message': '获取任务成功',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')

    print('请求错误')
    params = {
        'data': None,
        'success': False,
        'message': '请求错误',
    }
    return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                        content_type='application/json;charset=utf-8')

