From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt4
Date: Sat, 27 Oct 2007 16:22:12 +0200
Message-ID: <47234994.5040503@gmx.net>
References: <1193454991.5623.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750796AbXJ0OYq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 10:24:46 -0400
In-Reply-To: <1193454991.5623.27.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
> We are pleased to announce the 2.6.23.1-rt4 tree, which can be
> downloaded from the location:
>
>  http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Changes since 2.6.23-rt3
>
>   - Updated to stable release 2.6.23.1
>
>   - Added latest High Resolution timers work
>
>   - RT Balance CPU weight optimization (Gregory Haskins)
>
>   - Limit to NUMA Node RT Balance (Steven Rostedt)
>
>   - Workqueue PI sched.h compile fix (Clark Williams)
>
>   - plist debug init fix (Jan Kiszka)
>
>   - Kconfig updates (Carsten Emde)
>
>   - IRQ flags recalculation fix (Paul Gortmaker)
>
> to build a 2.6.23-rt3 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.1-rt4.bz2
>
> The broken out patches are also available.
>
> -- Steve
>
>   
hallo, i downloaded the 2.6.23.1 kernel and the rt-patch, but it does 
not build here.
the configuration is the same as i used in the 2.6.23-rt3.

here is the console output, if you have any idea, pleas help me out:

