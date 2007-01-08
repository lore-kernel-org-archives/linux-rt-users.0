From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Mon, 08 Jan 2007 12:37:34 +0100
Message-ID: <45A22CFE.7070402@imc-berlin.de>
References: <459CE84F.8000009@imc-berlin.de>	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>	 <1167917257.23138.17.camel@localhost.localdomain>	 <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020808060403020103070401"
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2654 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161237AbXAHLhk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 06:37:40 -0500
To: tglx@linutronix.de
In-Reply-To: <1167986882.23138.52.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------020808060403020103070401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

> There is neither a call of timer_create() nor of timer_settime(). So the
> posix timer is not setup, which results in the endless wait for the
> signal.
> 
> This looks like a serious problem with your cross compiler / glibc
> setup. Can you compile cyclictest on one of your desktop machines and
> link it statically ?

Well the statically linked version on SuSE 10.0 hangs as well.

Using the crosstool chains

	gcc-4.1.1-glibc-2.3.6-linux-2.6.15.1 (2.6.12 headers)
	gcc-3.4.4-glibc-2.3.5-linux-2.6.12

the cyclictest segafaults on the SuSE host and target system. strace attached.

Any more ideas? Maybe? Please?

Steven

--------------020808060403020103070401
Content-Type: text/plain;
 name="cyclictest.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyclictest.txt"

execve("./cyclictest", ["./cyclictest", "-t", "1", "-p", "80", "-i", "10000", "-l", "10", "-v"], [/* 69 vars */]) = 0
uname({sys="Linux", node="pinguin", ...}) = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x80b9580, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
getpid()                                = 17701
rt_sigaction(SIGRTMIN, {0x804db08, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x804dc31, [RTMIN], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x804dddc, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION, 0, 20431, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 2, 0xbfd40714, 34, (nil), 0}) = 0
brk(0)                                  = 0x8109000
brk(0x812a000)                          = 0x812a000
geteuid32()                             = 0
open("/proc/version", O_RDONLY)         = 3
read(3, "Linux version 2.6.13-15.8-smp (g"..., 255) = 138
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [ALRM], NULL, 8) = 0
rt_sigaction(SIGINT, {0x804f724, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804f724, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
pipe([3, 4])                            = 0
clone(Process 17702 attached
child_stack=0x811b304, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND) = 17702
[pid 17701] write(4, "\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\20{J\5\10\0\0\0\0\17\0\0"..., 148 <unfinished ...>
[pid 17702] set_thread_area({entry_number: <unfinished ...>
[pid 17701] <... write resumed> )       = 148
[pid 17702] <... set_thread_area resumed> 6, base_addr:0x80b99a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
[pid 17701] rt_sigprocmask(SIG_SETMASK, NULL,  <unfinished ...>
[pid 17702] rt_sigprocmask(SIG_SETMASK, ~[TRAP RT_1],  <unfinished ...>
[pid 17701] <... rt_sigprocmask resumed> [ALRM RTMIN], 8) = 0
[pid 17702] <... rt_sigprocmask resumed> NULL, 8) = 0
[pid 17701] write(4, "\200\225\v\10\0\0\0\0\0\0\0\0\0\202\4\10\350\222\20\10"..., 148 <unfinished ...>
[pid 17702] read(3,  <unfinished ...>
[pid 17701] <... write resumed> )       = 148
[pid 17702] <... read resumed> "\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\20{J\5\10\0\0\0\0\17\0\0"..., 148) = 148
[pid 17701] rt_sigprocmask(SIG_SETMASK, NULL,  <unfinished ...>
[pid 17702] poll( <unfinished ...>
[pid 17701] <... rt_sigprocmask resumed> [ALRM RTMIN], 8) = 0
[pid 17702] <... poll resumed> [{fd=3, events=POLLIN, revents=POLLIN}], 1, 2000) = 1
[pid 17701] rt_sigsuspend([ALRM] <unfinished ...>
[pid 17702] getppid()                   = 17701
[pid 17702] read(3, "\200\225\v\10\0\0\0\0\0\0\0\0\0\202\4\10\350\222\20\10"..., 148) = 148
[pid 17702] mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40000000
[pid 17702] mprotect(0x40000000, 4096, PROT_NONE) = 0
[pid 17702] clone(Process 17703 attached
child_stack=0x407ffbc4, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGRT_1) = 17703
[pid 17702] kill(17701, SIGRTMIN <unfinished ...>
[pid 17703] set_thread_area({entry_number: <unfinished ...>
[pid 17701] --- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
[pid 17702] <... kill resumed> )        = 0
[pid 17703] <... set_thread_area resumed> 6, base_addr:0x407ffbe0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
[pid 17701] <... rt_sigsuspend resumed> ) = -1 EINTR (Interrupted system call)
[pid 17702] poll( <unfinished ...>
[pid 17703] getpid( <unfinished ...>
[pid 17701] sigreturn( <unfinished ...>
[pid 17703] <... getpid resumed> )      = 17703
[pid 17701] <... sigreturn resumed> )   = ? (mask now [ALRM RTMIN])
[pid 17703] rt_sigprocmask(SIG_SETMASK, [ALRM RTMIN],  <unfinished ...>
[pid 17701] nanosleep({0, 10000000},  <unfinished ...>
[pid 17703] <... rt_sigprocmask resumed> NULL, 8) = 0
[pid 17703] gettid()                    = 17703
[pid 17703] rt_sigprocmask(SIG_BLOCK, [ALRM], NULL, 8) = 0
[pid 17703] sched_setscheduler(0, SCHED_FIFO, { 80 }) = 0
[pid 17703] clock_gettime(CLOCK_MONOTONIC, {3983601, 531609754}) = 0
[pid 17703] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 17703 detached
[pid 17701] <... nanosleep resumed> 0)  = ? ERESTART_RESTARTBLOCK (To be restarted)
[pid 17702] <... poll resumed> [{fd=3, events=POLLIN}], 1, 2000) = -1 EINTR (Interrupted system call)
[pid 17701] +++ killed by SIGKILL +++
+++ killed by SIGKILL +++

--------------020808060403020103070401--
