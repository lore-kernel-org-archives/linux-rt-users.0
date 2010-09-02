From: Lai Weilin-B04597 <B04597@freescale.com>
Subject: patch-2.6.31.12-rt21 fails to run pthread_cond_signal()
Date: Thu, 2 Sep 2010 13:57:32 +0800
Message-ID: <E99B4DCB8B5A0241832DBF4FCB7C813AEFE406@zch01exm27.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:45427
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751204Ab0IBF5v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Sep 2010 01:57:51 -0400
Received: from mail145-va3 (localhost.localdomain [127.0.0.1])	by
 mail145-va3-R.bigfish.com (Postfix) with ESMTP id B7F4F1808191	for
 <linux-rt-users@vger.kernel.org>; Thu,  2 Sep 2010 05:57:49 +0000 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.242])	by
 mail145-va3.bigfish.com (Postfix) with ESMTP id AE13E107004C	for
 <linux-rt-users@vger.kernel.org>; Thu,  2 Sep 2010 05:57:48 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o825vgNA015056	for
 <linux-rt-users@vger.kernel.org>; Wed, 1 Sep 2010 22:57:47 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
 [10.192.129.223])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o826BR9M005201	for <linux-rt-users@vger.kernel.org>; Thu, 2 Sep 2010 01:11:28
 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I tried to apply the rt patch, patch-2.6.31.12-rt21, to the 31 kernel. =
It successfully boots up with the patch, on ARM9 platform(Freescale's i=
=2EMX25 3Stack board). But it fails to run a simple application, which =
tests the A thread wakes up B thread using pthread_cond_signal(). The c=
ode is as follows. And I try to dump the log, it hangs in the futex() f=
unction while the console is still alive. Anyone can help ?

The dump log is as follows.

execve("./rt-mutex", ["./rt-mutex"], [/* 14 vars */]) =3D 0
brk(0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x11000
uname({sys=3D"Linux", node=3D"(none)", ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x4001c000
access("/etc/ld.so.preload", R_OK)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/etc/ld.so.cache", O_RDONLY)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/tls/v5l/fast-mult/half/libpthread.so.0", O_RDONLY) =3D -1 EN=
OENT (No such file or directory)
stat64("/lib/tls/v5l/fast-mult/half", 0xbe9ec318) =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/tls/v5l/fast-mult/libpthread.so.0", O_RDONLY) =3D -1 ENOENT =
(No such file or directory)
stat64("/lib/tls/v5l/fast-mult", 0xbe9ec318) =3D -1 ENOENT (No such fil=
e or directory)
open("/lib/tls/v5l/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No s=
uch file or directory)
stat64("/lib/tls/v5l/half", 0xbe9ec318) =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/v5l/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such f=
ile or directory)
stat64("/lib/tls/v5l", 0xbe9ec318)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/tls/fast-mult/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT=
 (No such file or directory)
stat64("/lib/tls/fast-mult/half", 0xbe9ec318) =3D -1 ENOENT (No such fi=
le or directory)
open("/lib/tls/fast-mult/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
stat64("/lib/tls/fast-mult", 0xbe9ec318) =3D -1 ENOENT (No such file or=
 directory)
open("/lib/tls/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such =
file or directory)
stat64("/lib/tls/half", 0xbe9ec318)=A0=A0=A0=A0 =3D -1 ENOENT (No such =
file or directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such file =
or directory)
stat64("/lib/tls", 0xbe9ec318)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT=
 (No such file or directory)
open("/lib/v5l/fast-mult/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT=
 (No such file or directory)
stat64("/lib/v5l/fast-mult/half", 0xbe9ec318) =3D -1 ENOENT (No such fi=
le or directory)
open("/lib/v5l/fast-mult/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No =
such file or directory)
stat64("/lib/v5l/fast-mult", 0xbe9ec318) =3D -1 ENOENT (No such file or=
 directory)
open("/lib/v5l/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such =
file or directory)
stat64("/lib/v5l/half", 0xbe9ec318)=A0=A0=A0=A0 =3D -1 ENOENT (No such =
file or directory)
open("/lib/v5l/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such file =
or directory)
stat64("/lib/v5l", 0xbe9ec318)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT=
 (No such file or directory)
open("/lib/fast-mult/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No=
 such file or directory)
stat64("/lib/fast-mult/half", 0xbe9ec318) =3D -1 ENOENT (No such file o=
r directory)
open("/lib/fast-mult/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such=
 file or directory)
stat64("/lib/fast-mult", 0xbe9ec318)=A0=A0=A0 =3D -1 ENOENT (No such fi=
le or directory)
open("/lib/half/libpthread.so.0", O_RDONLY) =3D -1 ENOENT (No such file=
 or directory)
stat64("/lib/half", 0xbe9ec318)=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT (=
No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)=A0 =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\220D\0\000"...,=
 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D118596, ...}) =3D 0
mmap2(NULL, 115192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, =
0) =3D 0x40025000
mprotect(0x40037000, 28672, PROT_NONE)=A0 =3D 0
mmap2(0x4003e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_DENYWRITE, 3, 0x11) =3D 0x4003e000
mmap2(0x40040000, 4600, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x40040000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
open("/lib/libc.so.6", O_RDONLY)=A0=A0=A0=A0=A0=A0=A0 =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\10C\1\000"..., =
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1352528, ...}) =3D 0
mmap2(NULL, 1139084, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,=
 0) =3D 0x40042000
