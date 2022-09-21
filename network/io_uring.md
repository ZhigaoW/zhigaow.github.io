# io_uring

**io_uring**设计者自己写的第一手资料：[efficient io with io_uring](https://kernel.dk/io_uring.pdf)



design thinking: *0 copy* -> *share data u/k* -> *[lock]no efficiency* -> *ring buffer(1 producer and 1 consumer)*

- submitting IO(submission queue)
  - application(**producer**)->kernel(**consumer**)
-  completion IO(completion queue)
  - kernel(**producer**)-> application(**consumer**)





```c
struct io_uring_cqe {
   __u64 user_data;
   __s32 res;
   __u32 flags;
};
```

`user_data`:   initial request submission

`res`:	return val of sys call

`flag`:	carry meta data related to this operation(**not use now*)

```c
struct io_uring_sqe {
   __u8 opcode;
   __u8 flags;
   __u16 ioprio;
   __s32 fd;
   __u64 off;
   __u64 addr;
   __u32 len;
   union {
   __kernel_rwf_t rw_flags;
   __u32 fsync_flags;
   __u16 poll_events;
__u32 sync_range_flags;
__u32 msg_flags;   
   };
   __u64 user_data;
   union {
   __u16 buf_index;
   __u64 __pad2[3];
   };
};
```

