# Segment Tree 



![](setmentTree.png)

建立一棵线段树

```golang
func build(l, r, p int) {
    if l + 1 == r {
        d[p] = a[l]
        return 
    }

    m := (l + r + 1) / 2
    build(l, m, p * 2 + 1)
    build(m, r, p * 2 + 2)
    d[p] = d[p * 2 + 1] + d[p * 2 + 2]
}
```


查找区间的和

```golang

func getsum(fl, fr, l, r, p int) {
    // fl, fl 要查找的区间的左边界和右边界


    // 当前区间为询问区间的子集合时候立刻返回
    if fl <= l && r <= fr {
        return d[p]
    }

    m, sum := (l + r + 1) / 2, 0
    // 到这一步证明 当前区间包含询问区间
    // 如果询问区间的左边界小于当前区间的中心值
    // 因应该查找， [l, m]

    if fl < m {
        sum += getsum(fl, fr, l, m, p * 2 + 1)
    }

    if r > m {
        sum += getsum(fl, fr, m, r, p * 2 + 2)
    } 
    return sum
}
```

线段树中值的修改和懒惰标记













