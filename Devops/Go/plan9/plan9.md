
**[BACK](../README.md)**

---


# PLAN9汇编

## 前言

汇编语言可以直接翻译为机器语言，即0和1组成的串。GO底层的汇编使用的基本上是PLAN9汇编的语法，汇编语言之间可以相互转化，所以PLAN9只要有合理的映射就可以直接转换为机器语言。

## 函数的调用规约


调用规约: 一个**高级语言**的调用规约就是函数的参数和返回值以**什么样的顺序和规则放在内存或者寄存器中** 

参考[C语言的调用规约](https://gitbook.coder.cat/function-call-principle/)

```c
// hello.c

long callee(long arg1, long arg2, long arg3, long arg4, long arg5, long arg6, long arg7, long arg8) {
    return arg7 + arg8;
}

int main() {
    long a = 7;
    long b = 8;
    callee(1, 2, 3, 4 ,5 ,6, a, b);
    return 0;
}
```
使用`gcc hello.c -S`输出

```
        .file   "hello.c"
        .text
        .globl  callee
        .type   callee, @function
callee:
.LFB0:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        movq    %rdx, -24(%rbp)
        movq    %rcx, -32(%rbp)
        movq    %r8, -40(%rbp)
        movq    %r9, -48(%rbp)
        movq    16(%rbp), %rdx
        movq    24(%rbp), %rax
        addq    %rdx, %rax
        popq    %rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE0:
        .size   callee, .-callee
        .globl  main
        .type   main, @function
main:
.LFB1:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        subq    $16, %rsp
        movq    $7, -8(%rbp)
        movq    $8, -16(%rbp)
        pushq   -16(%rbp)
        pushq   -8(%rbp)
        movl    $6, %r9d
        movl    $5, %r8d
        movl    $4, %ecx
        movl    $3, %edx
        movl    $2, %esi
        movl    $1, %edi
        call    callee
        addq    $16, %rsp
        movl    $0, %eax
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE1:
        .size   main, .-main
        .ident  "GCC: (GNU) 8.5.0 20210514 (Red Hat 8.5.0-4)"
        .section        .note.GNU-stack,"",@progbits
```

#### C的main函数
```
main:
.LFB1:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        subq    $16, %rsp
        movq    $7, -8(%rbp)
        movq    $8, -16(%rbp)
        pushq   -16(%rbp)
        pushq   -8(%rbp)
        movl    $6, %r9d
        movl    $5, %r8d
        movl    $4, %ecx
        movl    $3, %edx
        movl    $2, %esi
        movl    $1, %edi
        call    callee
        addq    $16, %rsp
        movl    $0, %eax
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE1:
        .size   main, .-main
        .ident  "GCC: (GNU) 8.5.0 20210514 (Red Hat 8.5.0-4)"
        .section        .note.GNU-stack,"",@progbits
```

据说main函数被系统的_start函数调用，main函数将_strat函数的栈基地址寄存器(rbp)押入栈中，将rbp附值为rsp

```
pushq   %rbp
movq    %rsp, %rbp
```
<img src="picture/cstack/Canvas%202.png" width="300"/>



```
        subq    $16, %rsp
        movq    $7, -8(%rbp)
        movq    $8, -16(%rbp)
```

<img src="picture/cstack/Canvas%203.png" width="300"/>

```
        pushq   -16(%rbp)
        pushq   -8(%rbp)
        movl    $6, %r9d
        movl    $5, %r8d
        movl    $4, %ecx
        movl    $3, %edx
        movl    $2, %esi
        movl    $1, %edi
```


<img src="picture/cstack/Canvas%204.png" width="300"/>


```
        call    callee
```
<img src="picture/cstack/Canvas%205.png" width="300"/>


```
callee:
.LFB0:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
```
<img src="picture/cstack/Canvas%206.png" width="300"/>

```
        .cfi_def_cfa_register 6
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        movq    %rdx, -24(%rbp)
        movq    %rcx, -32(%rbp)
        movq    %r8, -40(%rbp)
        movq    %r9, -48(%rbp)
        movq    16(%rbp), %rdx
        movq    24(%rbp), %rax
        addq    %rdx, %rax
        popq    %rbp
        .cfi_def_cfa 7, 8
```
<img src="picture/cstack/Canvas%207.png" width="300"/>

```
        ret
        .cfi_endproc
```
<img src="picture/cstack/Canvas%208.png" width="300"/>

```
        addq    $16, %rsp
        movl    $0, %eax
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE1:
        .size   main, .-main
        .ident  "GCC: (GNU) 8.5.0 20210514 (Red Hat 8.5.0-4)"
        .section        .note.GNU-stack,"",@progbits
```

<img src="picture/cstack/Canvas%209.png" width="300"/>












### GO的调用规约

```
                                                                                                                              
                                       caller                                                                                 
                                 +------------------+                                                                         
                                 |                  |                                                                         
       +---------------------->  --------------------                                                                         
       |                         |                  |                                                                         
       |                         | caller parent BP |                                                                         
       |           BP(pseudo SP) --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   Local Var0     |                                                                         
       |                         --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   .......        |                                                                         
       |                         --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   Local VarN     |                                                                         
                                 --------------------                                                                         
 caller stack frame              |                  |                                                                         
                                 |   callee arg2    |                                                                         
       |                         |------------------|                                                                         
       |                         |                  |                                                                         
       |                         |   callee arg1    |                                                                         
       |                         |------------------|                                                                         
       |                         |                  |                                                                         
       |                         |   callee arg0    |                                                                         
       |                         ----------------------------------------------+   FP(virtual register)                       
       |                         |                  |                          |                                              
       |                         |   return addr    |  parent return address   |                                              
       +---------------------->  +------------------+---------------------------    <-------------------------------+         
                                                    |  caller BP               |                                    |         
                                                    |  (caller frame pointer)  |                                    |         
                                     BP(pseudo SP)  ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |     Local Var0           |                                    |         
                                                    ----------------------------                                    |         
                                                    |                          |                                              
                                                    |     Local Var1           |                                              
                                                    ----------------------------                            callee stack frame
                                                    |                          |                                              
                                                    |       .....              |                                              
                                                    ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |     Local VarN           |                                    |         
                                  SP(Real Register) ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    +--------------------------+    <-------------------------------+         
                                                                                                                              
                                                              callee

                                    
```

## PLAN9的汇编语法

### 工具




[go tool compile](https://pkg.go.dev/cmd/compile) xxx.go：将go代码编译为obj文件


[go tool objdump](https://pkg.go.dev/cmd/objdump) xxx.o`：可以将obj文件反汇编为plan汇编代码

### 语法

参考[plan9入门](https://xargin.com/plan9-assembly/)


// TODO

![](picture/func.png)







