Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:37810 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbeHPX0I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Aug 2018 19:26:08 -0400
Date: Thu, 16 Aug 2018 15:25:26 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: Kernel locks after consecutive writes returning ENOBUFS over can0
Message-ID: <20180816202526.GB23084@jcartwri.amer.corp.natinst.com>
References: <EC76D0B9264AD540A0B82EE057E543D90134BFA4@hbmdax11.3838.1437.ecs.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC76D0B9264AD540A0B82EE057E543D90134BFA4@hbmdax11.3838.1437.ecs.hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "Ermans, Brian (Ext.)" <brian.ermans@hbm.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Tue, Aug 14, 2018 at 12:40:39PM +0000, Ermans, Brian (Ext.) wrote:
> Hello,

Hello Brian-

> We are experiencing issues with RT Linux (4.14.59-rt37) as we have
> found a re-occurring lock in the kernel. This issue has also been
> observed in 4.8.6-rt5.
>
> Our setup consists of an Atom dual-core (/proc/cpuinfo below) running
> open-wrt in combination with a Peak CAN usb dongle.  This CAN dongle
> is interfaced via SocketCAN and written to with high frequency (code
> below). This code runs from a dedicated thread. This thread is the
> only place we access the CAN interface (can0).

Is this Peak CAN USB dongle driver in the kernel tree somewhere?  Or is
it an out-of-tree driver?

> Sometimes, a write to this can0 interface results in a lock. This only
> occurs after a write resulting in ENOBUFS. Our code re-attempts to
> write after a ENOBUFS and the time between the first attempt and the
> second one influences the rate of this lock occurring. If we
> usleep(100) our lock happens very fast (~2seconds), usleep(1000) can
> take up to a minute and we haven't observed the issue with a usleep of
> 3000. Having the usleep as short as possible is critical for our
> application. We have only observed locking of the CAN thread on cpu1.

That's concerning.

> This lock results in the core being fully used by the CAN thread and
> the systems becoming unresponsive. Sometimes this is detected by the
> kernel, after which a call stack is produced (two callstacks below).

Just to check: you're not seeing this CAN thread return back to
usermode, correct?  It remains "stuck" spinning in the write() in kernel
context?

> Please be aware that, due to application limitations, we have our
> txqueuelen configured as 1. This results in relative frequent ENOBUFS.
>
> Changing thread priority or application priority does not change
> behavior.

Is this true even if ksoftirqd/1 is prioritized over the CAN thread?

> CAN related settings changes like bitrate, CAN2.0 or
> CAN-FD, frame size, cable length or busload also do not improve the
> situation.

> We have made traces (using trace-cmd record -e 'sched_wakeup*' -e
> sched_switch -e 'sched_migrate*' ) during the lock-up and it seems as
> if a ksoftirqd is sched_wakeup, but never actually switched to right
> before the lock occurs:

This is what I would expect if your CAN thread is spinning at an RT
priority greater that ksoftirqd/1.  It's not clear from your traces what
priority/class your CAN thread is executing as.

