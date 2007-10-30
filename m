From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 21:52:01 +0100 (CET)
Message-ID: <11542808.1611171193777521160.JavaMail.www@wwinf6102>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:21219 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbXJ3UwF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 16:52:05 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6102.orange.nl (SMTP Server) with ESMTP id 2DCE41C00091
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 21:52:01 +0100 (CET)
Received: from wwinf6102 (wwinf6102 [172.22.153.29])
	by mwinf6102.orange.nl (SMTP Server) with ESMTP id 2A9171C00083
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 21:52:01 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Datum: 29/10/07 02:09 PM
> Van: "Steven Rostedt" 
> Aan: "Gerrit Binnenmars" 
> CC: linux-rt-users@vger.kernel.org
> Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> 
> 
> --
> On Sun, 28 Oct 2007, Gerrit Binnenmars wrote:
> 
> > Hello,
> >
> > Can someone send me a .config file that shows the options needed to get the interrupt off
> > timing values in preempt_max_latency, please. I only see a value of 0 in this file
> > I am using kernel 2.6.22.1 with the corresponding rt patch.
> >
> > Thanks in advance,
> 
> Make sure you have event trace and latency tracing as well as
> "Interrupts-off critical section latency timing".
> 
> Then you need to echo 0 > /proc/sys/kernel/preempt_max_latency.
> 
Hello Steve,

Thanks for your quick response, but the preempt_max_latency remains 0. Also the latency_hist shows no samples taken.
Can you or someone else have a look at the corresponding CONFIG options?

CONFIG_LTT_PROBE_LOCKING=m
# CONFIG_LTT_PROBE_STACK is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
CONFIG_PREEMPT_TRACE=y
CONFIG_EVENT_TRACE=y
CONFIG_FUNCTION_TRACE=y
# CONFIG_WAKEUP_TIMING is not set
CONFIG_LATENCY_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
CONFIG_CRITICAL_IRQSOFF_TIMING=y
CONFIG_INTERRUPT_OFF_HIST=y
CONFIG_CRITICAL_TIMING=y
CONFIG_DEBUG_TRACE_IRQFLAGS=y
CONFIG_LATENCY_TIMING=y
CONFIG_CRITICAL_LATENCY_HIST=y
CONFIG_LATENCY_HIST=y
CONFIG_MCOUNT=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

Greetings Gerrit

> -- Steve
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
