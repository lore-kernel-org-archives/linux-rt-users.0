From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 15:44:01 -0500
Message-ID: <20161107154401.16f0214e@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
        <20161107133207.4282de69@gandalf.local.home>
        <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
        <20161107144738.4811a5dd@gandalf.local.home>
        <alpine.DEB.2.20.1611071353440.19543@east.gentwo.org>
        <20161107150003.66777b43@gandalf.local.home>
        <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me>
        <20161107151617.486b1b42@gandalf.local.home>
        <c46a03ef-89f5-b0c1-5886-e77266dc9a40@bristot.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:36941 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751512AbcKGUoF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Nov 2016 15:44:05 -0500
In-Reply-To: <c46a03ef-89f5-b0c1-5886-e77266dc9a40@bristot.me>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Nov 2016 21:33:02 +0100
Daniel Bristot de Oliveira <daniel@bristot.me> wrote:

> On 11/07/2016 09:16 PM, Steven Rostedt wrote:
> > I'm confused? Are you saying that RR tasks don't get throttled in the
> > current code? That sounds like a bug to me.  
> 
> If the RT_RUNTIME_SHARING is enabled, the CPU in which the RR tasks are
> running (and pinned) will borrow RT runtime from another CPU, allowing
> the RR tasks to run forever. For example:
> 
> [root@kiron debug]# cat /proc/sched_debug | grep rt_runtime
>   .rt_runtime                    : 950.000000
>   .rt_runtime                    : 950.000000
>   .rt_runtime                    : 950.000000
>   .rt_runtime                    : 950.000000
> [root@kiron debug]# echo RT_RUNTIME_SHARE > sched_features
> [root@kiron debug]# taskset -c 2 chrt -r 5 /home/bristot/f &
> [1] 23908
> [root@kiron debug]# taskset -c 2 chrt -r 5 /home/bristot/f &
> [2] 23915
> [root@kiron debug]# cat /proc/sched_debug | grep rt_runtime
>   .rt_runtime                    : 900.000000
>   .rt_runtime                    : 950.000000
>   .rt_runtime                    : 1000.000000
>   .rt_runtime                    : 950.000000
> 
> You see? the rt_runtime of the CPU 2 was borrowed time from CPU 0.
> 
> It is not a BUG but a feature (no jokes haha). With RT_RUNTIME_SHARE,
> the rt_runtime is such a global runtime. It works fine for tasks that
> can migrate... but that is not the case for per-cpu kworkers.

This still looks like a bug, or not the expected result. Perhaps we
shouldn't share when tasks are pinned. It doesn't make sense. It's like
pinning two deadline tasks to the same CPU and giving them 100% of that
CPU and saying that it's really just 1/nr_cpus of usage, which would
have the same effect.

OK, it appears this is specific to RT_RUNTIME_SHARE which is what
causes this strange behavior, and even more rational to make this a
default option and perhaps even turn RT_RUNTIME_SHARE off by default.

-- Steve