>              CAN-2434  [001]   116.127166: sched_wakeup:         ksoftirqd/1:21 [120] success=1 CPU:001
>        RtFdbDisp-2133  [000]   116.127175: sched_switch:         RtFdbDisp:2133 [120] S ==> CFpgaEventColle:2103 [120]
>  CFpgaEventColle-2103  [000]   116.127179: sched_wakeup:         ScmIfm:2112 [22] success=1 CPU:000
>  CFpgaEventColle-2103  [000]   116.127182: sched_switch:         CFpgaEventColle:2103 [120] R ==> ScmIfm:2112 [22]
>           ScmIfm-2112  [000]   116.127190: sched_switch:         ScmIfm:2112 [22] S ==> CFpgaEventColle:2103 [120]
>  CFpgaEventColle-2103  [000]   116.127195: sched_wakeup:         ScmIfm:2112 [22] success=1 CPU:000
>  CFpgaEventColle-2103  [000]   116.127198: sched_switch:         CFpgaEventColle:2103 [120] R ==> ScmIfm:2112 [22]
>           ScmIfm-2112  [000]   116.127207: sched_wakeup:         MsgHndr4:2111 [25] success=1 CPU:000
>           ScmIfm-2112  [000]   116.127214: sched_switch:         ScmIfm:2112 [22] S ==> MsgHndr4:2111 [25]
>         MsgHndr4-2111  [000]   116.127224: sched_wakeup:         RtFdbDisp:2133 [120] success=1 CPU:000
>         MsgHndr4-2111  [000]   116.127245: sched_switch:         MsgHndr4:2111 [25] S ==> RtFdbDisp:2133 [120]
>        RtFdbDisp-2133  [000]   116.127255: sched_switch:         RtFdbDisp:2133 [120] S ==> CFpgaEventColle:2103 [120]
>  CFpgaEventColle-2103  [000]   116.127263: sched_switch:         CFpgaEventColle:2103 [120] S ==> trace-cmd:2432 [120]
>        trace-cmd-2432  [000]   116.127331: sched_switch:         trace-cmd:2432 [120] S ==> swapper/0:0 [120]
>              CAN-2434  [001]   116.127604: sched_wakeup:         ktimersoftd/1:20 [98] success=1 CPU:001
>              <idle>-0  [000]   116.128849: sched_wakeup:         ktimersoftd/0:8 [98] success=1 CPU:000
>              <idle>-0  [000]   116.128863: sched_switch:         swapper/0:0 [120] R ==> ktimersoftd/0:8 [98]
>       ktimersoftd/0-8  [000]   116.128897: sched_switch:         ktimersoftd/0:8 [98] S ==> swapper/0:0 [120]
>              <idle>-0  [000]   116.130147: sched_wakeup:         ktimersoftd/0:8 [98] success=1 CPU:000
>              <idle>-0  [000]   116.130157: sched_switch:         swapper/0:0 [120] R ==> ktimersoftd/0:8 [98]
>       ktimersoftd/0-8  [000]   116.130180: sched_wakeup:         Net_RJ45:2150 [120] success=1 CPU:000
> 
> and so on. From this point on our CAN thread "locks". It does however
> perform some scheduling. The lines below are the only occurrences
> within this particular trace where "CAN-2434" is mentioned after the
> lock(note the difference in timestamps).
> 
>        CAN-2434  [001]   116.127604: sched_wakeup:              ktimersoftd/1:20 [98] success=1 CPU:001
>        CAN-2434  [001]   116.145468: sched_migrate_task:        comm=tQLive pid=2148 prio=23 orig_cpu=1 dest_cpu=0
>        CAN-2434  [001]   116.145472: sched_wakeup:              tQLive:2148 [23] success=1 CPU:000
>        CAN-2434  [001]   116.186470: sched_migrate_task:        comm=tQCmd pid=2147 prio=23 orig_cpu=1 dest_cpu=0
>        CAN-2434  [001]   116.186475: sched_wakeup:              tQCmd:2147 [23] success=1 CPU:000
>        CAN-2434  [001]   116.228357: sched_migrate_task:        comm=SockSend pid=2347 prio=33 orig_cpu=1 dest_cpu=0
>        CAN-2434  [001]   116.418810: sched_wakeup:              rcuc/1:19 [120] success=1 CPU:001

If the CAN thread is stuck spinning on CPU1 and we wakeup an unpinned,
lower priority RT task on CPU1 (making this CPU "overloaded"), the
scheduler will push tasks around in the wakeup path, like we're seeing
here.  In other words, nothing about this seems overtly wrong, just a
symptom of the CAN thread spinning at a high priority.

> The next mention of ksoftirqd in this particular trace is here, way later, in a new sched_wakeup. Here the sched_switch is actually made:
> 
>         <idle>-0 [000]   116.168849: sched_wakeup:         ksoftirqd/0:7 [120] success=1 CPU:000
>         <idle>-0 [000]   116.168858: sched_wakeup:         ktimersoftd/0:8 [98] success=1 CPU:000
>         <idle>-0 [000]   116.168869: sched_switch:         swapper/0:0 [120] R ==> ktimersoftd/0:8 [98]
>  ktimersoftd/0-8 [000]   116.168895: sched_switch:         ktimersoftd/0:8 [98] S ==> ksoftirqd/0:7 [120]
>    ksoftirqd/0-7 [000]   116.168905: sched_switch:         ksoftirqd/0:7 [120] S ==> swapper/0:0 [120]

This is all on CPU0, though; CPU1 is probably still spinning away. :\

> I can send this full trace and others with this same issue on request.

Having a complete trace is probably going to be more helpful.  It might
be helpful also to also trace more than just the 'sched' class of trace
events.  Namely, also include the 'irq' family of events, 'timer' and
'net' would probably be helpful as well, given the issue you're seeing
appears to be in the packet tx stack (more below).

