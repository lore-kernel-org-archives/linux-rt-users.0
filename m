From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - hangs inside put_user
Date: Mon, 13 May 2013 01:20:32 +0200
Message-ID: <519023C0.2030603@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <518CEB45.9080705@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:36053 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab3ELXUm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 12 May 2013 19:20:42 -0400
In-Reply-To: <518CEB45.9080705@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10.05.2013 14:42, Stanislav Meduna wrote:

> 49762.928029 the timerfd thread gets the CPU, does not giveit back,
> but the end of the syscall is not reached in a sane time.

Hmm... I added some trace_printks into fs/timerfd.c:


static ssize_t timerfd_read(
{
...
	trace_printk("timerfd_read before unlock, res=%d", res);
	spin_unlock_irq(&ctx->wqh.lock);
	trace_printk("timerfd_read after unlock, res=%d", res);
	if (ticks)
		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
	trace_printk("timerfd_read return, res=%d, ticks=%llu, buf=%p", res, (unsigned long long) ticks, buf);
	return res;
}

The first two are printed. The last one is not.

0....0 timerfd_read: timerfd_read before unlock, res=0
0....0 timerfd_read: timerfd_read after unlock, res=0

The usual

0....0 timerfd_read: timerfd_read return, res=8, ticks=1, buf=0xb7600158

does _not_ happen here.

So it looks like the problem happens inside the put_user,
maybe a pagefault? The buf is an address on the stack:

while(alive) {
	u64 exp;

	if (read(tmrFd, &exp, sizeof(exp)) != sizeof(exp) || exp < 1)
		continue;
...

and the process is running with mlockall(MCL_CURRENT | MCL_FUTURE),
so the whole stack is forced into the RAM.

Viewing the ps -o min_flt,maj_flt for the task shows 969701
minor faults (that do not increment - I will check this when
the hang happens again) and 0 major ones.

This starts to look like some priority inversion where a realtime
thread is busy-waiting for something a SCHED_OTHER thread holds.
After the RT throttler kicks in, that other thread can proceed
and the system eventually recovers - unfortunately after
a 1+ second pause, which is what I am seeing.

Is there something that could cause stalling the whole realtime
thread for a significant time? Unfortunately I am not an expert
on memory management, pagefaults etc - but I guess this should
only produce a minor pagefault and that should never block?
Or am I seeing it wrong?

Regards
-- 
                                     Stano

