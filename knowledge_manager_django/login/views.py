from django.shortcuts import render, HttpResponse, redirect
from django.core import serializers
from django.http import JsonResponse

import json
from login import models


# Create your views here.
def login(request):
    print("login:" + request.path)

    if request.method == "POST":
        print("post")
        # print("request.body type" + type(request.body))
        # print("request.POST type:" + type(request.POST))
        # print("request.POST")
        # data = request.body.decode()
        # print(data)
        print(request.body.decode())
        data = json.loads(request.body.decode())
        username = data.get('username', None)
        password = data.get('password', None)
        print("username:" + username + "  passwork:" + password)
        # filter的写法可以避免查询不到报错，filter会返回None
        user = models.User.objects.filter(username=username)
        if user:
            # 用户存在
            user = user[0]
            if user.password == password:
                # 密码正确
                print('密码正确')
                params = {
                    'success': True,
                    'message': '登陆成功',
                    'data': {
                        'id': user.id,
                        'username': user.username,
                        'password': user.password,
                        'phone': user.phone,
                        'email': user.email,
                    },
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
            else:
                # 密码错误
                print('密码错误')
                params = {
                    'success': False,
                    'message': '密码错误',
                }
                return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                    content_type='application/json;charset=utf-8')
        else:
            # user_obj为空，用户不存在
            print('用户不存在')
            params = {
                'success': False,
                'message': '用户不存在',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')
    else:
        print('请求错误')
        params = {
            'success': False,
            'message': '请求错误',
        }
        return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                            content_type='application/json;charset=utf-8')

def signup(request):
    if request.method == "POST":
        user = json.loads(request.body.decode())
        # 用户 姓名、用户名、密码、电话
        username = user.get('username', None)
        password = user.get('password', None)
        name = user.get('name', None)
        phone = user.get('phone', None)
        email = user.get('email', None)
        print("username:" + username + "  passwork:" + password,
              "name:" + name + " phone:" + phone + " email:" + email)

        if models.User.objects.filter(username=username):
            # 用户名已存在，不满足注册条件
            params = {
                'success': False,
                'message': '用户名已存在',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')

        else:
            models.User.objects.create(username=username, password=password, name=name,
                                           phone=phone, email=email)

            params = {
                'success': True,
                'message': '注册成功',
            }
            return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                                content_type='application/json;charset=utf-8')
    else:
        print('请求错误')
        params = {
            'success': False,
            'message': '请求错误',

        }
        return HttpResponse(content=json.dumps(params, ensure_ascii=False),
                            content_type='application/json;charset=utf-8')
