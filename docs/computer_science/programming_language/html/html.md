# Hyper Text Markup Language



[w3c](http://www.chinaw3c.org)标准包括
- 结构化标准语言(HTML, XML)
- 表现标准语言(CSS)
- 行为标准语言(DOM, ECMAScript)


##

### 网页的基本结构

```html
<!-- DOCTYPE: 告诉浏览器我们使用的规范 -->
<!DOCTYPE html>
<html lang="en">

<!-- 网页的头部 -->

<head>
    <!-- 自闭合标签 -->
    <!-- 描述性标签 meta: 一般用来做SEO -->
    <meta charset="UTF-8">
    <meta name="keywords" content="学习网页">
    <meta name="description" content="用来学习html的网页">
    <!-- Title: 网页的标题 -->
    <title>Title</title>
</head>

<body>
    Hello World!
</body>

</html>
```



### 网页的基本标签

内容都写在`body`里

```html

<body>
    <!-- 标题标签 -->
    <h1> Head 1 </h1>
    <h2> Head 2 </h2>
    <h3> Head 3 </h3>
    <h4> Head 4 </h4>
    <h5> Head 5 </h5>
    <h6> Head 6 </h6>
    <!-- 段落标签 -->
    <p>段落</p>
    <!-- 换行标签 -->
    换行标签 <br />
    <!-- 水平线标签 -->
    <hr />
    <!-- 字体样式 -->
    <strong>粗体</strong>
    <em>斜体</em> <br />


    <!-- 注释和特殊符号 -->
    <!-- 空格 -->
    空&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格
    <!-- 大于 -->
    &gt;
    <!-- 版权符号 -->
    &copy;
</body>

```


### 图像

```html
    <!-- 图片 -->
    <!-- alt: 图片加载不出来时候的文字 -->
    <img src="../resource/g1.jpg" alt="我是一个图片" title="悬停文字" />
```


### 链接

```html
<!-- link -->
    <!-- target: open in where -->
    <a href="https://www.baidu.com" target="_blank">
        <img src="../resource/g1.jpg" alt="我是一个图片" title="悬停文字" />
    </a>
    <a href="https://www.baidu.com" target="_self">
        百度
    </a>






    <!-- 锚链接 
    1. 需要一个标记
    2. 跳转到标记
    -->
    <!-- name: 标记 -->
    <a name="down">底部</a>

    <!-- 跳转 -->
    <a href="#down">到底部</a>
    <!-- 还可以组合使用 -->
    <!-- herf=url#down -->



    <!-- 邮件链接 -->

    <a href="mailto:zhigaowang@zju.edu.cn">联系我</a>


    <!-- QQ链接 -->
```



### 块元素和行元素

- 块元素: 无论内容多少，该元素独占一行
- 行元素: 内容撑开宽度，左右都是行内元素的可以排在一排

### 列表


```html
    <!-- 有序列表 -->
    <ol>
        <li>Java</li>
        <li>Python</li>
        <li>C/C++</li>
    </ol>


    <hr />

    <!-- 无序列表 -->

    <ul>
        <li>Java</li>
        <li>Python</li>
        <li>C/C++</li>
    </ul>


    <hr />

    <!-- 自定义列表 
    dl : 标签
    dt : 列表名称
    dd : 列表内容
    -->
    <dl>
        <dt>学科</dt>

        <dd>Java</dd>
        <dd>Python</dd>
        <dd>Linux</dd>
        <dd>C </dd>

        <dt>位置</dt>
        <dd>西安</dd>
        <dd>重庆</dd>
        <dd>上海</dd>
    </dl>
```

### 表格标签


```html

    <!-- 表格table
    行 tr
    列 td
    -->
    <table border="1px">
        <tr>
            <!-- 跨列 -->
            <td colspan="4" align="center">1-1</td>
        </tr>
        <tr>
            <!-- 跨列 -->
            <td rowspan="2">2-1</td>
            <td>2-2</td>
            <td>2-3</td>
            <td>2-4</td>
        </tr>
        <tr>
            <td>3-2</td>
            <td>3-3</td>
            <td>3-4</td>
        </tr>
    </table>
```



### 音频和视频

```html
    <!-- 视频
    控制标签: controls
    自动播放: autoplay
    -->
    <video src="../resource/video/ocean.mp4" controls></video>

    <!-- 音频
    控制标签: controls
    自动播放: autoplay
    -->
    <audio src="../resource/audio/birds.wav" controls></audio>
```

### 页面结构


| 元素名  | 描述                           |
| ------- | ------------------------------ |
| header  | 标题头部区域的内容             |
| footer  | 标记脚部区域的内容             |
| section | Web页面中的一块独立区域        |
| article | 独立的文章内容                 |
| aside   | 相关内容或应用(常常用于侧边栏) |
| nav     | 导航类辅助内容                 |



```html
<body>
    <header>
        <h2>网页头部</h2>
    </header>
    <section>
        <h2>网页主体</h2>
    </section>
    <footer>
        <h2>网页脚部</h2>
    </footer>
</body>
```


### 内联框架


```html
    <!-- <iframe src="http://player.bilibili.com/player.html?aid=55631961&bvid=BV1x4411V75C&cid=97257967&page=11"
        scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true">
    </iframe> -->

    <iframe src="https://www.bilibili.com" frameborder="0" width="1000px" height="800"></iframe>
```


### 表单


```html
    <form method="post" action="01.html">
        <!-- 文本输入框 <input type="text"> -->
        <p>Name: <input type="text" name="username"></p>
        <!-- 密码输入框 <input type="password"> -->
        <!-- 
            value 默认初始值
            maxlen 最长能写几个字符
            size 文本框长度
        -->
        <p>Password: <input type="password" name="password"></p>

        <p>
            <input type="submit">
            <input type="reset">
        </p>
    </form>
```

#### 下面都是input标签 type不一样

##### 文本框

##### 单选框 radio 多选框 checkbox

name值相同为同一组

##### 按钮 button/image 

image : 图片按钮

```html
<!-- 
    button : 普通按钮
    image : 图片按钮
    submit : 提交按钮
    reset : 重置按钮
-->
```

#### 下拉框和文件域 


```html

        <!-- 文件域 -->
        <p><input type="file" name="files"></p>

        <!-- 提交按钮 -->
        <input type="submit">
        <input type="reset">
        </p>

        <!-- 下拉框 -->
        <p>
            <select name="checked">
                <option value="china">中国</option>
                <option value="usa">美国</option>
                <option value="ind">印度</option>
                <!-- 默认值 -->
                <option value="eth" selected>瑞士</option>
            </select>
        </p>

        <!-- 文本域 -->
        <textarea name="textarea" cols="30" rows="10"></textarea>
```



表单的应用
- 隐藏域
- 只读
- 禁用





