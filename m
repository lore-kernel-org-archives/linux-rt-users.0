From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - some traces
Date: Sun, 12 May 2013 19:31:12 +0200
Message-ID: <518FD1E0.1070400@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <518CEB45.9080705@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:52745 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3ELRbW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 May 2013 13:31:22 -0400
In-Reply-To: <518CEB45.9080705@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10.05.2013 14:42, Stanislav Meduna wrote:

> I have uploaded the trace.dat captured by
>   trace-cmd start -b 64000 -e irq -e sched -e syscalls -e timer

Actually the problem probably comes earlier. The thread with id 1276
normally tries to call setsockopt and then right after it
returns a select is called. See e.g. trace #914414 @ 49720.850080.
There is no way in the code it can wait for more than tens of
microseconds - no loop, no lock, just two function calls.

With -p function -n '*preempt_count' (which unfortunately changes
the timings so that the problem does not occur) there is nothing
logged between the calls as well, except the syscall_trace_entry
function.

However, at #1800630 @ 49762.927207 the setsockopt returns,
but the expected system call is not entered for 600 us
and no irq, sched or timer event is logged in between.

I also have another instance of the crash where the timing
is different - the thread runs for 4 ms with soft and hard
interrupts coming, so I am sure that this is not some SMI.
It really looks that something is spinning here.

At #1800649 the priority of the thread is boosted, i.e. there
most probably _is_ a PI lock held. It even looks to be unlocked
at #1800658 where the priority boost goes away.

Which one? What locking happens between sys_exit_socketcall
is logged and the time next syscall entry is logged?

The problem akso happens with the whole CONFIG_FTRACE subtree
disabled, so if there is some lock only present if the
tracers are present, it is not the (only) culprit.

Thanks
-- 
                                     Stano

