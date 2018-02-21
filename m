Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:40840 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932970AbeBUNBq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Feb 2018 08:01:46 -0500
Date: Wed, 21 Feb 2018 07:01:27 -0600
From: Julia Cartwright <julia@ni.com>
Subject: Re: Linux 4.9 RT stable has a merge conflict
Message-ID: <20180221130127.GN951@jcartwri.amer.corp.natinst.com>
References: <ac8b02c9-a4e5-0707-187f-8243b9b7ff25@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac8b02c9-a4e5-0707-187f-8243b9b7ff25@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Hey Dan-

On Mon, Feb 19, 2018 at 09:17:37AM -0600, Dan Murphy wrote:
> Julia
> 
> The latest 4.9 stable dot release has a conflict on the following files
> 
> 	both modified:   arch/x86/include/asm/thread_info.h
> 	both modified:   kernel/time/posix-timers.c
> 	both modified:   kernel/workqueue.c
> 
> Attached is the output file from the conflict
> 
> Can you please resolve this conflict and update the 4.9 rt stable branch?

Yes, that is the role of a maintainer :).  I've got a preliminary
resolution (see below), and will do testing over the next few days
before releasing it.

Thanks,
   Julia

--
diff --cc arch/x86/include/asm/thread_info.h
index 5ceb3a1c2b1a,89978b9c667a..b65c6705d6b9
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@@ -54,8 -54,7 +54,9 @@@ struct task_struct
  
  struct thread_info {
  	unsigned long		flags;		/* low level flags */
 +	int                     preempt_lazy_count;     /* 0 => lazy preemptable
 +							   <0 => BUG */
+ 	u32			status;		/* thread synchronous flags */
  };
  
  #define INIT_THREAD_INFO(tsk)			\
diff --cc kernel/time/hrtimer.c
index 369203af6406,54fd2fed36e9..bb0bf0651b99
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@@ -1824,14 -1610,11 +1826,15 @@@ int hrtimers_prepare_cpu(unsigned int c
  	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
  		cpu_base->clock_base[i].cpu_base = cpu_base;
  		timerqueue_init_head(&cpu_base->clock_base[i].active);
 +		INIT_LIST_HEAD(&cpu_base->clock_base[i].expired);
  	}
  
+ 	cpu_base->active_bases = 0;
  	cpu_base->cpu = cpu;
  	hrtimer_init_hres(cpu_base);
 +#ifdef CONFIG_PREEMPT_RT_BASE
 +	init_waitqueue_head(&cpu_base->wait);
 +#endif
  	return 0;
  }
  
diff --cc kernel/time/posix-timers.c
index 464a98155a0e,fc7c37ad90a0..d4ee07e00b74
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@@ -506,20 -506,23 +506,26 @@@ static enum hrtimer_restart posix_timer
  static struct pid *good_sigevent(sigevent_t * event)
  {
  	struct task_struct *rtn = current->group_leader;
 +	int sig = event->sigev_signo;
  
- 	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
- 		(!(rtn = find_task_by_vpid(event->sigev_notify_thread_id)) ||
- 		 !same_thread_group(rtn, current) ||
- 		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
+ 	switch (event->sigev_notify) {
+ 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
+ 		rtn = find_task_by_vpid(event->sigev_notify_thread_id);
+ 		if (!rtn || !same_thread_group(rtn, current))
+ 			return NULL;
+ 		/* FALLTHRU */
+ 	case SIGEV_SIGNAL:
+ 	case SIGEV_THREAD:
+ 		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
+ 			return NULL;
++		if (sig_kernel_only(event->sigev_signo) ||
++		    sig_kernel_coredump(event->sigev_signo)
++			return NULL;
+ 		/* FALLTHRU */
+ 	case SIGEV_NONE:
+ 		return task_pid(rtn);
+ 	default:
  		return NULL;
- 
- 	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
- 	    (sig <= 0 || sig > SIGRTMAX || sig_kernel_only(sig) ||
- 	     sig_kernel_coredump(sig)))
- 		return NULL;
- 
- 	return task_pid(rtn);
 -	}
  }
  
  void posix_timers_register_clock(const clockid_t clock_id,
diff --cc kernel/workqueue.c
index 7eed129f114a,ebfea5f94b66..0750110471e4
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@@ -48,8 -48,7 +48,9 @@@
  #include <linux/nodemask.h>
  #include <linux/moduleparam.h>
  #include <linux/uaccess.h>
 +#include <linux/locallock.h>
 +#include <linux/delay.h>
+ #include <linux/nmi.h>
  
  #include "workqueue_internal.h"
  
@@@ -4492,9 -4458,15 +4499,15 @@@ void show_workqueue_state(void
  		pr_cont("\n");
  	next_pool:
  		spin_unlock_irqrestore(&pool->lock, flags);
+ 		/*
+ 		 * We could be printing a lot from atomic context, e.g.
+ 		 * sysrq-t -> show_workqueue_state(). Avoid triggering
+ 		 * hard lockup.
+ 		 */
+ 		touch_nmi_watchdog();
  	}
  
 -	rcu_read_unlock_sched();
 +	rcu_read_unlock();
  }
  
  /*
