From: Stanislav Meduna <stano@meduna.org>
Subject: [PATCH] Re: timerfd read does not return
Date: Mon, 22 Apr 2013 09:35:30 +0200
Message-ID: <5174E842.4050408@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <5171A0D0.8050100@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:57507 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab3DVHfm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 03:35:42 -0400
In-Reply-To: <5171A0D0.8050100@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 19.04.2013 21:53, Stanislav Meduna wrote:

>> There is no return from the read until the RT throttler got activated.
>> Kernel version 3.4.25-rt37 - I'll check whether anything relevant
>> has changed since then.

FWIW, the following patch seems to solve the issue for me.
Unfortunately I have no idea whether this is a sane way to
do and whether it solves or just masks or delays the issue,
I just decided to try it after seeing http://lkml.org/lkml/2012/2/8/487

Note that in my case the ksoftirqd has lower priority than
the thread reading the timerfd, so the latter gets woken up
immediately and it is well possible and usual that it returns
into the kernel to do another read before the hrtimer softirq
ends. Would it be possible that there is some race in this
situation?


diff --git a/fs/timerfd.c b/fs/timerfd.c
index 57f0e4e..b06ba86 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -222,6 +222,7 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
                ctx->ticks = 0;
        }
        spin_unlock_irq(&ctx->wqh.lock);
+       hrtimer_wait_for_timer(&ctx->tmr);
        if (ticks)
                res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
        return res;


Thanks
-- 
                                         Stano

