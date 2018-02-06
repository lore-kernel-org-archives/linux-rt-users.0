From: Julia Cartwright <julia@ni.com>
Subject: Re: nonrt behavior with GPIO interrupts
Date: Tue, 6 Feb 2018 10:22:50 -0600
Message-ID: <20180206162250.GA870@jcartwri.amer.corp.natinst.com>
References: <CANGgnMaxk=82VH1PLUmGKCzfhp=kvwokQ8Qy3SzLxO8hn8pQ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:37906 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752171AbeBFQWx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 11:22:53 -0500
Content-Disposition: inline
In-Reply-To: <CANGgnMaxk=82VH1PLUmGKCzfhp=kvwokQ8Qy3SzLxO8hn8pQ8A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Austin-

On Mon, Feb 05, 2018 at 04:24:57PM -0800, Austin Schuh wrote:
> We are seeing nonrt behavior with GPIO interrupts using the sysfs
> interface.  We setup the pin by setting the ".../edge" file to
> "rising", and then use epoll to wait for a priority event on the
> ".../value" file.

What does "nonrt" behavior look like to you?

Unfortunately, the kernels poll()/select()/epoll() code is completely
dependent on the workqueue infrastructure, which isn't designed with RT
in mind.  (See the documentation in include/linux/swait.h to understand
why that's the case).  This is Problem 1.

> From turning on the IRQ trace events, the workqueue trace events, and
> the scheduler trace events, it looks like the sysfs event goes through
> a workqueue, which is SCHED_OTHER.

Thanks for sharing the trace, next time if you could please not wrap the
trace, that'd be most helpful.

Unwrapped, with my annotations below:

>           <idle>-0     [000] d..h2..  9739.478875: irq_handler_entry: irq=103 name=48057000.gpio
>           <idle>-0     [000] d..h2..  9739.478877: irq_handler_exit: irq=103 ret=handled
>           <idle>-0     [000] d..h3..  9739.478879: sched_waking: comm=irq/103-4805700 pid=105 prio=26 target_cpu=000
>           <idle>-0     [000] dn.h4..  9739.478884: sched_wakeup: comm=irq/103-4805700 pid=105 prio=26 target_cpu=000
>           <idle>-0     [000] d...3..  9739.478892: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=irq/103-4805700 next_pid=105 next_prio=26
>  irq/103-4805700-105   [000] d...211  9739.478904: irq_handler_entry: irq=135 name=gpiolib
>  irq/103-4805700-105   [000] d...211  9739.478906: irq_handler_exit: irq=135 ret=handled
>  irq/103-4805700-105   [000] d...311  9739.478909: sched_waking: comm=irq/135-gpiolib pid=3380 prio=26 target_cpu=001
>  irq/103-4805700-105   [000] d...411  9739.478914: sched_wakeup: comm=irq/135-gpiolib pid=3380 prio=26 target_cpu=001
>           <idle>-0     [001] d...3..  9739.478919: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=irq/135-gpiolib next_pid=3380 next_prio=26

You haven't mentioned which GPIO driver you are working with, but I
don't think it matters.  Here the irq subsystem is jumping through two
threads, presumably because your controller implements an irq_chip, so
there is some chained handling handling going on.

Problem 2 is that there is no PI chain between the consuming thread(s)
(gps_main in your case) and the servicing irqthread(s).  Static
prioritization of irqthreads is the current guidance, which is a useful
enough proxy for most simple RT applications.

>  irq/135-gpiolib-3380  [001] ....115  9739.478928: workqueue_queue_work: work struct=c0a6c944 function=kernfs_notify_workfn workqueue=ef0c1300 req_cpu=2 cpu=1
>  irq/135-gpiolib-3380  [001] ....115  9739.478930: workqueue_activate_work: work struct c0a6c944

Problem 3 is that workqueues similarly don't participate in PI.  There
is currently no clean way to prioritize work items, as they run from a
set of mostly arbitrary worker threads.

>  irq/135-gpiolib-3380  [001] d...315  9739.478932: sched_waking: comm=kworker/1:1 pid=3168 prio=120 target_cpu=001
>  irq/103-4805700-105   [000] d...3..  9739.478934: sched_switch: prev_comm=irq/103-4805700 prev_pid=105 prev_prio=26 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
>  irq/135-gpiolib-3380  [001] d...415  9739.478937: sched_wakeup: comm=kworker/1:1 pid=3168 prio=120 target_cpu=001
>  irq/135-gpiolib-3380  [001] d...3..  9739.478951: sched_switch: prev_comm=irq/135-gpiolib prev_pid=3380 prev_prio=26 prev_state=S ==> next_comm=kworker/1:1 next_pid=3168 next_prio=120
>      kworker/1:1-3168  [001] ....1..  9739.478957: workqueue_execute_start: work struct c0a6c944: function kernfs_notify_workfn
>      kworker/1:1-3168  [001] d...213  9739.478962: sched_waking: comm=gps_main pid=3374 prio=26 target_cpu=001
>      kworker/1:1-3168  [001] dn..313  9739.478967: sched_wakeup: comm=gps_main pid=3374 prio=26 target_cpu=001
>      kworker/1:1-3168  [001] dn..313  9739.478970: sched_stat_runtime: comm=kworker/1:1 pid=3168 runtime=17731 [ns] vruntime=138492205643 [ns]
>
>      kworker/1:1-3168  [001] d...313  9739.478974: sched_switch: prev_comm=kworker/1:1 prev_pid=3168 prev_prio=120 prev_state=R+ ==> next_comm=gps_main next_pid=3374 next_prio=26
>         gps_main-3374  [001] d...411  9739.478983: sched_pi_setprio: comm=kworker/1:1 pid=3168 oldprio=120 newprio=26
>         gps_main-3374  [001] d...311  9739.478994: sched_switch: prev_comm=gps_main prev_pid=3374 prev_prio=26 prev_state=D ==> next_comm=kworker/1:1 next_pid=3168 next_prio=26

And... a lock bounce, the waitqueue lock, probably.  Good times.  See my
above comments about waitqueues, this is an additional manifestation of
Problem 1.

>      kworker/1:1-3168  [001] d...313  9739.479000: sched_waking: comm=gps_main pid=3374 prio=26 target_cpu=001
>      kworker/1:1-3168  [001] d...413  9739.479003: sched_wakeup: comm=gps_main pid=3374 prio=26 target_cpu=001
>      kworker/1:1-3168  [001] d...313  9739.479006: sched_pi_setprio: comm=kworker/1:1 pid=3168 oldprio=26 newprio=120
>      kworker/1:1-3168  [001] d...313  9739.479010: sched_stat_runtime: comm=kworker/1:1 pid=3168 runtime=1952 [ns] vruntime=138492207595 [ns]
>      kworker/1:1-3168  [001] dn..313  9739.479015: sched_stat_runtime: comm=kworker/1:1 pid=3168 runtime=4555 [ns] vruntime=138492212150 [ns]
>      kworker/1:1-3168  [001] d...313  9739.479018: sched_switch: prev_comm=kworker/1:1 prev_pid=3168 prev_prio=120 prev_state=R+ ==> next_comm=gps_main next_pid=3374 next_prio=26
>         gps_main-3374  [001] ....1..  9739.479032: sys_epoll_wait -> 0x1
>         gps_main-3374  [001] ....1..  9739.479033: sys_exit: NR 252 = 1

> For our use case, we were able to switch to the PPS driver, but I
> thought it worthwhile to raise this in case anyone else runs across
> it.  Is this a known issue?

For folks who've had there hands in RT for awhile, they are known
issues.  They are lesser known issues to new users, however.

Fixing these problems is a long and complicated road, requiring either
constructing a new abstraction (see swait for example), or augmenting
existing abstractions to make them RT friendly.

   Julia
