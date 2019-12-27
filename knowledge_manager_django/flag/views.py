from django.shortcuts import render, HttpResponse, redirect
from django.core import serializers
from django.http import JsonResponse

import json
from flag import models


# Create your views here.

# 添加
def add_container(request):
    print("===============task/add:")
    if request.method == "POST":
        data = json.loads(request.body.decode())
        title = data.get('title', None)
        description = data.get('description', None)
        start_time = data.get('startTime', None)
        total_days = data.get('totalDays', None)
        finished_days = 0
        user_username_id = data.get('user_username', None)

        if user_username_id:
            # try:
            obj = models.FlagContainer.manager.create(title=title, description=description,
                                              start_time=start_time, total_days=total_days, finished_days=finished_days,
                                              user_username_id=user_username_id)
            params = {
                'data': obj.get_flag_container(),
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


def update_container(request):
    print("===============data/update:")
    if request.method == "POST":
        data = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        username = data.get('username', None)
        password = data.get('password', None)
        name = data.get('name', None)
        phone = data.get('phone', None)
        email = data.get('email', None)
        if username and password and name:
            data = models.FlagContainer.manager.filter(username=username)
            if data:
                # 用户名存在
                data = data[0]
                data.password = password
                data.name = name
                data.phone = phone
                data.email = email
                data.save()
                params = {
                    'data': data.get_my_info(),
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


def delete_container(request):
    return None


def get_container(request):
    print("===============flag/get:")
    if request.method == "GET":
        print(request.GET)
        data = request.GET
        user_username = data.get('user_username', None)
        if user_username:
            tasks = models.FlagContainer.manager.filter(user_username_id=user_username)
            task_list = [i.get_flag_container() for i in tasks]
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


# 添加
def add_flag(request):
    print("===============task/add:")
    if request.method == "POST":
        data = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        image_url = data.get('imageUrl', None)
        title = data.get('title', None)
        description = data.get('description', None)
        start_time = data.get('startTime', None)
        end_time = data.get('endTime', None)
        status = data.get('status', None)
        note = data.get('note', None)
        user_username_id = data.get('user_username', None)
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


def update_flag(request):
    print("===============data/update:")
    if request.method == "POST":
        data = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        username = data.get('username', None)
        password = data.get('password', None)
        name = data.get('name', None)
        phone = data.get('phone', None)
        email = data.get('email', None)
        if username and password and name:
            data = models.User.manager.filter(username=username)
            if data:
                # 用户名存在
                data = data[0]
                data.password = password
                data.name = name
                data.phone = phone
                data.email = email
                data.save()
                params = {
                    'data': data.get_my_info(),
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


def delete_flag(request):
    return None


def get_flag(request):
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
