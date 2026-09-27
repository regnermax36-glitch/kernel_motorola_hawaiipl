/*
 * MaxRegnerOS Freestanding ARM64 Init Process
 * Target: Motorola Moto G22 (hawaiipl - MediaTek MT6765 ARM64)
 */

#define SYS_write 64
#define SYS_mkdirat 34
#define SYS_mount 40
#define SYS_execve 221
#define SYS_exit 93
#define AT_FDCWD -100

typedef unsigned long size_t;

static long syscall1(long n, long a1) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0") = a1;
    __asm__ __volatile__("svc #0" : "+r"(x0) : "r"(x8) : "memory");
    return x0;
}

static long syscall3(long n, long a1, long a2, long a3) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0") = a1;
    register long x1 __asm__("x1") = a2;
    register long x2 __asm__("x2") = a3;
    __asm__ __volatile__("svc #0" : "+r"(x0) : "r"(x8), "r"(x1), "r"(x2) : "memory");
    return x0;
}

static long syscall5(long n, long a1, long a2, long a3, long a4, long a5) {
    register long x8 __asm__("x8") = n;
    register long x0 __asm__("x0") = a1;
    register long x1 __asm__("x1") = a2;
    register long x2 __asm__("x2") = a3;
    register long x3 __asm__("x3") = a4;
    register long x4 __asm__("x4") = a5;
    __asm__ __volatile__("svc #0" : "+r"(x0) : "r"(x8), "r"(x1), "r"(x2), "r"(x3), "r"(x4) : "memory");
    return x0;
}

static size_t mystrlen(const char *s) {
    size_t len = 0;
    while (s[len]) len++;
    return len;
}

static void print_str(const char *s) {
    syscall3(SYS_write, 1, (long)s, mystrlen(s));
}

void _start(void) {
    print_str("\n==========================================================\n");
    print_str("    MaxRegnerOS Mobile Linux v1.0-ULTRA (ARM64 Native)\n");
    print_str("    Target Device: Motorola Moto G22 (hawaiipl - MT6765)\n");
    print_str("==========================================================\n\n");

    /* Create directories */
    syscall3(SYS_mkdirat, AT_FDCWD, (long)"/proc", 0755);
    syscall3(SYS_mkdirat, AT_FDCWD, (long)"/sys", 0755);
    syscall3(SYS_mkdirat, AT_FDCWD, (long)"/dev", 0755);

    /* Mount pseudo filesystems */
    syscall5(SYS_mount, (long)"proc", (long)"/proc", (long)"proc", 0, 0);
    syscall5(SYS_mount, (long)"sysfs", (long)"/sys", (long)"sysfs", 0, 0);
    syscall5(SYS_mount, (long)"devtmpfs", (long)"/dev", (long)"devtmpfs", 0, 0);

    /* Execute shell */
    char *const sh_argv[] = {"/bin/sh", "/maxregneros/maxregneros_shell.sh", (char *)0};
    char *const sh_envp[] = {"PATH=/maxregneros/bin:/bin:/sbin:/usr/bin:/usr/sbin", "OS_NAME=MaxRegnerOS", (char *)0};

    syscall3(SYS_execve, (long)"/bin/sh", (long)sh_argv, (long)sh_envp);
    syscall3(SYS_execve, (long)"/system/bin/sh", (long)sh_argv, (long)sh_envp);

    syscall1(SYS_exit, 0);
}
