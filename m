From: John Sigler <linux.kernel@free.fr>
Subject: Re: NMI watchdog
Date: Mon, 15 Oct 2007 18:05:01 +0200
Message-ID: <47138FAD.8050805@free.fr>
References: <470F3BE0.4050807@free.fr> <20071012074836.79e6a064@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761773AbXJOQFY@vger.kernel.org>
In-Reply-To: <20071012074836.79e6a064@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Arjan van de Ven wrote:

> John Sigler wrote:
> 
>> I'm experiencing a full system lockup. I'm using an out-of-tree
>> driver which I suspect is responsible. I'm trying to enable the NMI
>> watchdog.
> 
> one thing worth a shot is enabling lockdep.. that often finds deadlocks
> for you ;)

I enabled every option I thought might be useful.

I booted the system, fired a serial console, bumped the priority of the 
serial port IRQ handler to 80 and the priority of the shell in the 
serial console to 70, set the console log level to 9 using SysRq.

I then connected via ssh, loaded the driver module (the output showed up 
in the serial console), started 4 processes, and had a complete system 
lock-up within 10 seconds.

Nothing on the serial console :-(

The system didn't even respond to SysRq...

How do kernel hackers debug these problems?

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_STACKTRACE=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_EVENT_TRACE is not set
# CONFIG_FUNCTION_TRACE is not set
# CONFIG_WAKEUP_TIMING is not set
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