nowhiskey@murija2:/usr/src/linux-2.6.23.1$ make && make modules
scripts/kconfig/conf -s arch/i386/Kconfig
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-i386
  CC      arch/i386/kernel/asm-offsets.s
  GEN     include/asm-i386/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  LD      init/mounts.o
  CC      init/noinitramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  LD      usr/built-in.o
  CC      arch/i386/kernel/process.o
  CC      arch/i386/kernel/signal.o
  AS      arch/i386/kernel/entry.o
  CC      arch/i386/kernel/traps.o
  CC      arch/i386/kernel/irq.o
  CC      arch/i386/kernel/ptrace.o
  CC      arch/i386/kernel/time.o
  CC      arch/i386/kernel/ioport.o
  CC      arch/i386/kernel/ldt.o
  CC      arch/i386/kernel/setup.o
  CC      arch/i386/kernel/i8259.o
  CC      arch/i386/kernel/sys_i386.o
  CC      arch/i386/kernel/pci-dma.o
  CC      arch/i386/kernel/i386_ksyms.o
  CC      arch/i386/kernel/i387.o
  CC      arch/i386/kernel/bootflag.o
  CC      arch/i386/kernel/e820.o
  CC      arch/i386/kernel/quirks.o
  CC      arch/i386/kernel/i8237.o
  CC      arch/i386/kernel/topology.o
  CC      arch/i386/kernel/alternative.o
  CC      arch/i386/kernel/i8253.o
  CC      arch/i386/kernel/tsc.o
  CC      arch/i386/kernel/acpi/boot.o
  CC      arch/i386/kernel/acpi/earlyquirk.o
  CC      arch/i386/kernel/acpi/sleep.o
  AS      arch/i386/kernel/acpi/wakeup.o
  LD      arch/i386/kernel/acpi/built-in.o
  CC      arch/i386/kernel/cpu/common.o
  CC      arch/i386/kernel/cpu/proc.o
  CC      arch/i386/kernel/cpu/bugs.o
  CC      arch/i386/kernel/cpu/amd.o
  CC      arch/i386/kernel/cpu/cyrix.o
  CC      arch/i386/kernel/cpu/centaur.o
  CC      arch/i386/kernel/cpu/transmeta.o
  CC      arch/i386/kernel/cpu/intel.o
  CC      arch/i386/kernel/cpu/intel_cacheinfo.o
  CC      arch/i386/kernel/cpu/addon_cpuid_features.o
  CC      arch/i386/kernel/cpu/nexgen.o
  CC      arch/i386/kernel/cpu/umc.o
  CC      arch/i386/kernel/cpu/mcheck/mce.o
  CC      arch/i386/kernel/cpu/mcheck/k7.o
  CC      arch/i386/kernel/cpu/mcheck/p4.o
  CC      arch/i386/kernel/cpu/mcheck/p5.o
  CC      arch/i386/kernel/cpu/mcheck/p6.o
  CC      arch/i386/kernel/cpu/mcheck/winchip.o
  CC      arch/i386/kernel/cpu/mcheck/therm_throt.o
  LD      arch/i386/kernel/cpu/mcheck/built-in.o
  CC [M]  arch/i386/kernel/cpu/mcheck/non-fatal.o
  CC      arch/i386/kernel/cpu/mtrr/main.o
  CC      arch/i386/kernel/cpu/mtrr/if.o
  CC      arch/i386/kernel/cpu/mtrr/generic.o
  CC      arch/i386/kernel/cpu/mtrr/state.o
  CC      arch/i386/kernel/cpu/mtrr/amd.o
  CC      arch/i386/kernel/cpu/mtrr/cyrix.o
  CC      arch/i386/kernel/cpu/mtrr/centaur.o
  LD      arch/i386/kernel/cpu/mtrr/built-in.o
  CC      arch/i386/kernel/cpu/perfctr-watchdog.o
  LD      arch/i386/kernel/cpu/built-in.o
  CC      arch/i386/kernel/reboot.o
  CC      arch/i386/kernel/msr.o
  CC      arch/i386/kernel/microcode.o
  CC      arch/i386/kernel/mpparse.o
  CC      arch/i386/kernel/apic.o
  CC      arch/i386/kernel/nmi.o
  CC      arch/i386/kernel/io_apic.o
  CC      arch/i386/kernel/module.o
  CC      arch/i386/kernel/sysenter.o
  LDS     arch/i386/kernel/vsyscall.lds
  AS      arch/i386/kernel/vsyscall-int80.o
  AS      arch/i386/kernel/vsyscall-note.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
  AS      arch/i386/kernel/vsyscall-sysenter.o
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
  AS      arch/i386/kernel/vsyscall.o
  CC      arch/i386/kernel/doublefault.o
  CC      arch/i386/kernel/vm86.o
  CC      arch/i386/kernel/early_printk.o
  CC      arch/i386/kernel/hpet.o
  CC      arch/i386/kernel/pcspeaker.o
  SYSCALL arch/i386/kernel/vsyscall-syms.o
  LD      arch/i386/kernel/built-in.o
  AS      arch/i386/kernel/head.o
  CC      arch/i386/kernel/init_task.o
  LDS     arch/i386/kernel/vmlinux.lds
  CC [M]  arch/i386/kernel/cpuid.o
  CC      arch/i386/mm/init.o
  CC      arch/i386/mm/pgtable.o
  CC      arch/i386/mm/fault.o
  CC      arch/i386/mm/ioremap.o
  CC      arch/i386/mm/extable.o
  CC      arch/i386/mm/pageattr.o
  CC      arch/i386/mm/mmap.o
  CC      arch/i386/mm/hugetlbpage.o
  LD      arch/i386/mm/built-in.o
  CC      arch/i386/mach-default/setup.o
  LD      arch/i386/mach-default/built-in.o
  LD      arch/i386/crypto/built-in.o
  AS [M]  arch/i386/crypto/aes-i586-asm.o
  CC [M]  arch/i386/crypto/aes.o
  LD [M]  arch/i386/crypto/aes-i586.o
  CC      kernel/sched.o
In file included from kernel/sched.c:863:
kernel/sched_rt.c: In function 'rt_overloaded':
kernel/sched_rt.c:21: error: 'struct rq' has no member named 'cpu'
kernel/sched_rt.c: In function 'rt_overload':
kernel/sched_rt.c:25: error: 'struct rq' has no member named 'cpu'
kernel/sched_rt.c: In function 'rt_set_overload':
kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
kernel/sched_rt.c:29: error: 'struct rq' has no member named 'cpu'
kernel/sched_rt.c: In function 'rt_clear_overload':
kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
kernel/sched_rt.c:33: error: 'struct rq' has no member named 'cpu'
make[1]: *** [kernel/sched.o] Fehler 1
make: *** [kernel] Fehler 2
nowhiskey@murija2:/usr/src/linux-2.6.23.1$


...........

thanks and cheers,
doc
