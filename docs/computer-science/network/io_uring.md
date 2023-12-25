# io_uring

## reference 

[change linux kernel in ubuntu version](https://www.how2shout.com/linux/how-to-change-default-kernel-in-ubuntu-22-04-20-04-lts/)

**io_uring**设计者自己写的第一手资料：[efficient io with io_uring](https://kernel.dk/io_uring.pdf)

[Missing Manuals - io_uring worker pool](https://blog.cloudflare.com/missing-manuals-io_uring-worker-pool/)

[升级ubuntu20.04内核](https://leanote.zzzmh.cn/blog/post/admin/Linux-Ubuntu-20.04-LTS-%E6%9B%B4%E6%96%B0%E5%88%B0%E6%9C%80%E6%96%B0%E9%95%BF%E6%9C%9F%E6%94%AF%E6%8C%81%E5%86%85%E6%A0%B8-v5.10.9)

[liburing github](https://github.com/axboe/liburing)

[how to build liburing](https://stackoverflow.com/questions/61525015/how-to-build-liburing)

[Linux error while loading shared libraries: cannot open shared object file: No such file or directory](https://stackoverflow.com/questions/480764/linux-error-while-loading-shared-libraries-cannot-open-shared-object-file-no-s)

## general idea

design thinking: *0 copy* -> *share data u/k* -> *[lock]no efficiency* -> *ring buffer(1 producer and 1 consumer)*

- submitting IO(submission queue)
  - application(**producer**)->kernel(**consumer**)
-  completion IO(completion queue)
  - kernel(**producer**)-> application(**consumer**)



## data structure design

### complete side

```c
struct io_uring_cqe {
   __u64 user_data;		// initial request submission
   __s32 res;					// return val of sys call
   __u32 flags;				// carry meta data related to this operation(not use now)
};
```

### submition side

```c
struct io_uring_sqe {
   __u8	opcode;		// describes the operation code
   __u8	flags;		// contains modifier flags that are common across command types
   __u16 ioprio;	// priority of this request
   __s32 fd;			//  
   __u64 off;			// holds the offset at which the operation should take place.
   __u64 addr;
   __u32 len;
   union {
   		__kernel_rwf_t	rw_flags;
   		__u32 					fsync_flags;
   		__u16 					poll_events;
	 		__u32 					sync_range_flags;
			__u32 					msg_flags;   
   };
   __u64 user_data;
   union {
   		__u16 buf_index;
   		__u64 __pad2[3];
   };
};
```

## How the ring works



## system call

#### io_uring_setup()

#### io_uring_enter()

#### io_uring_register()

​	



