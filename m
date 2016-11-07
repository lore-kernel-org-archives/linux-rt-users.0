From: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 19:03:08 +0100
Message-ID: <470b4cdc-1196-99e4-ee70-6e058e0284e0@sssup.it>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <04fe756b-27f6-b9d0-f0a3-ee66a403cd96@sssup.it>
 <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luca Abeni <luca.abeni@unitn.it>
To: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0893b09f-7412-d6d3-4b8d-ad811af814dd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 07/11/2016 14:51, Daniel Bristot de Oliveira wrote:
> Hi Tommaso,

Hi,

I'm cc-ing Luca for GRUB et al., pls find a few further notes below...

> On 11/07/2016 11:31 AM, Tommaso Cucinotta wrote:
>> as anticipated live to Daniel:
>> -) +1 for the general concept, we'd need something similar also for
>> SCHED_DEADLINE
>
> Resumed: the sum of the runtime of deadline tasks will not be greater
> than the "to_ratio(global_rt_period(), global_rt_runtime())" - see
> init_dl_bw(). Therefore, DL rq will not be throttle by the RT throttling
> mechanism.
>
> Extended: RT tasks' throttling aims to bound, for all CPUS of a domain -
> when RT_RUNTIME_SHARING sharing is enabled; or per-rq - when
> RT_RUNTIME_SHARING is disabled; the amount of time that RT tasks can run
> continuously, in such way to provide some CPU time for non-real-time
> tasks to run. RT tasks need this global/local throttling mechanism to
> avoid the starvation of non-rt tasks because RT tasks do not have a
> limited runtime - RT task (or taskset) can run for an infinity runtime.
>
> DL tasks' throttling has another meaning. DL tasks' throttling aims to
> avoid *a* DL task for running for more than *its own* pre-allocated runtime.

sure, and having an option to let it run for longer, if there's nothing else
running in the system, is still interesting for pretty much similar reasons
to those being discussed in this thread ...

> The sum of allocated runtime for all DL tasks will not to be greater
> than RT throttling enforcement runtime. The DL scheduler admission
> control already avoids this by limiting the amount of CPU time all DL
> tasks can consume (see init_dl_bw()). So, DL tasks are avoid ind the
> "global" throttling on before hand - in the admission control.
>
> GRUB might implement something <<similar>> for the DEADLINE scheduler.
> With GRUB, a deadline tasks will have more runtime than previously
> set/granted.....

yes, the main difference being: GRUB will let a DL task run for longer
than its own runtime, but still let it starve anything below (RT as well
as OTHER tasks); perhaps Luca (cc) has some further comment on this...

Thanks,

	T.

> But I am quite sure it will still be bounded by the sum
> of the already allocated DL runtime, that will continue being smaller
> than "to_ratio(global_rt_period(), global_rt_runtime())".
>
> Am I missing something?
>
>> -) only issue might be that, if a non-RT task wakes up after the
>> unthrottle, it will have to wait, but worst-case it will have a chance
>> in the next throttling window
>
> In the current default behavior (RT_RUNTIME_SHARING), in a domain with
> more than two CPUs, the worst case easily become "infinity," because a
> CPU can borrow runtime from another CPU. There is no guarantee for
> minimum latency for non-rt tasks. Anyway, if the user wants to provide
> such guarantee, they just need not enable this feature, while disabling
> RT_RUNTIME_SHARING (or run the non-rt task as a deadline task ;-))
>
>> -) an alternative to unthrottling might be temporary class downgrade to
>> sched_other, but that might be much more complex, instead this Daniel's
>> one looks quite simple
>
> Yeah, decrease the priority of the task would be something way more
> complicated and prone to errors. RT tasks would need to reduce its
> priority to a level higher than the IDLE task, but lower than SCHED_IDLE...
>
>> -) when considering also DEADLINE tasks, it might be good to think about
>> how we'd like the throttling of DEADLINE and RT tasks to inter-relate,
>> e.g.:
>
> Currently, DL tasks are limited (in the bw control) to the global RT
> throttling limit...
>
> I think that this might be an extension to GRUB... that is extending the
> current behavior... so... things for the future - and IMHO it is another
> topic - way more challenging.
>
> Comments are welcome :-)
>
> -- Daniel
>


-- 
Tommaso Cucinotta, Computer Engineering PhD
Associate Professor at the Real-Time Systems Laboratory (ReTiS)
Scuola Superiore Sant'Anna, Pisa, Italy
http://retis.sssup.it/people/tommaso
