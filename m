From: "Matthew Henschel" <henschel@capaccess.org>
Subject: RE: 3.8.10-rt1 not compiling
Date: Mon, 12 Aug 2013 11:13:42 -0400
Message-ID: <004601ce976e$8889ebe0$999dc3a0$@org>
References: <loom.20130809T204344-6@post.gmane.org> <20130812114447.GE23040@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:33652 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3HLPNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 11:13:47 -0400
Received: by mail-qe0-f41.google.com with SMTP id a11so3686139qen.0
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Aug 2013 08:13:45 -0700 (PDT)
In-Reply-To: <20130812114447.GE23040@linutronix.de>
Content-Language: en-us
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian--
	Same config as before, in fact, copied it from my original email, ran it through fromdos, and:





MonAug12.10:52am?/usr/src# rm -rf linux-3.10.4/
MonAug12.10:52am?/usr/src# tar xf /mnt/memory/linux-3.10.4.tar.xz
MonAug12.10:53am?/usr/src# cd linux-3.10.4
MonAug12.10:53am?/usr/src/linux-3.10.4# bzcat /mnt/memory/patch-3.10.4-rt1.patch.bz2 |patch -p1
patching file arch/sparc/kernel/setup_32.c
patching file arch/sparc/kernel/setup_64.c
patching file include/linux/notifier.h
patching file include/linux/srcu.h
patching file include/linux/netdevice.h
patching file net/core/dev.c
[.......................SNIP........................]
patching file drivers/net/Kconfig
patching file mm/Kconfig
patching file init/Makefile
patching file scripts/mkcompile_h
MonAug12.10:54am?/usr/src/linux-3.10.4# cp ../3.10.4.config.error ./.config
MonAug12.10:54am?/usr/src/linux-3.10.4# make
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:2503:0:
scripts/kconfig/menu.c: In function 'get_symbol_str':
scripts/kconfig/menu.c:567:18: warning: 'jump' may be used uninitialized in this function [-Wmaybe-uninitialized]
scripts/kconfig/menu.c:528:19: note: 'jump' was declared here
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/syscalls/../include/generated/asm/syscalls_32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  WRAP    arch/x86/include/generated/asm/clkdev.h
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  CC      scripts/mod/devicetable-offsets.s
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  HOSTCC  scripts/sortextable
  CC      init/main.o
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
[..................SNIP.....................]
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
kernel/built-in.o: In function `__tick_nohz_idle_enter':
tick-sched.c:(.text+0x40db8): undefined reference to `softirq_check_pending_idle'
make: *** [vmlinux] Error 1
Exit 2
MonAug12.11:17am?/usr/src/linux-3.10.4# uname -a
Linux darkstar 3.10.4-smp-mjh-mk1 #2 SMP PREEMPT Fri Aug 9 08:12:39 EDT 2013 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux
MonAug12.11:19am?/usr/src/linux-3.10.4# gcc -v
Reading specs from /usr/lib/gcc/i486-slackware-linux/4.7.1/specs
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/i486-slackware-linux/4.7.1/lto-wrapper
Target: i486-slackware-linux
Configured with: ../gcc-4.7.1/configure --prefix=/usr --libdir=/usr/lib --mandir=/usr/man --infodir=/usr/info --enable-shared --enable-bootstrap --enable-languages=ada,c,c++,fortran,go,java,lto,objc --enable-threads=posix --enable-checking=release --enable-objc-gc --with-system-zlib --with-python-dir=/lib/python2.7/site-packages --disable-libunwind-exceptions --enable-__cxa_atexit --enable-libssp --enable-lto --with-gnu-ld --verbose --enable-java-home --with-java-home=/usr/lib/jvm/jre --with-jvm-root-dir=/usr/lib/jvm --with-jvm-jar-dir=/usr/lib/jvm/jvm-exports --with-arch-directory=i386 --with-antlr-jar=/root/slackware-current/source/d/gcc/antlr-runtime-3.4.jar --enable-java-awt=gtk --disable-gtktest --with-arch=i486 --target=i486-slackware-linux --build=i486-slackware-linux --host=i486-sl
 ackware-linux
Thread model: posix
gcc version 4.7.1 (GCC)
MonAug12.11:19am?/usr/src/linux-3.10.4#

-----Original Message-----
From: Sebastian Andrzej Siewior [mailto:bigeasy@linutronix.de] 
Sent: Monday, August 12, 2013 7:45 AM
To: matthew henschel
Cc: linux-rt-users@vger.kernel.org
Subject: Re: 3.8.10-rt1 not compiling

* matthew henschel | 2013-08-09 18:46:15 [+0000]:

>probably a simple fix:
>[output snipped]
>  LD      vmlinux.o
>  MODPOST vmlinux.o
>  GEN     .version
>  CHK     include/generated/compile.h
>  UPD     include/generated/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>kernel/built-in.o: In function `__tick_nohz_idle_enter':
>tick-sched.c:(.text+0x40db8): undefined reference to
>`softirq_check_pending_idle'
>make: *** [vmlinux] Error 1
>Exit 2

Can you clean your tree and recompile? There seems to be something out
of sync. Both __tick_nohz_idle_enter() and softirq_check_pending_idle()
are behind CONFIG_NO_HZ_COMMON so it is unlikely that in a normal
build you have one symbol but not the other.
I took your config file, removed radeon/R200_cp.bin from it and it built
without a problem.

Sebastian

