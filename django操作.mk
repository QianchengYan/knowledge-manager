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

中止screen
exit 或 快捷键：Ctrl+d
```

