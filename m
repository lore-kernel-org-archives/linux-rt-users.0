From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in wakeup_next_waiter()
Date: Thu, 08 Jul 2010 19:11:49 -0700
Message-ID: <4C368565.3020806@us.ibm.com>
References: <1278478019.10245.77.camel@marge.simson.net> <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <efault@gmx.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:48349 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0GICMB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Jul 2010 22:12:01 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6924DEq000528
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 20:04:13 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id o692C0lf208156
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 20:12:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o692Bs7W004828
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 20:11:56 -0600
In-Reply-To: <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/07/2010 04:57 AM, Thomas Gleixner wrote:
> Cc'ing Darren.
> 
> On Wed, 7 Jul 2010, Mike Galbraith wrote:
> 
>> Greetings,
>>
>> Stress testing, looking to trigger RCU stalls, I've managed to find a
>> way to repeatably create fireworks.  (got RCU stall, see attached)

<snip>
embarrassing ltp realtime/perf/latency/pthread_cond_many breakage </snip>

>> 4. run it.
>>
>> What happens here is we hit WARN_ON(pendowner->pi_blocked_on != waiter),
>> this does not make it to consoles (poking sysrq-foo doesn't either).
>> Next comes WARN_ON(!pendowner->pi_blocked_on), followed by the NULL
>> explosion, which does make it to consoles.

So the WARN_ON sequence is obviously wrong, if it's critical it should
be a BUG(), if not we shouldn't dereference what we know to be null. The
following patch avoids the NULL pointer dereference in the WARN_ON. With
this patch the NULL WARN_ON makes it to the console, and test runs to
completion with no obvious negative side effects. I'm only posting for
reference at this point, as while this may be necessary, it isn't the
right "solution".

Some other data points from what time I could spend on this today.

FC12 kernel (2.6.31 based) has Requeue PI support, but does not exhibit
this behavior.

2.6.33.5-rt23 without CONFIG_PREEMPT_RT does NOT exhibit this behavior.

2.6.33.5-rt23 does exhibit this behavior.

The minimal tracing I attempted (a handful of trace_printk's and run
with the nop plugin) all prevented the crash from happening.

There appears to be no correlation to pi_blocked_on being NULL and the
next pointer being NULL (I saw a roughly equivalent mix of NULL and
valid pointers for next when pi_blocked_on was NULL).

Tonight/Tomorrow I'll review the rtmutex and futex code to try and fully
understand (again) the usage of pi_blocked_on and if we need to avoid
this scenario, or if we need to handle it "gracefully".

>From fa6a6bee6e467d12d3774612c838703acd265ea6 Mon Sep 17 00:00:00 2001
From: Darren Hart <dvhltc@us.ibm.com>
Date: Thu, 8 Jul 2010 19:44:35 -0400
Subject: [PATCH] rtmutex: avoid warnon bug

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
---
 kernel/rtmutex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 23dd443..a2fcaa5 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -579,9 +579,9 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 
 	raw_spin_lock(&pendowner->pi_lock);
 
-	WARN_ON(!pendowner->pi_blocked_on);
 	WARN_ON(pendowner->pi_blocked_on != waiter);
-	WARN_ON(pendowner->pi_blocked_on->lock != lock);
+	if (!WARN_ON(!pendowner->pi_blocked_on))
+		WARN_ON(pendowner->pi_blocked_on->lock != lock);
 
 	pendowner->pi_blocked_on = NULL;
 
-- 
1.6.5.2


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
