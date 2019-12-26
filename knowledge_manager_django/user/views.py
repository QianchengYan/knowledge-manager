from django.shortcuts import render, HttpResponse, redirect
from django.core import serializers
from django.http import JsonResponse

import json
from user import models

# Create your views here.
from utils.net_params import NetParams


# 登录
def login(request):
    print("===============user/login:")
    if request.method == "POST":
        print("post")
        print(request.body.decode())
        data = json.loads(request.body.decode())
        username = data.get('username', None)
        password = data.get('password', None)
        print("username:" + username + "  passwork:" + password)
        # filter的写法可以避免查询不到报错，filter会返回None
        user = models.User.manager.filter(username=username)
        if user:
            # 用户存在
            user = user[0]
            if user.password == password:
                # 密码正确
                print('密码正确')
                params = {
                    'data': user.get_my_info(),
                    'success': True,
                    'message': '登陆成功',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
            else:
                # 密码错误
                print('密码错误')
                params = {
                    'data': None,
                    'success': False,
                    'message': '密码错误',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
        else:
            # user_obj为空，用户不存在
            print('用户不存在')
            params = {
                'data': None,
                'success': False,
                'message': '用户不存在',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')
    else:
        print('请求错误')
        params = {
            'data': None,
            'success': False,
            'message': '请求错误',
        }
        return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                            content_type='application/json;charset=utf-8')


# 注册
def signup(request):
    print("===============user/signup:")
    if request.method == "POST":
        user = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        username = user.get('username', None)
        password = user.get('password', None)
        name = user.get('name', None)
        avatar_url = user.get('avatarUrl', None)
        phone = user.get('phone', None)
        email = user.get('email', None)
        # print("username:" + username + "  passwork:" + password,
        #       "name:" + name + "avatar_url:" + avatar_url,
        #       " phone:" + phone + " email:" + email)
        if username and password and name:
            if models.User.manager.filter(username=username):
                # 用户名已存在，不满足注册条件
                params = {
                    'data': None,
                    'success': False,
                    'message': '用户名已存在',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')

            else:
                models.User.manager.create(username=username, password=password,
                                           name=name, avatar_url=avatar_url,
                                           phone=phone, email=email)

                params = {
                    'data': None,
                    'success': True,
                    'message': '注册成功',
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


# 获取自己信息
def my_info(request):
    print("===============user/my_info:")
    if request.method == "GET":
        print(request.body.decode())
        data = json.loads(request.body.decode())
        username = data.get('username', None)
        if username:
            user = models.User.manager.filter(username=username)
            if user:
                user = user[0]
                print("type my_user_info:" + str(user.get_my_info()))
                params = {
                    'data': user.get_my_info(),
                    'success': True,
                    'message': '用户信息获取成功',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
            else:
                print('用户不存在')
                params = {
                    'data': None,
                    'success': True,
                    'message': '用户不存在',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
    print('请求错误')
    params = NetParams(data=None, success=False, message='请求错误').get_params()
    return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                        content_type='application/json;charset=utf-8')


# 获取用户信息
def user_info(request):
    print("===============user/user_info:")
    if request.method == "GET":
        print(request.body.decode())
        data = json.loads(request.body.decode())
        username = data.get('username', None)
        print("username:" + username)
        if username:
            user = models.User.manager.filter(username=username)
            if user:
                user = user[0]
                print("type my_user_info:" + str(user.get_user_info()))
                params = {
                    'data': user.get_user_info(),
                    'success': True,
                    'message': '用户信息获取成功',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
            else:
                print('用户不存在')
                params = {
                    'data': None,
                    'success': False,
                    'message': '用户不存在',
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