> Sometimes this lock is detected by the kernel, resulting in a call
> trace. Oddly enough this trace is not always the same. You can find
> the two different call traces observed below, together with uname -a,
> and /proc/cpuinfo.
>
> I have contacted PEAK, who maintain the drivers for the CAN Dongle.
> They are not familiar with the issue and pointed me to this mailing
> list as they suspect issues in the networking core of the rt patch in
> particular.
>
> Thank you in advance for any insight into this issue or help to
> prevent it in general.
>
[..]
> [  242.819436] INFO: rcu_preempt self-detected stall on CPU

[..] cut useless rcu_preempt callstack; it's sleeping.

> [  242.819527] Task dump for CPU 1:
> [  242.819531] CAN             R running      0  2564   2001 0x00000000
> [  242.819536]  c451ef00 c451ef00 f53b3b88 c106f6e3 c17cda94 00000000 00000a04 000007d1
> [  242.819541]  00000000 00000001 00000083 f53b3b9c c1071436 c17cdad5 00000001 c18a7380
> [  242.819546]  f53b3bb4 c1101b0b c18a7380 c18a7380 c18a7380 f689a680 f53b3c08 c109768e
> [  242.819546] Call Trace:
> [  242.819550]  [<c106f6e3>] sched_show_task+0xc3/0x140
> [  242.819554]  [<c1071436>] dump_cpu_task+0x36/0x40
> [  242.819558]  [<c1101b0b>] rcu_dump_cpu_stacks+0x6a/0x97
> [  242.819561]  [<c109768e>] rcu_check_callbacks+0x86e/0x8d0
> [  242.819566]  [<c104e4d0>] ? raise_softirq_irqoff+0x10/0x40
> [  242.819569]  [<c104e4d0>] ? raise_softirq_irqoff+0x10/0x40
> [  242.819573]  [<c109b12d>] update_process_times+0x2d/0x50
> [  242.819576]  [<c10abb88>] tick_sched_timer+0x48/0x340
> [  242.819581]  [<c12eb7ab>] ? timerqueue_del+0x1b/0x60
> [  242.819584]  [<c10abb40>] ? tick_init_highres+0x20/0x20
> [  242.819587]  [<c109c1dc>] __hrtimer_run_queues+0xfc/0x3b0
> [  242.819590]  [<c10abb40>] ? tick_init_highres+0x20/0x20
> [  242.819593]  [<c109c8e4>] hrtimer_interrupt+0x94/0x230
> [  242.819596]  [<c109c92d>] ? hrtimer_interrupt+0xdd/0x230
> [  242.819600]  [<c103169f>] local_apic_timer_interrupt+0x2f/0x60
> [  242.819603]  [<c16abf83>] smp_apic_timer_interrupt+0x33/0x50
> [  242.819606]  [<c16ab806>] apic_timer_interrupt+0x32/0x38

^ all sched_tick related

> [  242.819609]  [<c106a80e>] ? migrate_disable+0x1e/0xb0
> [  242.819612]  [<c16aa8f0>] rt_spin_lock+0x10/0x40
> [  242.819616]  [<c1599d2f>] sch_direct_xmit+0x5f/0x170
> [  242.819619]  [<c1599f4b>] __qdisc_run+0x10b/0x280
> [  242.819624]  [<c15771fa>] net_tx_action+0x10a/0x230
> [  242.819627]  [<c106007b>] ? alloc_unbound_pwq+0x14b/0x2c0
> [  242.819631]  [<c104e0ce>] do_current_softirqs+0x15e/0x300
> [  242.819635]  [<c104e2d7>] __local_bh_enable+0x67/0x80
> [  242.819638]  [<c157a63d>] __dev_queue_xmit+0x1dd/0x520
> [  242.819642]  [<c157a98f>] dev_queue_xmit+0xf/0x20
> [  242.819646]  [<f81b8390>] _15+0xc0/0x1d0 [can]
> [  242.819649]  [<f83013ba>] 0xf83013ba
> [  242.819654]  [<c155e25d>] sock_sendmsg+0x2d/0x40
> [  242.819657]  [<c155e2dc>] sock_write_iter+0x6c/0xc0
> [  242.819662]  [<c114a4d0>] __vfs_write+0xc0/0x120
> [  242.819666]  [<c114acfb>] vfs_write+0x9b/0x1a0
> [  242.819670]  [<c1166632>] ? __fget_light+0x22/0x60
> [  242.819673]  [<c114bbce>] SyS_write+0x3e/0x90
> [  242.819677]  [<c100150f>] do_int80_syscall_32+0x5f/0xb0
> [  242.819681]  [<c16aae27>] entry_INT80_32+0x2f/0x2f

