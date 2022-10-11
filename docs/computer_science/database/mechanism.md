# 数据库系统概论 

## 数据库的存储 

**磁盘作为基础存储的**数据库系统的存储涉及两个问题

1. 数据如何在磁盘上表示(How the DBMS represents the database in files on disk.) 
2. 如何从磁盘和内存之间反复移动数据 (How the DBMS manages its memory and moves data back-and-forth from disk.) 

### 问题一 

#### File Storage

![](./graph/01-storage/01.png)

- 使用**buffer pool**的原因是使内存看起来能装下所有的文件。
- 如果操作系统的虚拟内存机制
    - 有可能半页（database page）被换出，需要加锁，影响性能。


#### Page Layout

最少有两种方式存储 Page 

- Tuple-oriented
- Log-structured 


##### Tuple-oriented

![](./graph/01-storage/02.png)

##### Log-structured 


![](./graph/01-storage/04.png)


*优点*

- 速度块
    - 如果是Tuple-oriented类型的数据库，我们有十条数据要更新，但是十条数据在十个不同的page上，那么我们需要将每一个page读取到内存里，然后再写回去。但是如果是Log-structured类型的数据库，我们只需要将数据添加到一个新的page上。
- 分布式系统常用
    - 分布式系统没法访问每个数据存储的位置，所以采用log的形式追加。[??? 为啥不能访问每个数据的位置]


*缺点*
- 读取慢



#### Tuple Layout

![](./graph/01-storage/03.png)

数据库中存储大文件的方法

![](./graph/01-storage/06.png)

#### Data Representation



![](./graph/01-storage/05.png)



#### 数据库的Workload

**On-Line Transaction Processing (OLTP)**
- Fast operations that only read/update a small amount of data each time.

**On-Line Analytical Processing (OLAP)**

- Complex queries that read a lot of data to compute aggregates.

**Hybrid Transaction + Analytical Processing**
- OLTP + OLAP together on the same database instance


![](./graph/01-storage/07.png)




行存储的tuple做OLTP很快，但是做OLAP会读取没用的数据进入内存，浪费资源






### 问题二


#### Buffer Pool Manager

大多数数据库使不使用direct I/O([O_DIRECT](https://linux.die.net/man/2/open))，优点和缺点分别是什么???



#### Replacement Policies


#### Other Memory Pools


## 数据库的索引 

数据库一共有5层

![](./graph/02-access/01.png)


**Data Organization**

**Concurrency**

### HASH TABLES

哈希函数的时间复杂度平均是O(1)，最坏的情况下是O(n)。
但是O(1)也有很大的不同的。一个HASH函数要点

- Hash Function
- Hash Scheme(collisions)

现在常用的Hash函数


![](./graph/02-access/02.png)

现在最快的是 [xxHash3](https://github.com/Cyan4973/xxHash)

因为key-value不是一对一的，那么我们如何处理non-unique-keys的情况呢

1. 使用一个单独的Value的链表
2. 记录多个key

![](./graph/02-access/03.png)












