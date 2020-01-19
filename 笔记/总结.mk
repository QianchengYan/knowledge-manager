# 项目背景

现在辅助学习的app层出不穷，集大成于一身的却很少。如果能把这些时间管理、学习记录的功能集于一体，并且有配套的奖励机制运行，可能会对驱动学习、知识管理有较大帮助。

现在大学部分课程没有与实际授课严格配套的课本，或者有些课本知识过于细致，导致内容冗长，不适合敏捷学习或快速查阅。大学生的纸质课堂笔记离散易失且不易保存查阅，且结构不够统一。当然现在也有很多优秀的笔记软件，但我认为自定义性不强。  
如果有一种软件，可以更简略的记录每门课程的每一节课老师讲授的知识脉络中的每一个节点，并可以供我们不断去回顾和丰富，且提供一种类似游戏一样的激励机制、任务管理机制，且有日程管理、复习进度管理、遗忘曲线控制等功能。将每个知识点对象化，对每个知识点都可以打开消息窗口，记录你不同阶段对同一知识点的疑问或理解。  
相信这种软件可以更好的记录管理我们所学知识，让每一节课具象化，可视化的了解自己每节课的收获，甚至直观了解自己的知识体系。根据遗忘曲线的设定，估计对每一个知识点的残留记忆，能够更好的指导我们温故知新，让知识能“学的进，留得住”。

# 原型图设计

![image-20191228023306162](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228023306162.png)

![image-20191228023434711](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228023434711.png)

![image-20191228023317759](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228023317759.png)





# 项目结构

#### 整体框图

![image-20191228014016405](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228014016405.png)

#### 数据库设计

![image-20191228015334016](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015334016.png)

![image-20191228015839239](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015839239.png)

#### 前端目录结构

<figure class="half">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015521637.png" width="250">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015547979.png" width="250">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015613513.png" width="250">
</figure>

#### 后端目录结构

<figure class="half">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228015956570.png">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228020024821.png">
</figure>

# 项目用到的技术

* flutter 跨平台移动开发框架
* dart 一种既可以编译也可以解释的语言
* django 后端框架
* python 用来写django
* mysql 数据库管理系统
* git 代码版本控制
* centos 阿里云服务器部署后端
* Docker mysql在docker中运行

开发理念：

* DAO 数据持久化（本地缓存）
* BLoC 业务逻辑组件，使视图和控制分离
* Redux 全局状态管理
* ORM 对象关系映射，不直接写sql语句，像操作对象一样操作数据库

用到的包：

* dio http数据通信，用于移动端和后台数据通信
* shared_preferences 本地缓存
* json_annotation json序列化，通过字符串得到对象，类似于java的反射

工具：

* vscode 前端开发必备
* pycharm 写django
* SFTP 本地后端代码与服务器同步
* FinalShell 连接远端服务器
* screen linux程序，来保证进程不意外关闭
* Postman 通过假数据通信测后端接口
* Navicate 连接mysql数据库，查看数据库情况
* Genymotion android虚拟机启动
* git bash
* markdown 及时做好问题记录，这样学习才能有收获
<figure class="half">
    <img src="" width="200">
    <img src="" width="200">
    <img src="" width="200">
</figure>

# 现阶段成果

> 移动端整体UI架构借鉴QQ，组件采用卡片风格

#### 登录注册页面

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020547.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020550.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020555.jpg" width="250">
</figure>



#### 侧边栏、修改个人信息、app信息显示

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020615.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020619.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020634.jpg" width="250">
</figure>



#### 国际化

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020604.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020627.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_021551.jpg" width="250">
</figure>



#### 日程管理

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_021525.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020704.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_021518.jpg" width="250">
</figure>



#### Flag管理

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020715.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020731.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_022007.jpg" width="250">
</figure>



#### 知识卡片、世界用户

<figure class="half">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020741.jpg" width="250">
    <img src="C:\Users\Y1103\Desktop\picture\截屏_20191228_020735.jpg" width="250">
</figure>





# 项目工作量

#### 代码量：

![image-20191228011937619](C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228011937619.png)

除去一些自动生成的代码，还有一些自动生成的代码gitignore掉了，写了6000行还是有的，前期难点在于flutter 框架的使用，后期开发精力就可以集中到数据库设计和业务逻辑设计上来。很不幸的是，由于时间精力有限，目前基本上算是跑通框架，业务逻辑写的还很少，所以感觉数据库部分涉及很少，但是工作量真的很大了。

#### 时间安排

* **学习flutter** 三天整
* **初步跑起来flutter框架** 两天整
* **app架构初步搭建** 两天整
* **user相关 前端界面、后端view、后端model、前端数据持久化、前后端通信** 两天整
* **日程相关 前端界面、后端view、后端model、前端数据持久化、前后端通信**  一天
* **Flag相关 前端界面、后端view、后端model、前端数据持久化、前后端通信**  一天
* **知识卡片UI设计** 半天

加起来在这个项目上总共花了十整天左右。

#### 博客数量
<figure class="half">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228020333388.png" width="340">
    <img src="C:\Users\Y1103\AppData\Roaming\Typora\typora-user-images\image-20191228020403443.png" width="340">
</figure>

# 项目展望

还有很多功能没有完成，不过好在 增删改查、前端ui都熟悉了不少，后期开发的进度会更快。





# 收获

* 具有搭建整体软件的基本能力（前端、后端、数据库）

* 能把数据库应用到实际项目中去，有了基本的数据库使用能力
* 前后端联合开发，锻炼了处理复杂开发环境的能力（如何统筹、如何划分模块）
* 学习了flutter、进一步熟悉了django的使用
* 进一步使用了git和linux