From: "Matthew Henschel" <henschel@capaccess.org>
Subject: RE: 3.8.10-rt1 not compiling
Date: Mon, 12 Aug 2013 18:04:08 -0400
Message-ID: <005001ce97a7$def65020$9ce2f060$@org>
References: <loom.20130809T204344-6@post.gmane.org> <20130812114447.GE23040@linutronix.de> <004601ce976e$8889ebe0$999dc3a0$@org> <5208FDB9.3060801@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:33280 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3HLWEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 18:04:13 -0400
Received: by mail-qa0-f49.google.com with SMTP id cr7so1298154qab.8
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Aug 2013 15:04:12 -0700 (PDT)
In-Reply-To: <5208FDB9.3060801@linutronix.de>
Content-Language: en-us
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nice cooking Sebastian. Thanks man.  I knew it would be an easy fix!
(huh?)

-Matt

root@darkstar:/usr/src# rm -rf linux-3.10.6
root@darkstar:/usr/src# tar xf /mnt/memory/slack/kern/linux-3.10.6.tar.=
xz=20
root@darkstar:/usr/src# cd linux-3.10.6
root@darkstar:/usr/src/linux-3.10.6# bzcat ../patch-3.10.6-rt3.patch.bz=
2 |patch -p1=20
patching file Documentation/hwlat_detector.txt
patching file Documentation/sysrq.txt
patching file Documentation/trace/histograms.txt
patching file arch/Kconfig
patching file arch/alpha/mm/fault.c
patching file arch/arm/Kconfig
patching file arch/arm/include/asm/switch_to.h
patching file arch/arm/include/asm/thread_info.h
patching file arch/arm/kernel/asm-offsets.c
patching file arch/arm/kernel/entry-armv.S
patching file arch/arm/kernel/perf_event_cpu.c
patching file arch/arm/kernel/process.c
patching file arch/arm/kernel/signal.c
patching file arch/arm/mach-at91/at91rm9200_time.c
patching file arch/arm/mach-at91/at91sam926x_time.c
patching file arch/arm/mach-exynos/platsmp.c
patching file arch/arm/mach-msm/platsmp.c
[SNIP]
patching file mm/swap.c
patching file mm/vmalloc.c
patching file mm/vmstat.c
patching file net/core/dev.c
patching file net/core/skbuff.c
patching file net/core/sock.c
patching file net/ipv4/icmp.c
patching file net/ipv4/ip_output.c
patching file net/ipv4/sysctl_net_ipv4.c
patching file net/mac80211/rx.c
patching file net/netfilter/core.c
patching file net/packet/af_packet.c
patching file net/rds/ib_rdma.c
patching file scripts/mkcompile_h
root@darkstar:/usr/src/linux-3.10.6# cp ../3.10.4.config.error ./.confi=
g
root@darkstar:/usr/src/linux-3.10.6# make oldconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:2503:0:
scripts/kconfig/menu.c: In function 'get_symbol_str':
scripts/kconfig/menu.c:567:18: warning: 'jump' may be used=20
uninitialized in this function [-Wmaybe-uninitialized]
scripts/kconfig/menu.c:528:19: note: 'jump' was declared here
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --oldconfig Kconfig
#
# configuration written to .config
#
root@darkstar:/usr/src/linux-3.10.6# make
scripts/kconfig/conf --silentoldconfig Kconfig
  SYSHDR =20
arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
  SYSHDR =20
arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
  SYSHDR =20
arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
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
  CC      init/do_mounts.o
[SNIP]
  IHEX    firmware/radeon/RV610_me.bin
  IHEX    firmware/radeon/RV630_pfp.bin
  IHEX    firmware/radeon/RV630_me.bin
  IHEX    firmware/radeon/RV620_pfp.bin
  IHEX    firmware/radeon/RV620_me.bin
  IHEX    firmware/radeon/RV635_pfp.bin
  IHEX    firmware/radeon/RV635_me.bin
  IHEX    firmware/radeon/RV670_pfp.bin
  IHEX    firmware/radeon/RV670_me.bin
  IHEX    firmware/radeon/RS780_pfp.bin
  IHEX    firmware/radeon/RS780_me.bin
  IHEX    firmware/radeon/RV770_pfp.bin
  IHEX    firmware/radeon/RV770_me.bin
  IHEX    firmware/radeon/RV730_pfp.bin
  IHEX    firmware/radeon/RV730_me.bin
  IHEX    firmware/radeon/RV710_pfp.bin
  IHEX    firmware/radeon/RV710_me.bin
root@darkstar:/usr/src/linux-3.10.6#

-----Original Message-----
=46rom: Sebastian Andrzej Siewior [mailto:bigeasy@linutronix.de]=20
Sent: Monday, August 12, 2013 11:23 AM
To: Matthew Henschel
Cc: linux-rt-users@vger.kernel.org
Subject: Re: 3.8.10-rt1 not compiling

On 08/12/2013 05:13 PM, Matthew Henschel wrote:
> Sebastian--

Hi Matthew,

> 	Same config as before, in fact, copied it from my original email, ra=
n it through fromdos, and:

=E2=80=A6

> kernel/built-in.o: In function `__tick_nohz_idle_enter':
> tick-sched.c:(.text+0x40db8): undefined reference to `softirq_check_p=
ending_idle'
> make: *** [vmlinux] Error 1

Hmm. I'm cooking v3.10.6-rt3 right now. If you see it there as well
please gimme a ping and take another look. As of now I assume that the
issue is gone somewhere between -rt1 and -rt3.

Sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
