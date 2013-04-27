From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - was probably fixed in 3.4.38
Date: Sat, 27 Apr 2013 10:34:25 +0200
Message-ID: <517B8D91.4010700@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:60672 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab3D0Ief (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Apr 2013 04:34:35 -0400
In-Reply-To: <516FB8B9.9090506@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18.04.2013 11:11, Stanislav Meduna wrote:

> from a new log that includes syscall tracing it seems that a thread
> waiting in a timerfd is woken, but does not return from the read:

For the record, the problem seems to be the issue that the
http://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.4-rt&id=52cecaa
fixed in v3.4.38-rt52 (tracing: Fix free of probe entry by calling
call_rcu_sched()). A kernel with just this commit reverted stalled
once per ~4 hours, with this one it did not stall in ~24h (I will
surely try to run it longer).

Why did is always manifest itself by hanging in return from timerfd
read (and not e.g. when timer_create and friends were used) is beyond
me, but there will be a reason.

Sorry for the false alarm, it was already fixed at the time I reported
it - it is just that one wants to know the reason before updating
to a brand new kernel with 750+ other changes.


A general question: I am seeing a few recent changes in the tracing
code. Is it generally safe to have at least latency histogram enabled
in the production code, or is it advised not to compile these features
in? I'd like to see the latencies the customer is getting in the real
environment, but if the code is considered as work-in-progress,
it is better to play it safe.

Thanks
-- 
                                           Stano

