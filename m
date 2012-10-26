From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: loading pages to memory causes high latency
Date: Fri, 26 Oct 2012 23:04:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210262254560.2756@ionos>
References: <508ACFCF.8040001@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36142 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045Ab2JZVE4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2012 17:04:56 -0400
In-Reply-To: <508ACFCF.8040001@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 26 Oct 2012, Stanislav Meduna wrote:
> Hi all,
> 
> I have an application that absolutely has to meet a 100 ms deadline.
> All threads of the application are SCHED_RR ones with priority
> that is higher than any other userspace process in the system and
> also than the irq handler of the PATA controller.
> 
> The command
> 
>  sync ; echo 3 > /proc/sys/vm/drop_caches ; cat /var/log/* > /dev/null
> 
> which is around 6 MB of data needed to fetch from a CF card:
> 
> - immediately causes [sched_delayed] sched: RT throttling activated,
>   even if there is _no_ RT application started yet. That means
>   that it is probably the irq task itself that is triggering it,
>   penalizing all other good-behaving RT tasks
> 
> # ps -eLo pid,class,rtprio,comm  | egrep 'RR|FF'
>     3 FF       1 ksoftirqd/0
>     6 FF      99 posixcputmr/0
>    27 FF      22 irq/14-pata_cs5
>    32 FF      50 irq/15-ehci_hcd
>    33 FF      50 irq/15-ohci_hcd
>    34 FF      50 irq/8-rtc0
>   417 FF      50 irq/5-eth0
>   438 FF      50 irq/15-eth1
> 
> 
> - causes the process to block for a time that is much longer
>   than I am comfortable with.
> 
> The command
>   echo 1000000 > /proc/sys/kernel/sched_rt_runtime_us
> fixes the problem but is not really something I want
> to enable when developing a real-time capable system
> that will be running in remote locations. With 980000
> I still get negligible latencies. With 970000 I get 4 ms.
> With 960000 I get 15 ms latencies. So it is indeed
> the throttling that is firing here.

Right. So that means that the pata irq or something else loops in
circles for whatever reasons.

For a simple test, can you just set the pata irq thread to SCHED_OTHER
with chrt? Does that cure the problem?

Aside of that I'd really like to see a full function trace of that
scenario. Can you please apply the patch below and run that with the
function tracer enabled. The throttling will stop the trace right at
the point.

Thanks,

	tglx

----------->

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -868,6 +868,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 			static bool once = false;
 
 			rt_rq->rt_throttled = 1;
+			tracing_off();
 
 			if (!once) {
 				once = true;




