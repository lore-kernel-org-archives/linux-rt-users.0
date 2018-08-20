Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx-relay14-hz2.antispameurope.com ([83.246.65.156]:45648 "EHLO
        mx-relay14-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeHTRJx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 13:09:53 -0400
From: "Ermans, Brian (Ext.)" <brian.ermans@hbm.com>
Subject: RE: Kernel locks after consecutive writes returning ENOBUFS over
 can0
Date: Mon, 20 Aug 2018 13:46:59 +0000
Message-ID: <EC76D0B9264AD540A0B82EE057E543D90134CC5F@hbmdax11.3838.1437.ecs.hp.com>
References: <EC76D0B9264AD540A0B82EE057E543D90134BFA4@hbmdax11.3838.1437.ecs.hp.com>
 <20180816202526.GB23084@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20180816202526.GB23084@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Hello Julia,

Thank you for your reply.

> > Changing thread priority or application priority does not change
> > behavior.
>
> Is this true even if ksoftirqd/1 is prioritized over the CAN thread?

It took us some time, but good call, this actually seems to fix the issue.

When we force ksoftirqd to FIFO and the CAN thread to NORMAL it does not lock! (or at least, not within a reasonable time frame, will do some long-term testing tonight)
We will have to do extensive testing to verify this is a valid work-around for us. We don't know if changing these priorities have unforeseen side-effects at this point, but for now it seems to be good.

root@OpenWrt:~# ps | grep ksoftirq
    3 root         0 SW   [ksoftirqd/0]
   19 root         0 SW   [ksoftirqd/1]
 2615 root      3040 S    grep ksoftirq
root@OpenWrt:~# chrt -f -p 98 3
pid 3's current scheduling policy: SCHED_OTHER
pid 3's current scheduling priority: 0
pid 3's new scheduling policy: SCHED_FIFO
pid 3's new scheduling priority: 98
root@OpenWrt:~# chrt -f -p 98 19
pid 19's current scheduling policy: SCHED_OTHER
pid 19's current scheduling priority: 0
pid 19's new scheduling policy: SCHED_FIFO
pid 19's new scheduling priority: 98


Another thing I mentioned to you in our private conversation, that probably is interesting for anyone reading along:
We have confirmed this issue does not occur when using a mPCIe device from Peak. User space code is the same as we still write to can0.
I failed to mention this before as we didn't test this yet at the time I wrote the original mail.

Please let me know if you need more information.

Thank you,

Brian

> > We are experiencing issues with RT Linux (4.14.59-rt37) as we have
> > found a re-occurring lock in the kernel. This issue has also been
> > observed in 4.8.6-rt5.
> >
> > Our setup consists of an Atom dual-core (/proc/cpuinfo below) running
> > open-wrt in combination with a Peak CAN usb dongle.  This CAN dongle
> > is interfaced via SocketCAN and written to with high frequency (code
> > below). This code runs from a dedicated thread. This thread is the
> > only place we access the CAN interface (can0).
>
> Is this Peak CAN USB dongle driver in the kernel tree somewhere?  Or is
> it an out-of-tree driver?

This CAN USB dongle driver is part of mainline kernel:

https://github.com/torvalds/linux/blob/master/drivers/net/can/usb/peak_usb/pcan_usb_core.c

> > Sometimes, a write to this can0 interface results in a lock. This only
> > occurs after a write resulting in ENOBUFS. Our code re-attempts to
> > write after a ENOBUFS and the time between the first attempt and the
> > second one influences the rate of this lock occurring. If we
> > usleep(100) our lock happens very fast (~2seconds), usleep(1000) can
> > take up to a minute and we haven't observed the issue with a usleep of
> > 3000. Having the usleep as short as possible is critical for our
> > application. We have only observed locking of the CAN thread on cpu1.
>
> That's concerning.
>
> > This lock results in the core being fully used by the CAN thread and
> > the systems becoming unresponsive. Sometimes this is detected by the
> > kernel, after which a call stack is produced (two callstacks below).
>
> Just to check: you're not seeing this CAN thread return back to
> usermode, correct?  It remains "stuck" spinning in the write() in kernel
> context?

Correct, the thread does not return at all. Pidstat -t shows continuous increasing system usage for the CAN thread and CAN thread alone.

>
> > Please be aware that, due to application limitations, we have our
> > txqueuelen configured as 1. This results in relative frequent ENOBUFS.
> >
> > Changing thread priority or application priority does not change
> > behavior.
>
> Is this true even if ksoftirqd/1 is prioritized over the CAN thread?
>
> > CAN related settings changes like bitrate, CAN2.0 or
> > CAN-FD, frame size, cable length or busload also do not improve the
> > situation.
>
> > We have made traces (using trace-cmd record -e 'sched_wakeup*' -e
> > sched_switch -e 'sched_migrate*' ) during the lock-up and it seems as
> > if a ksoftirqd is sched_wakeup, but never actually switched to right
> > before the lock occurs:
>
> This is what I would expect if your CAN thread is spinning at an RT
> priority greater that ksoftirqd/1.  It's not clear from your traces what
> priority/class your CAN thread is executing as.
>
> >              CAN-2434  [001]   116.127166: sched_wakeup:         ksoftirqd/1:21
> [120] success=1 CPU:001
> >        RtFdbDisp-2133  [000]   116.127175: sched_switch:
> RtFdbDisp:2133 [120] S ==> CFpgaEventColle:2103 [120]
> >  CFpgaEventColle-2103  [000]   116.127179: sched_wakeup:
> ScmIfm:2112 [22] success=1 CPU:000
> >  CFpgaEventColle-2103  [000]   116.127182: sched_switch:
> CFpgaEventColle:2103 [120] R ==> ScmIfm:2112 [22]
> >           ScmIfm-2112  [000]   116.127190: sched_switch:         ScmIfm:2112
> [22] S ==> CFpgaEventColle:2103 [120]
> >  CFpgaEventColle-2103  [000]   116.127195: sched_wakeup:
> ScmIfm:2112 [22] success=1 CPU:000
> >  CFpgaEventColle-2103  [000]   116.127198: sched_switch:
> CFpgaEventColle:2103 [120] R ==> ScmIfm:2112 [22]
> >           ScmIfm-2112  [000]   116.127207: sched_wakeup:
> MsgHndr4:2111 [25] success=1 CPU:000
> >           ScmIfm-2112  [000]   116.127214: sched_switch:         ScmIfm:2112
> [22] S ==> MsgHndr4:2111 [25]
> >         MsgHndr4-2111  [000]   116.127224: sched_wakeup:
> RtFdbDisp:2133 [120] success=1 CPU:000
> >         MsgHndr4-2111  [000]   116.127245: sched_switch:
> MsgHndr4:2111 [25] S ==> RtFdbDisp:2133 [120]
> >        RtFdbDisp-2133  [000]   116.127255: sched_switch:
> RtFdbDisp:2133 [120] S ==> CFpgaEventColle:2103 [120]
> >  CFpgaEventColle-2103  [000]   116.127263: sched_switch:
> CFpgaEventColle:2103 [120] S ==> trace-cmd:2432 [120]
> >        trace-cmd-2432  [000]   116.127331: sched_switch:         trace-
> cmd:2432 [120] S ==> swapper/0:0 [120]
> >              CAN-2434  [001]   116.127604: sched_wakeup:
> ktimersoftd/1:20 [98] success=1 CPU:001
> >              <idle>-0  [000]   116.128849: sched_wakeup:         ktimersoftd/0:8
> [98] success=1 CPU:000
> >              <idle>-0  [000]   116.128863: sched_switch:         swapper/0:0
> [120] R ==> ktimersoftd/0:8 [98]
> >       ktimersoftd/0-8  [000]   116.128897: sched_switch:
> ktimersoftd/0:8 [98] S ==> swapper/0:0 [120]
> >              <idle>-0  [000]   116.130147: sched_wakeup:         ktimersoftd/0:8
> [98] success=1 CPU:000
> >              <idle>-0  [000]   116.130157: sched_switch:         swapper/0:0
> [120] R ==> ktimersoftd/0:8 [98]
> >       ktimersoftd/0-8  [000]   116.130180: sched_wakeup:
> Net_RJ45:2150 [120] success=1 CPU:000
> >
> > and so on. From this point on our CAN thread "locks". It does however
> > perform some scheduling. The lines below are the only occurrences
> > within this particular trace where "CAN-2434" is mentioned after the
> > lock(note the difference in timestamps).
> >
> >        CAN-2434  [001]   116.127604: sched_wakeup:
> ktimersoftd/1:20 [98] success=1 CPU:001
> >        CAN-2434  [001]   116.145468: sched_migrate_task:        comm=tQLive
> pid=2148 prio=23 orig_cpu=1 dest_cpu=0
> >        CAN-2434  [001]   116.145472: sched_wakeup:              tQLive:2148
> [23] success=1 CPU:000
> >        CAN-2434  [001]   116.186470: sched_migrate_task:
> comm=tQCmd pid=2147 prio=23 orig_cpu=1 dest_cpu=0
> >        CAN-2434  [001]   116.186475: sched_wakeup:              tQCmd:2147
> [23] success=1 CPU:000
> >        CAN-2434  [001]   116.228357: sched_migrate_task:
> comm=SockSend pid=2347 prio=33 orig_cpu=1 dest_cpu=0
> >        CAN-2434  [001]   116.418810: sched_wakeup:              rcuc/1:19 [120]
> success=1 CPU:001
>
> If the CAN thread is stuck spinning on CPU1 and we wakeup an unpinned,
> lower priority RT task on CPU1 (making this CPU "overloaded"), the
> scheduler will push tasks around in the wakeup path, like we're seeing
> here.  In other words, nothing about this seems overtly wrong, just a
> symptom of the CAN thread spinning at a high priority.
>
> > The next mention of ksoftirqd in this particular trace is here, way later, in a
> new sched_wakeup. Here the sched_switch is actually made:
> >
> >         <idle>-0 [000]   116.168849: sched_wakeup:         ksoftirqd/0:7 [120]
> success=1 CPU:000
> >         <idle>-0 [000]   116.168858: sched_wakeup:         ktimersoftd/0:8 [98]
> success=1 CPU:000
> >         <idle>-0 [000]   116.168869: sched_switch:         swapper/0:0 [120] R
> ==> ktimersoftd/0:8 [98]
> >  ktimersoftd/0-8 [000]   116.168895: sched_switch:         ktimersoftd/0:8
> [98] S ==> ksoftirqd/0:7 [120]
> >    ksoftirqd/0-7 [000]   116.168905: sched_switch:         ksoftirqd/0:7 [120]
> S ==> swapper/0:0 [120]
>
> This is all on CPU0, though; CPU1 is probably still spinning away. :\
>
> > I can send this full trace and others with this same issue on request.
>
> Having a complete trace is probably going to be more helpful.  It might
> be helpful also to also trace more than just the 'sched' class of trace
> events.  Namely, also include the 'irq' family of events, 'timer' and
> 'net' would probably be helpful as well, given the issue you're seeing
> appears to be in the packet tx stack (more below).

I will send you a separate mail with traces, including ones made with more trace events.

> ...

HBM Netherlands B.V., Schutweg 15a, NL-5145 NP Waalwijk, The Netherlands | www.hbm.com

Registered as B.V. (Dutch limited liability company) in the Dutch commercial register 08183075 0000
Company domiciled in Waalwijk | Managing Directors : Ben Keetman, Peter Ackermans

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.
