From: Remy Bohmer <linux@bohmer.net>
Subject: Re: System lockup with 2.6.26.8-rt16 on ARM9 [Solved]
Date: Sat, 29 Aug 2009 09:47:17 +0200
Message-ID: <3efb10970908290047k6f4d5a14of148db7f2b179f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751913AbZH2Hwx@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,

> We are running into a bug on a ARM926 processor with 2.6.26.8-rt16
> where the system stops scheduling any thread while the hard-irq
> handlers keep on running (and waking up tasks with wake_up_process())
> What happens is that the system is idle and is continuously polling o=
n
> need_resched() in the cpu_idle() routine (arch/arm/kernel/process.c)
> But, need_resched() keeps on returning false, so the system stays in
> the idle loop and __schedule is never called.
>
> While debugging this we noticed/tried several things already:
> * default_idle() wakes up properly when an interrupt occurs.
> * Interrupt handling keeps on running, but no interrupt threads are
> scheduled either.
> * Triggering a different interrupt source sometimes get the system ou=
t
> of the lockup condition.
> * removing the loop with need_resched() to force the system to call
> __schedule() after waking up from default_idle() has no effect, the
> scheduler does not schedule any threads that are clearly runnable. Se=
e
> logging below.
> * preempt_schedule_irq() is not called after an irq during the lockup=
=2E
> Probably it is because the check on preempt_count!=3D0 in __irq_svc (=
in
> arch/arm/kernel/entry-armv.S).
> * We have excluded any relation with any user application by adding
> root_delay=3D<1-month-in-seconds> to the kernel commandline.
> * We stripped down the kernel as much as possible, excluding almost
> all drivers, including removing the networking layer. (but with
> networking and a ping flood it seems easier to reproduce)
> * Problem exists with NO_HZ, HRT as well as without it.
>
> We call 'print_cpu()' when a lockup occurs. We call it directly from =
a
> hard-irq handler.
> (canary_check is a kernel thread that is part of our debugging code.
> It is a thread that is directly scheduled via wake_up_process() from
> the system timer irq. We check from the hard-irq handler if this
> thread is being scheduled, if not the system is locked up and we dump
> this logging)
>
> [ 8931.475755]
> [ 8931.475769] cpu#0
> [ 8931.479186] =A0 .nr_running =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
: 3
> [ 8931.483809] =A0 .load =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0: 532566
> [ 8931.488862] =A0 .nr_switches =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 37438443
> [ 8931.494089] =A0 .nr_load_updates =A0 =A0 =A0 =A0 =A0 =A0 =A0 : 860=
943
> [ 8931.499142] =A0 .nr_uninterruptible =A0 =A0 =A0 =A0 =A0 =A0: 1
> [ 8931.503761] =A0 .jiffies =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 : 830943
> [ 8931.508816] =A0 .next_balance =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
 0.000000
> [ 8931.514043] =A0 .curr->pid =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 : 0
> [ 8931.518664] =A0 .clock =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 : 8931475.737362
> [ 8931.524411] =A0 .cpu_load[0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 532566
> [ 8931.529464] =A0 .cpu_load[1] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 532420
> [ 8931.534516] =A0 .cpu_load[2] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 516298
> [ 8931.539569] =A0 .cpu_load[3] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 433653
> [ 8931.544621] =A0 .cpu_load[4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=
 310689
> [ 8931.549674] =A0 .rt.rt_nr_running =A0 =A0 =A0 =A0 =A0 =A0 =A0: 3
> [ 8931.554293] =A0 .rt.rt_nr_uninterruptible =A0 =A0 =A0: 4294967293
> [ 8931.559694]
> [ 8931.559703] cfs_rq[0]:
> [ 8931.563548] =A0 .exec_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
: 0.000000
> [ 8931.568778] =A0 .MIN_vruntime =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
 0.000001
> [ 8931.574007] =A0 .min_vruntime =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
 1254.953603
> [ 8931.579496] =A0 .max_vruntime =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
 0.000001
> [ 8931.584724] =A0 .spread =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0: 0.000000
> [ 8931.589952] =A0 .spread0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 : 0.000000
> [ 8931.595178] =A0 .nr_running =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
: 0
> [ 8931.599796] =A0 .load =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0: 0
> [ 8931.604414] =A0 .nr_spread_over =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: 0
> [ 8931.609048]
> [ 8931.609056] runnable tasks:
> [ 8931.609067] =A0 =A0 =A0 =A0 =A0 =A0 task =A0 PID =A0 =A0 =A0 =A0 t=
ree-key =A0switches =A0prio
> =A0 =A0exec-runtime =A0 =A0 =A0 =A0 sum-exec =A0 =A0 =A0 =A0sum-sleep
> [ 8931.609094] ------------------------------------------------------=
----------------------------------------------------
> [ 8931.634702] =A0 =A0 sirq-timer/0 =A0 =A0 5 =A0 =A0 =A0 =A0 6.65243=
8 =A0 1003780 =A0 =A059
> =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0.000000
> 0.000000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.000000
> [ 8931.649795] =A0 =A0 canary_check =A0 =A033 =A0 =A0 =A0 =A078.14166=
9 =A0 =A0860433 =A0 =A0 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0.000000
> 0.000000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.000000
> [ 8931.664887] =A0 =A0 =A0 =A0 =A0 IRQ-57 =A0 243 =A0 =A0 =A0 832.211=
283 =A013874273 =A0 =A059
> =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0.000000
> 0.000000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.000000
> [ 8931.764591]
>

Well, we found the root cause of this problem.
It turned out to be caused by sched_clock() that made disjunct time jum=
ps.
This caused this check to become true in kernel/sched_rt.c:370:
         if (rt_rq->rt_time > runtime) {
                rt_rq->rt_throttled =3D 1;
                if (rt_rq_throttled(rt_rq)) {
                        sched_rt_rq_dequeue(rt_rq);
                        return 1;
                }
        }

The end results is that all realtime tasks got throttled for a long
time, and that time got extended every time sched_clock() made such a
jump. I would never have expected the scheduler would show this kind
of behaviour while CONFIG_RT_GROUP_SCHED is _not_ set...

The root-cause of the sched_clock being faulty was a synchronisation
issue between 2 clock domains. The CPU clock and the clock domain of
the peripheral (GPT) on which the sched_clock() implementation was
based. The GPT made jumps backwards which triggered a false wraparound
detection in the conversion of 32->64 bit timestamps, causing the time
to jump about 356 seconds in the future...

Thinking about this, we would have found it much earlier if
print_cpu() would have printed the 'throttled' state of a task as
well.
Besides that, it would have helped a lot if the scheduler would print
a message if such time jumps happen...

If there is interest I can provide a patch for that.


Kind regards,

Remy
