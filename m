From: Ingo Molnar <mingo@elte.hu>
Subject: v2.6.19-rt6, yum/rpm
Date: Tue, 5 Dec 2006 18:11:14 +0100
Message-ID: <20061205171114.GA25926@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>,
	Clark Williams <williams@redhat.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Giandomenico De Tullio <ghisha@email.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:59515 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968474AbWLERMH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 12:12:07 -0500
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

i have released the 2.6.19-rt6 tree, which can be downloaded from the 
usual place:

    http://redhat.com/~mingo/realtime-preempt/

more info about the -rt patchset can be found on the RT wiki:

  http://rt.wiki.kernel.org

this is a fixes-only release. Changes since -rt1:

 - fix !PREEMPT_RT build error (reported by Mike Galbraith)

 - tracer build fix (from Mike Galbraith) 

 - latest KVM (Kernel Virtual Machine) branch from Avi Kivity

 - itimer starvation fix (Thomas Gleixner)

 - tracer: fix 32-bit cycles regression (reported by Sergei Shtylyov)

 - kernel-rt-devel fix on i686: include asm-x86_64 to allow external 
   modules (such as FUSE) to build. (reported by Giandomenico De Tullio)

 - hrtimers: fix resume bug in migrate_hrtimers() causing possible 
   memory corruption

 - hrtimers: fix jiffy update order in hrtimer_notify_resume() to avoid 
   time warp after resume

 - lockdep: fix irq-disabling buglet causing boot lockup

 - seqlock: fix lockdep naming macro

 - acpi: keep all other ACPI locks non-raw (some ACPI critical sections 
   use the SLAB allocator, which is preemptible in -rt)

 - netconsole: fix rtl8139_poll_controller() to use _nosync disable

 - acpi: mark acpi_gbl_hardware_lock as raw, can be used in C3 idle code

 - acpi: fix irq-enable code in drivers/acpi/ec.c (

 - x86_64: fix SysRq-L (show all regs via NMI) feature

 - new debug helper: ignore_loglevel boot option

 - new debug helper: debug_direct_keyboard boot option

 - new debug helper: show nmi print callbacks from do_IRQ too

 - debug_direct_keyboard fix: turn off lockdep while this hack is 
   utilized

 - mark pci_config_lock raw, to fix boot crash

 - disable HPET for now, it's not working reliably and causes hangs

 - x86_64: fix dump_stack() smp_processor_id() warnings

 - make NMI watchdog asserts nondestructive

 - i686: restore /proc/interrupts output to upstream format

 - fix boot hang due across warm reboots

 - fix set_workqueue_thread_prio() bug resulting in boot hang

 - e1000: update to driver 7.3.15-k2 to fix latency problem

 - tracer updates: use the gtod clocksource for timestamping, to 
   increase the reliability of latency traces

 - tracer feature: trace_use_raw_cycles to force the use of TSC even 
   if it's not reliable

to build a 2.6.19-rt6 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rt6

the -rt YUM repository for Fedora Core 6 and 5, for architectures x86_64 
and i686 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo

   yum install kernel-rt.x86_64   # on x86_64
   yum install kernel-rt          # on i686

   yum update kernel-rt           # refresh - or enable yum-updatesd

(note: it will take 15-30 minutes from now on for the yum repository to 
be updated to -rt6)

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