mprotect(0x4014b000, 32768, PROT_NONE)=A0 =3D 0
mmap2(0x40153000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x109) =3D 0x40153000
mmap2(0x40156000, 8588, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x40156000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x4001d000
syscall_983045(0x4001d3d0, 0x4001d3d0, 0x40024058, 0x4001daa8, 0x40, 0x=
40024058, 0, 0xf0005, 0x4002435c, 0x8034, 0x40024000, 0xbe9ecb3c, 0, 0x=
be9ec8a8, 0x40014464, 0x40001fd8, 0x20000010, 0x4001d3d0, 0xc2cc, 0, 0,=
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) =3D 0
mprotect(0x40153000, 8192, PROT_READ)=A0=A0 =3D 0
mprotect(0x4003e000, 4096, PROT_READ)=A0=A0 =3D 0
mprotect(0x40023000, 4096, PROT_READ)=A0=A0 =3D 0
epoll_wait(0x4001cf78, 0xbe9ece04, 0x4001d3d0, 0x3b34) =3D 258
ipc_subcall(0x4001cf80, 0xc, 0x4001d3d0, 0xffffffec) =3D 0
rt_sigaction(SIGRTMIN, {0x4002907c, [], SA_SIGINFO|0x4000000}, NULL, 8)=
 =3D 0
rt_sigaction(SIGRT_1, {0x40028f54, [], SA_RESTART|SA_SIGINFO|0x4000000}=
, NULL, 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
getrlimit(RLIMIT_STACK, {rlim_cur=3D8192*1024, rlim_max=3DRLIM_INFINITY=
}) =3D 0
futex(0xbe9ecc34, 0x7 /* FUTEX_??? */, 0) =3D -1 EPERM (Operation not p=
ermitted)
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_AN=
ONYMOUS, -1, 0) =3D 0x40159000
brk(0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x11000
brk(0x32000)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D 0x32000
mprotect(0x40159000, 4096, PROT_NONE)=A0=A0 =3D 0
clone(decrement_count get count_lock
decrement_count count =3D=3D 0=20
decrement_count before cond_wait=20
child_stack=3D0x40957fe8, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_S=
IGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLON=
E_CHILD_CLEARTID, parent_tidptr=3D0x409584d8, tls=3D0x40958930, child_t=
idptr=3D0x409584d8) =3D 259
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) =3D 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) =3D 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
nanosleep({2, 0}, {2, 0})=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 0
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_AN=
ONYMOUS, -1, 0) =3D 0x40959000
mprotect(0x40959000, 4096, PROT_NONE)=A0=A0 =3D 0
clone(increment_count get count_lock
increment_count before cond_signal
child_stack=3D0x41157fe8, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_S=
IGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLON=
E_CHILD_CLEARTID, parent_tidptr=3D0x411584d8, tls=3D0x41158930, child_t=
idptr=3D0x411584d8) =3D 260
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) =3D 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) =3D 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
nanosleep({10, 0}, {10, 0})=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
futex(0x409584d8, FUTEX_WAIT, 259, NULL


Source code as follows.
=A025 #include <stdio.h>
=A026 #include <unistd.h>
=A027 #include <stdlib.h>
=A028 #include <fcntl.h>
=A029 #include <pthread.h>
=A030
=A031 pthread_mutex_t count_lock;
=A032 pthread_cond_t count_nonzero;
=A033 unsigned count =3D 0;
=A034
=A035 void * decrement_count(void *arg)
=A036 {
=A037=A0=A0=A0=A0 pthread_mutex_lock (&count_lock);
=A038=A0=A0=A0=A0 printf("decrement_count get count_lock\n");
=A039=A0=A0=A0=A0 while(count=3D=3D0) {
=A040=A0=A0=A0=A0=A0=A0=A0=A0 printf("decrement_count count =3D=3D 0 \n=
");
=A041=A0=A0=A0=A0=A0=A0=A0=A0 printf("decrement_count before cond_wait =
\n");
=A042=A0=A0=A0=A0=A0=A0=A0=A0 pthread_cond_wait( &count_nonzero, &count=
_lock);
=A043=A0=A0=A0=A0=A0=A0=A0=A0 printf("decrement_count after cond_wait \=
n");
=A044=A0=A0=A0=A0 }
=A045=A0=A0=A0=A0 count =3D count -1;
=A046=A0=A0=A0=A0 pthread_mutex_unlock (&count_lock);
=A047 }
=A048
=A049 void * increment_count(void *arg)
=A050 {
=A051=A0=A0=A0=A0 int ret;
=A052=A0=A0=A0=A0 pthread_mutex_lock(&count_lock);
=A053=A0=A0=A0=A0 printf("increment_count get count_lock\n");
=A054=A0=A0=A0=A0 if(count=3D=3D0) {
=A055=A0=A0=A0=A0=A0=A0=A0=A0 printf("increment_count before cond_signa=
l\n");
=A056=A0=A0=A0=A0=A0=A0=A0=A0 if (ret =3D pthread_cond_signal(&count_no=
nzero))
=A057=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("***********error code=
pthread_cond_signal %d******* \n", ret);
=A058=A0=A0=A0=A0=A0=A0=A0=A0 printf("increment_count after cond_signal=
\n");
=A059=A0=A0=A0=A0 }
=A060=A0=A0=A0=A0 count=3Dcount+1;
=A061=A0=A0=A0=A0 pthread_mutex_unlock(&count_lock);
=A062 }
=A063
=A064 int main(void)
=A065 {
=A066=A0=A0=A0=A0 pthread_t tid1,tid2;
=A067=A0=A0=A0=A0 pthread_attr_t thread_attr1;
=A068=A0=A0=A0=A0 pthread_attr_t thread_attr2;
=A069=A0=A0=A0=A0 pthread_mutexattr_t mta;
=A070=A0=A0=A0=A0 pthread_mutexattr_init(&mta);
=A071=A0=A0=A0=A0 pthread_mutexattr_setprotocol(&mta, PTHREAD_PRIO_INHE=
RIT);
=A072
=A073=A0=A0=A0=A0 pthread_attr_init(&thread_attr1);
=A074=A0=A0=A0=A0 pthread_attr_init(&thread_attr2);
=A075
=A076=A0=A0=A0=A0 pthread_mutex_init(&count_lock, &mta);
=A077=A0=A0=A0=A0 pthread_cond_init(&count_nonzero, NULL);
=A078
=A079=A0=A0=A0=A0 pthread_create(&tid1, &thread_attr1, decrement_count,=
 NULL);
=A080=A0=A0=A0=A0 sleep(2);
=A081=A0=A0=A0=A0 pthread_create(&tid2, &thread_attr2, increment_count,=
 NULL);
=A082
=A083=A0=A0=A0=A0 sleep(10);
=A084=A0=A0=A0=A0 pthread_join(tid1, NULL);
=A085=A0=A0=A0=A0 pthread_join(tid2, NULL);
=A086=A0=A0 =A0=A0//pthread_exit(0);
=A087 }


Best Regards.
William Lai


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
