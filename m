From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 10:30:52 +0000
Message-ID: <20161108103052.GE16920@e106622-lin>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <04fe756b-27f6-b9d0-f0a3-ee66a403cd96@sssup.it>
 <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932223AbcKHKae (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 05:30:34 -0500
Content-Disposition: inline
In-Reply-To: <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Daniel,

On 07/11/16 14:51, Daniel Bristot de Oliveira wrote:
> On 11/07/2016 11:31 AM, Tommaso Cucinotta wrote:

[...]

> > -) only issue might be that, if a non-RT task wakes up after the
> > unthrottle, it will have to wait, but worst-case it will have a chance
> > in the next throttling window
> 
> In the current default behavior (RT_RUNTIME_SHARING), in a domain with
> more than two CPUs, the worst case easily become "infinity," because a
> CPU can borrow runtime from another CPU. There is no guarantee for
> minimum latency for non-rt tasks. Anyway, if the user wants to provide
> such guarantee, they just need not enable this feature, while disabling
> RT_RUNTIME_SHARING (or run the non-rt task as a deadline task ;-))
> 

I could only skim through the patch, so please forgive me if I'm talking
gibberish, but I think what Tommaso is saying is that with your current
approach if an unlucky OTHER task wakes up just after you unthrottled an
rt_rq (by replenishment), it will have to wait until the next throttling
event. I agree that this is still better than current status, and that
you can still configure the system to avoid this from happening. What
I'm wondering though is if we could modify your implementation and only
do the replenishment when the replenishment timer actually fires, but
let RT tasks continue to run, while their rt_rq is throttled, if no
OTHER task is present, or wakes up. I guess this will complicate things,
and maybe doesn't buy us much, just an idea. :)

Otherwise, the patch looks good and useful to me.

Best,

- Juri
