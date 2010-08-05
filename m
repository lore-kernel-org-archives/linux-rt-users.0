From: Javier Sanz <jsanza@gmail.com>
Subject: problem nvidia driver 256.44 and linux 2.6.33.7-rt29
Date: Thu, 5 Aug 2010 15:39:47 +0200
Message-ID: <AANLkTin7FS1cKqXCSrvzgvWvQt0WPgkJ-9g90fCOQaVj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37113 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760004Ab0HENjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Aug 2010 09:39:49 -0400
Received: by ywh1 with SMTP id 1so2466864ywh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Aug 2010 06:39:48 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

As usually, lastest nvidia drivers cannot be used with linux -rt. serie=
s

I've tried to compile the nvidia module v256.44 into  linux 2.6.33.7-rt=
29 ..

And the following is the error log

nvidia-installer log file '/var/log/nvidia-installer.log'
creation time: Wed Aug 4 23:17:03 2010
installer version: 256.44

Using: nvidia-installer ncurses user interface
-> Only installing a kernel module for a non-running kernel; skipping t=
he "is
an X server running?" test.
-> Only installing a kernel module for a non-running kernel; skipping t=
he "is
an NVIDIA kernel module loaded?" test.
-> License accepted.
-> Installing NVIDIA driver version 256.44.
-> Not probing for precompiled kernel interfaces.
-> Performing CC sanity check with CC=3D"cc".
-> Kernel source path: '/lib/modules/2.6.33.7-rt29/source'
-> Kernel output path: '/lib/modules/2.6.33.7-rt29/build'
-> Performing rivafb check.
-> Performing nvidiafb check.
-> Performing Xen check.
-> Cleaning kernel module build directory.
executing: 'cd ./kernel; make clean'...
-> Building kernel module:
executing: 'cd ./kernel; make module SYSSRC=3D/lib/modules/2.6.33.7-rt2=
9/sourc
e SYSOUT=3D/lib/modules/2.6.33.7-rt29/build'...
NVIDIA: calling KBUILD...
make -C /lib/modules/2.6.33.7-rt29/build \
KBUILD_SRC=3D/usr/src/kernels/linux-2.6.33.7-rt29 \
KBUILD_EXTMOD=3D"/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel" -f /us=
r/src/
kernels/linux-2.6.33.7-rt29/Makefile \
modules
test -e include/generated/autoconf.h -a -e include/config/auto.conf || =
( \
echo; \
echo " ERROR: Kernel configuration is invalid."; \
echo " include/generated/autoconf.h or include/config/auto.conf are
missing.";\
echo " Run 'make oldconfig && make prepare' on kernel src to fix it
=2E"; \
echo; \
/bin/false)
mkdir -p /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/.tmp_versions ;=
 rm -
f /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/.tmp_versions/*
make -f /usr/src/kernels/linux-2.6.33.7-rt29/scripts/Makefile.build obj=
=3D/tmp
/selfgz2864/NVIDIA-Linux-x86-256.44/kernel
cc -Wp,-MD,/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/.nv.o.d -nost=
di
nc -isystem /usr/lib/gcc/i686-redhat-linux/4.4.4/include -I/usr/src/ker=
nels/
linux-2.6.33.7-rt29/arch/x86/include -Iinclude -I/usr/src/kernels/linux=
-2.6
=2E33.7-rt29/include -include include/generated/autoconf.h -I/tmp/selfg=
z2864
/NVIDIA-Linux-x86-256.44/kernel -D__KERNEL__ -Wall -Wundef -Wstrict-pro=
totyp
es -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-fun=
ction
-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -=
m32 -
msoft-float -mregparm=3D3 -freg-struct-return -mpreferred-stack-boundar=
y=3D2 -ma
rch=3Di686 -mtune=3Dcore2 -mtune=3Dgeneric -Wa,-mtune=3Dgeneric32 -ffre=
estanding -fs
tack-protector -DCONFIG_AS_CFI=3D1 -DCONFIG_AS_CFI_SIGNAL_FRAME=3D1 -pi=
pe -Wno-s
ign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2=
 -mno
-3dnow -Wframe-larger-than=3D1024 -fno-omit-frame-pointer -fno-optimize=
-siblin
g-calls -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-ove=
rflow
-fno-dwarf2-cfi-asm -fconserve-stack -I/tmp/selfgz2864/NVIDIA-Linux-x86=
-25
6.44/kernel -Wall -MD -Wsign-compare -Wno-cast-qual -Wno-error -D__KERN=
EL__
-DMODULE -DNVRM -DNV_VERSION_STRING=3D\"256.44\" -UDEBUG -
U_DEBUG -DNDEBUG -DMODULE -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DK=
BUILD_ST
R(nv)" -D"KBUILD_MODNAME=3DKBUILD_STR(nvidia)" -c -o /tmp/selfgz2864/NV=
IDIA-
Linux-x86-256.44/kernel/nv.o /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/ke=
rnel/
nv.c
In file included from /usr/src/kernels/linux-2.6.33.7-rt29/arch/x86/inc=
lude/
asm/uaccess.h:571,
from include/linux/poll.h:13,
from /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv-linu
x.h:84,
from /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:13
:
/usr/src/kernels/linux-2.6.33.7-rt29/arch/x86/include/asm/uaccess_32.h:=
 In f
unction =91copy_from_user=92:
/usr/src/kernels/linux-2.6.33.7-rt29/arch/x86/include/asm/uaccess_32.h:=
209:
warning: comparison between signed and unsigned integer expressions
In file included from /tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv=
=2Ec:13
:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv-linux.h: At top level=
:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv-linux.h:221: error: e=
xpect
ed =91=3D=92, =91,=92, =91;=92, =91asm=92 or =91__attribute__=92 before=
 =91nv_
spinlock_t=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv-linux.h:1366: error: =
expec
ted specifier-qualifier-list before =91nv_spinlock_t=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c: In function =91nv_=
alloc
_file_private=92:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2047: error: implic=
it de
claration of function =91semaphore_init=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2048: error: =91nv_=
file_
private_t=92 has no member named =91waitqueue=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2049: error: implic=
it de
claration of function =91atomic_spin_lock_init=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2049: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c: In function =91nv_=
kern_
poll=92:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2837: error: =91nv_=
file_
private_t=92 has no member named =91waitqueue=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2840: error: implic=
it de
claration of function =91atomic_spin_lock_irqsave=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2840: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2851: error: implic=
it de
claration of function =91atomic_spin_unlock_irqrestore=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:2851: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c: In function =91nv_=
post_
event=92:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4206: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4223: error: =91nv_=
file_
private_t=92 has no member named =91waitqueue=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4224: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c: In function =91nv_=
get_e
vent=92:
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4238: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4241: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.c:4266: error: =91nv_=
file_
private_t=92 has no member named =91fp_lock=92
make[4]: *** [/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel/nv.o] Erro=
r 1
make[3]: *** [_module_/tmp/selfgz2864/NVIDIA-Linux-x86-256.44/kernel] E=
rror
2
make[2]: *** [sub-make] Error 2
NVIDIA: left KBUILD.
nvidia.ko failed to build!
make[1]: *** [module] Error 1
make: *** [module] Error 2
-> Error.
ERROR: Unable to build the NVIDIA kernel module.
ERROR: Installation has failed. Please see the file

Any patch to fix it ?
Thank you
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
