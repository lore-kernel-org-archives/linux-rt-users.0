From: luca abeni <lucabe72@gmail.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 08:55:26 +0100
Message-ID: <20161108085526.017d006e@utopia>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <04fe756b-27f6-b9d0-f0a3-ee66a403cd96@sssup.it>
        <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

since GRUB reclaiming has been mentioned, I am going to add some
comments on it :)

On Mon, 7 Nov 2016 14:51:37 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

[...]
> The sum of allocated runtime for all DL tasks will not to be greater
> than RT throttling enforcement runtime. The DL scheduler admission
> control already avoids this by limiting the amount of CPU time all DL
> tasks can consume (see init_dl_bw()). So, DL tasks are avoid ind the
> "global" throttling on before hand - in the admission control.
> 
> GRUB might implement something <<similar>> for the DEADLINE scheduler.
> With GRUB, a deadline tasks will have more runtime than previously
> set/granted..... But I am quite sure it will still be bounded by the
> sum of the already allocated DL runtime, that will continue being
> smaller than "to_ratio(global_rt_period(), global_rt_runtime())".

Well, it's not exactly like this... In the original GRUB algorithm[1]
(that was uni-processor only), the tasks were able to reclaim 100% of
the CPU time (in other words: with the original GRUB algorithm,
SCHED_DEADLINE tasks can starve all of the non-deadline tasks).

But in the patchset I submitted I modified the algorithm to reclaim
only a specified fraction of the CPU time[2] (so that some CPU time is
left for non-deadline tasks). See patch 5/6 in my latest submission
(v3). I set the percentage of reclaimable CPU time equal to
"to_ratio(global_rt_period(), global_rt_runtime())" (so, deadline tasks
can be able to consume up to this fraction), but this can be changed if
needed.

Finally, notice that if we are interested in hard schedulability (hard
respect of all the deadlines - this is not something that
SCHED_DEADLINE currently does) then the reclaiming algorithm must be
modified and can reclaim a smaller amount of CPU time (see [3,4] for
details)


			Luca

[1] Lipari, G., & Baruah, S. (2000). Greedy reclamation of unused
bandwidth in constant-bandwidth servers. In Real-Time Systems, 2000.
Euromicro RTS 2000. 12th Euromicro Conference on (pp. 193-200). IEEE.
[2] Abeni, L., Lelli, J., Scordino, C., & Palopoli, L. (2014, October).
Greedy CPU reclaiming for SCHED DEADLINE. In Proceedings of the
Real-Time Linux Workshop (RTLWS), Dusseldorf, Germany. 
[3] Abeni, L., Lipari, G., Parri, A., & Sun, Y. (2016, April).
Multicore CPU reclaiming: parallel or sequential?. In Proceedings of
the 31st Annual ACM Symposium on Applied Computing (pp. 1877-1884). ACM.
[4] https://arxiv.org/abs/1512.01984



> 
> Am I missing something?
> 
> > -) only issue might be that, if a non-RT task wakes up after the
> > unthrottle, it will have to wait, but worst-case it will have a
> > chance in the next throttling window  
> 
> In the current default behavior (RT_RUNTIME_SHARING), in a domain with
> more than two CPUs, the worst case easily become "infinity," because a
> CPU can borrow runtime from another CPU. There is no guarantee for
> minimum latency for non-rt tasks. Anyway, if the user wants to provide
> such guarantee, they just need not enable this feature, while
> disabling RT_RUNTIME_SHARING (or run the non-rt task as a deadline
> task ;-))
> 
> > -) an alternative to unthrottling might be temporary class
> > downgrade to sched_other, but that might be much more complex,
> > instead this Daniel's one looks quite simple  
> 
> Yeah, decrease the priority of the task would be something way more
> complicated and prone to errors. RT tasks would need to reduce its
> priority to a level higher than the IDLE task, but lower than
> SCHED_IDLE...
> 
> > -) when considering also DEADLINE tasks, it might be good to think
> > about how we'd like the throttling of DEADLINE and RT tasks to
> > inter-relate, e.g.:  
> 
> Currently, DL tasks are limited (in the bw control) to the global RT
> throttling limit...
> 
> I think that this might be an extension to GRUB... that is extending
> the current behavior... so... things for the future - and IMHO it is
> another topic - way more challenging.
> 
> Comments are welcome :-)
> 
> -- Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
