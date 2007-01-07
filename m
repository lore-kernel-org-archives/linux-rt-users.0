From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Sun, 07 Jan 2007 15:38:47 +0100
Message-ID: <45A105F7.6010502@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de>	 <1167986882.23138.52.camel@localhost.localdomain>	 <45A0ECBB.1040107@imc-berlin.de> <1168179704.22701.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040206080407040104080401"
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2331 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbXAGOix (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jan 2007 09:38:53 -0500
To: tglx@linutronix.de
In-Reply-To: <1168179704.22701.86.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------040206080407040104080401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thomas,

>>> There is neither a call of timer_create() nor of timer_settime(). So the
>>> posix timer is not setup, which results in the endless wait for the
>>> signal.
>> cyclictest runs fine on my SuSE 10.0 host system. But: there are *no* calls
>> to any timer_* function!!!
> 
> Did you check that with strace ?

Yes. I attach that run.

 gcc -Wall -O2  -lpthread -lrt cyclictest.c -o cyclictest

 ldd ./cyclictest
        linux-gate.so.1 =>  (0xffffe000)
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x4003a000)
        librt.so.1 => /lib/tls/librt.so.1 (0x4004c000)
        libc.so.6 => /lib/tls/libc.so.6 (0x40055000)
        /lib/ld-linux.so.2 (0x40000000)

 strace ./cyclictest -t 1 -p 80 -i 10000 -l 10 -v 2> cyclictest.txt

 grep timer cyclictest.txt
 <nothing>

> 
>> Has it to with using TLS?
> No.
IIUC TLS is only usefull for SMP systems?

>> :~/Projekte/Latency/cyclictest> ldd ./cyclictest
>>         linux-gate.so.1 =>  (0xffffe000)
>>         libpthread.so.0 => /lib/tls/libpthread.so.0 (0x4003a000)
>>         librt.so.1 => /lib/tls/librt.so.1 (0x4004c000)
>>         libc.so.6 => /lib/tls/libc.so.6 (0x40055000)
>>         /lib/ld-linux.so.2 (0x40000000)
> 
> The timer_* functions are in librt.
Then why does the static linking not work?

Steven

--------------040206080407040104080401
Content-Type: text/plain;
 name="cyclictest.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyclictest.txt"

execve("./cyclictest", ["./cyclictest", "-t", "1", "-p", "80", "-i", "10000", "-l", "10", "-v"], [/* 69 vars */]) = 0
uname({sys="Linux", node="pinguin", ...}) = 0
brk(0)                                  = 0x804c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=135508, ...}) = 0
old_mmap(NULL, 135508, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pH\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=93266, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40039000
old_mmap(NULL, 70104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4003a000
madvise(0x4003a000, 70104, MADV_SEQUENTIAL|0x1) = 0
old_mmap(0x40048000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x40048000
old_mmap(0x4004a000, 4568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4004a000
close(3)                                = 0
open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\36\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=40833, ...}) = 0
old_mmap(NULL, 33384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4004c000
madvise(0x4004c000, 33384, MADV_SEQUENTIAL|0x1) = 0
old_mmap(0x40053000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x40053000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1417095, ...}) = 0
old_mmap(NULL, 1174524, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40055000
madvise(0x40055000, 1174524, MADV_SEQUENTIAL|0x1) = 0
old_mmap(0x4016e000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x119000) = 0x4016e000
old_mmap(0x40172000, 7164, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40172000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40174000
mprotect(0x4016e000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x401746c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40017000, 135508)              = 0
set_tid_address(0x40174708)             = 5192
rt_sigaction(SIGRTMIN, {0x4003e3c0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x4003e440, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION, 0, 20529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 2, 0xbf853c00, 34, (nil), 0}) = 0
geteuid32()                             = 0
open("/proc/version", O_RDONLY)         = 3
read(3, "Linux version 2.6.13-15.8-smp (g"..., 255) = 138
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [ALRM], NULL, 8) = 0
rt_sigaction(SIGINT, {0x8048c00, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x8048c00, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
brk(0)                                  = 0x804c000
brk(0x806d000)                          = 0x806d000
mmap2(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40175000
mprotect(0x40175000, 4096, PROT_NONE)   = 0
clone(child_stack=0x403754c4, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0x40375bf8, {entry_number:6, base_addr:0x40375bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0x40375bf8) = 5193
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 10000000}, NULL)          = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
write(1, "       0:       0:       0\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       1:    3508\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       2:    5517\n", 27) = 27
write(1, "       0:       3:    7510\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       4:    9508\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       5:   11503\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       6:   13517\n", 27) = 27
write(1, "       0:       7:   15512\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       8:   17518\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
write(1, "       0:       9:   19519\n", 27) = 27
nanosleep({0, 10000000}, NULL)          = 0
nanosleep({0, 50000000}, NULL)          = 0
munmap(0x40017000, 4096)                = 0
exit_group(0)                           = ?

--------------040206080407040104080401--
