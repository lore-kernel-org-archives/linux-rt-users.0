From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.18.43-rt46
Date: Wed, 26 Oct 2016 09:43:12 -0400
Message-ID: <20161026094312.6ee6e88e@gandalf.local.home>
References: <20161020164801.0bbea1a8@gandalf.local.home>
        <7e3ad2f2475b41979a77419a8d99b6c0@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:50565 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932473AbcJZNnV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Oct 2016 09:43:21 -0400
In-Reply-To: <7e3ad2f2475b41979a77419a8d99b6c0@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 26 Oct 2016 10:37:01 +0000
"Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com> wrote:

> Hi Steven,
> 
> > Or to build 3.18.43-rt46 directly, the following patches should be applied:
> > 
> >   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz
> >   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.43.xz
> >   http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.43-rt46.patch.xz  
> I am using the patches as proposed.
> 
> However with this version I get lots of compiler warnings:
> 
> ./arch/x86/include/asm/preempt.h:118:6: warning: 'tmp' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   tmp &= ~PREEMPT_NEED_RESCHED;
>          ^
> ./arch/x86/include/asm/preempt.h:112:6: note: 'tmp' was declared here
>   u32 tmp;
>         ^
> 
> The relevant code is the following:
> 
> /*
>  * Returns true when we need to resched and can (barring IRQ state).
>  */
> static __always_inline bool should_resched(void)
> {
> #ifdef CONFIG_PREEMPT_LAZY
> 	u32 tmp;
> 
> 	if (!raw_cpu_read_4(__preempt_count))
> 		return true;
> 
> 	/* preempt count == 0 ? */
> 	tmp &= ~PREEMPT_NEED_RESCHED;
> 	if (tmp)
> 		return false;
> 	if (current_thread_info()->preempt_lazy_count)
> 		return false;
> 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
> #else
> 	return unlikely(!raw_cpu_read_4(__preempt_count));
> #endif
> }
> 
> And within this code tmp is actually not initialized, the warning is fine.
> This code is new with the patch-3.18.43-rt46.patch.xz.
> With the previous patch-3.18.42-rt44.patch.xz the code of should_resched
> was differently (much more compact) and did not show the warnings.

Thanks for the report. I'm just finishing up the stable pull of
3.18-rt, and after that, I'll be pulling in fixes for things like this.

-- Steve
