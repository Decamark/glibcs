# glibcs
Multiple versions of pre-built glibcs.

When you're playing pwn with given libc.so and the version of ld.so installed on your host differs from the given libc.so, it ends up with displaying "Segmentation fault". To run the program normally, just provide suitable version of ld.so and the given libc.so like:

```plain
$ LD_PRELOAD="./ld-2.30.so ./given-libc-2.30.so" ./a.out
```
