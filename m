From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: -rt kernel just can show 8 perf events?
Date: Thu, 4 Feb 2016 16:16:23 +0100
Message-ID: <20160204151623.GB3381@linutronix.de>
References: <565E04D5.4000202@linaro.org>
 <20151211173616.GL6720@linutronix.de>
 <566B0E72.50608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39047 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048AbcBDPQ1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Feb 2016 10:16:27 -0500
Content-Disposition: inline
In-Reply-To: <566B0E72.50608@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Shi, Yang | 2015-12-11 09:57:06 [-0800]:

>On 12/11/2015 9:36 AM, Sebastian Andrzej Siewior wrote:
>>And 4.1.12 (without -rt13) is not having this kind of problem?
>
>No. mainline 4.1.12 works well.

The same thing here. But I get this:

 Performance counter stats for 'tar tJ':

           144,407      cs                                                          
            16,733      page-faults                                                 
            16,732      minor-faults                                                
                 1      major-faults                                                
           805,335      iTLB-load-misses                                              (24.83%)
         6,606,698      dTLB-load-misses                                              (24.63%)
     3,734,425,072      branches                                                      (37.35%)
       228,660,856      L1-dcache-prefetches                                          (37.06%)
         4,564,273      L1-icache-prefetches                                          (49.68%)
       399,365,890      branch-misses             #   10.69% of all branches          (62.63%)
        79,278,129      cache-misses                                                  (62.96%)
    30,825,564,763      cycles                                                        (50.79%)

       8.705696429 seconds time elapsed

once I apply this chunk:

diff --git a/kernel/events/core.c b/kernel/events/core.c
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -802,6 +802,7 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
 	raw_spin_lock_init(&cpuctx->hrtimer_lock);
 	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	timer->function = perf_mux_hrtimer_handler;
+	timer->irqsafe = 1;
 }
 
 static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)

>Yang

Sebastian