Okay, so, if our working theory is that the CAN thread is stuck spinning
in the kernel, then this gives some ideas as to where we might be
spinning.  Further tracing might help; I'm wondering if it's
__qdisc_run()...

> [ 1489.289606] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1489.289611]   Tasks blocked on level-0 rcu_node (CPUs 0-1): P898
> [ 1489.289614]   (detected by 1, t=6002 jiffies, g=3428, c=3427, q=3586)
> [ 1489.289619] irq/94-xhci_hcd R running      0   898      2 0x00000000
> [ 1489.289627]  f5049d74 f5049d78 f50bf800 f5049db0 000011de 00000000 be240407 0000014c
> [ 1489.289632]  f5a1e5c0 f5852a00 f504a000 f50bf800 f5852a00 f5049d80 c16a82ee 00000000
> [ 1489.289637]  f5049e08 c16aad77 00000000 8cd06961 c44c2540 f50bf800 f5852a00 f5049e08
> [ 1489.289637] Call Trace:
> [ 1489.289649]  [<c16a82ee>] preempt_schedule_irq+0x3e/0x70
> [ 1489.289653]  [<c16aad77>] test_int_off+0x13/0x15
> [ 1489.289658]  [<c1573228>] ? get_rps_cpu+0x68/0x2c0
> [ 1489.289662]  [<c1564a5c>] ? kfree_skbmem+0x5c/0x60
> [ 1489.289664]  [<c1564a5c>] ? kfree_skbmem+0x5c/0x60
> [ 1489.289666]  [<c1564a5c>] ? kfree_skbmem+0x5c/0x60
> [ 1489.289669]  [<c1564a5c>] ? kfree_skbmem+0x5c/0x60
> [ 1489.289672]  [<c15670f2>] ? consume_skb+0x32/0xb0

^ irq/94-xhci_hcd was running, but got preempted.

> [ 1489.289676]  [<c15776e1>] netif_rx_internal+0x91/0x140
> [ 1489.289679]  [<c15777cc>] netif_rx+0x1c/0x90

...it was in the process of handing a packet to the network stack.  Not
sure how relevant this is just yet.  It'd be interesting to see the
stack of the CAN thread when this happens.  Maybe the CAN thread is
spinwaiting for this thread to satisfy some condition...

> [ 1489.289684]  [<f8302187>] _27+0x37/0x50 [can_dev]
> [ 1489.289688]  [<f831831b>] 0xf831831b
> [ 1489.289692]  [<c1461be7>] ? usb_unanchor_urb+0x37/0x40
> [ 1489.289695]  [<c145f097>] __usb_hcd_giveback_urb+0x57/0xd0
> [ 1489.289698]  [<c145f1f6>] usb_hcd_giveback_urb+0x36/0x100
> [ 1489.289702]  [<c148fe7f>] xhci_irq+0x7cf/0x13d0
> [ 1489.289705]  [<c16aa70b>] ? _raw_spin_unlock_irq+0x1b/0x60
> [ 1489.289710]  [<c10693b2>] ? finish_task_switch+0x72/0x1b0
> [ 1489.289714]  [<c1490a8f>] xhci_msi_irq+0xf/0x20
> [ 1489.289717]  [<c108bd2d>] irq_forced_thread_fn+0x1d/0x50
> [ 1489.289720]  [<c108c1f6>] irq_thread+0xd6/0x170
> [ 1489.289723]  [<c16a7ca9>] ? schedule+0x49/0xc0
> [ 1489.289726]  [<c108bd10>] ? irq_thread_fn+0x30/0x30
> [ 1489.289728]  [<c108bda0>] ? wake_threads_waitq+0x40/0x40
> [ 1489.289731]  [<c108c120>] ? irq_thread_check_affinity+0x70/0x70
> [ 1489.289735]  [<c1063c61>] kthread+0xa1/0xc0
> [ 1489.289739]  [<c16aace2>] ret_from_kernel_thread+0xe/0x24
> [ 1489.289742]  [<c1063bc0>] ? kthread_worker_fn+0xf0/0xf0

Not sure this helps much, but I'm happy to continue helping.

   Julia
