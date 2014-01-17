From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.6-rt9
Date: Fri, 17 Jan 2014 18:00:52 +0100
Message-ID: <20140117170052.GF5785@linutronix.de>
References: <20131223225017.GA8623@linutronix.de>
 <1387900067.5490.33.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54778 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaAQRAz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 12:00:55 -0500
Content-Disposition: inline
In-Reply-To: <1387900067.5490.33.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-12-24 16:47:47 [+0100]:

>I built this kernel with Paul's patch and NO_HZ_FULL enabled again on =
64
>core box.  I haven't seen RCU grip yet, but I just checked on it after
>3.5 hours into this boot/beat (after fixing crash+kdump setup), and
>found it in the process of dumping.=20

So you also have the timers-do-not-raise-softirq-unconditionally.patch?

>crash> bt
>PID: 508    TASK: ffff8802739ba340  CPU: 16  COMMAND: "ksoftirqd/16"
> #0 [ffff880276806a40] machine_kexec at ffffffff8103bc07
> #1 [ffff880276806aa0] crash_kexec at ffffffff810d56b3
> #2 [ffff880276806b70] panic at ffffffff815bf8b0
> #3 [ffff880276806bf0] watchdog_overflow_callback at ffffffff810fed3d
> #4 [ffff880276806c10] __perf_event_overflow at ffffffff81131928
> #5 [ffff880276806ca0] perf_event_overflow at ffffffff81132254
> #6 [ffff880276806cb0] intel_pmu_handle_irq at ffffffff8102078f
> #7 [ffff880276806de0] perf_event_nmi_handler at ffffffff815c5825
> #8 [ffff880276806e10] nmi_handle at ffffffff815c4ed3
> #9 [ffff880276806ea0] default_do_nmi at ffffffff815c5063
>#10 [ffff880276806ed0] do_nmi at ffffffff815c5388
>#11 [ffff880276806ef0] end_repeat_nmi at ffffffff815c4371
>    [exception RIP: _raw_spin_trylock+48]
>    RIP: ffffffff815c3790  RSP: ffff880276803e28  RFLAGS: 00000002
>    RAX: 0000000000000010  RBX: 0000000000000010  RCX: 000000000000000=
2
>    RDX: ffff880276803e28  RSI: 0000000000000018  RDI: 000000000000000=
1
>    RBP: ffffffff815c3790   R8: ffffffff815c3790   R9: 000000000000001=
8
>    R10: ffff880276803e28  R11: 0000000000000002  R12: fffffffffffffff=
f
>    R13: ffff880273a0c000  R14: ffff8802739ba340  R15: ffff880273a03fd=
8
>    ORIG_RAX: ffff880273a03fd8  CS: 0010  SS: 0018
>--- <RT exception stack> ---
>#12 [ffff880276803e28] _raw_spin_trylock at ffffffff815c3790
>#13 [ffff880276803e30] rt_spin_lock_slowunlock_hirq at ffffffff815c2cc=
8
>#14 [ffff880276803e50] rt_spin_unlock_after_trylock_in_irq at ffffffff=
815c3425
>#15 [ffff880276803e60] get_next_timer_interrupt at ffffffff810684a7
>#16 [ffff880276803ed0] tick_nohz_stop_sched_tick at ffffffff810c5f2e
>#17 [ffff880276803f50] tick_nohz_irq_exit at ffffffff810c6333
>#18 [ffff880276803f70] irq_exit at ffffffff81060065
>#19 [ffff880276803f90] smp_apic_timer_interrupt at ffffffff810358f5
>#20 [ffff880276803fb0] apic_timer_interrupt at ffffffff815cbf9d
>--- <IRQ stack> ---
>#21 [ffff880273a03b28] apic_timer_interrupt at ffffffff815cbf9d
>    [exception RIP: _raw_spin_lock+50]
>    RIP: ffffffff815c3642  RSP: ffff880273a03bd8  RFLAGS: 00000202
>    RAX: 0000000000008b49  RBX: ffff880272157290  RCX: ffff8802739ba34=
0
>    RDX: 0000000000008b4a  RSI: 0000000000000010  RDI: ffff880273a0c00=
0
>    RBP: ffff880273a03bd8   R8: 0000000000000001   R9: 000000000000000=
0
>    R10: 0000000000000000  R11: 0000000000000001  R12: ffffffff810927b=
5
>    R13: ffff880273a03b68  R14: 0000000000000010  R15: 000000000000001=
0
>    ORIG_RAX: ffffffffffffff10  CS: 0010  SS: 0018
>#22 [ffff880273a03be0] rt_spin_lock_slowlock at ffffffff815c2591
>#23 [ffff880273a03cc0] rt_spin_lock at ffffffff815c3362
>#24 [ffff880273a03cd0] run_timer_softirq at ffffffff81069002
>#25 [ffff880273a03d70] handle_softirq at ffffffff81060d0f
>#26 [ffff880273a03db0] do_current_softirqs at ffffffff81060f3c
>#27 [ffff880273a03e20] run_ksoftirqd at ffffffff81061045
>#28 [ffff880273a03e40] smpboot_thread_fn at ffffffff81089c31
>#29 [ffff880273a03ec0] kthread at ffffffff810807fe
>#30 [ffff880273a03f50] ret_from_fork at ffffffff815cb28c
>crash> gdb list *0xffffffff815c2591
>0xffffffff815c2591 is in rt_spin_lock_slowlock (kernel/rtmutex.c:109).
>104     }
>105     #endif
>106    =20
>107     static inline void init_lists(struct rt_mutex *lock)
>108     {
>109             if (unlikely(!lock->wait_list.node_list.prev))
>110                     plist_head_init(&lock->wait_list);
>111     }
>112    =20
>113     /*
>crash> gdb list *0xffffffff815c2590
>0xffffffff815c2590 is in rt_spin_lock_slowlock (kernel/rtmutex.c:744).
>739             struct rt_mutex_waiter waiter, *top_waiter;
>740             int ret;
>741    =20
>742             rt_mutex_init_waiter(&waiter, true);
>743    =20
>744             raw_spin_lock(&lock->wait_lock);
>745             init_lists(lock);
>746    =20
>747             if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LAT=
ERAL)) {
>748                     raw_spin_unlock(&lock->wait_lock);
>crash> gdb list *0xffffffff815c2cc8
>0xffffffff815c2cc8 is in rt_spin_lock_slowunlock_hirq (kernel/rtmutex.=
c:851).
>846     {
>847             int ret;
>848    =20
>849             do {
>850                     ret =3D raw_spin_trylock(&lock->wait_lock);
>851             } while (!ret);
>852    =20
>853             __rt_spin_lock_slowunlock(lock);
>854     }
>855
>
>Dang, Santa might have delivered a lock pick set in a few more hours.

I have a small problem with understanding this=E2=80=A6

|#24 [ffff880273a03cd0] run_timer_softirq at ffffffff81069002

Here we obtain wait_lock from tvec_base of _this_ CPU. And we get to
init_lists() before the apic timer kicks in. So we have the wait_lock.
In the hard interrupt triggered by the apic timer we get to
get_next_timer_interrupt() and go again for same the wait_lock. Here we
have the try_lock so we avoid this deadlock.
The odd part: we get the lock. It should be the same lock because both =
use
| struct tvec_base *base =3D __this_cpu_read(tvec_bases);
to ge it. And we shouldn't get it because the lock is already hold.
We get into trouble in the unlock path where we spin forever:

|#14 [ffff880276803e50] rt_spin_unlock_after_trylock_in_irq at ffffffff=
815c3425
|#12 [ffff880276803e28] _raw_spin_trylock at ffffffff815c3790

which releases the lock with a trylock in order to keep lockdep happy.
My understanding was that we should be able to obtain the wait_lock her=
e
since we were able to obtain it in the lock path and in irq off context
there is nothing that could take the lock in the meantime.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
