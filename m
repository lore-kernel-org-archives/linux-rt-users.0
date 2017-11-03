From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] v4.13.10-rt3 (possible recursive locking warning)
Date: Fri, 3 Nov 2017 10:11:47 -0700
Message-ID: <916b113b-f743-8b3f-6f47-70ed572f76b6@ccrma.stanford.edu>
References: <20171027222709.sna64giwxak4dxxc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027222709.sna64giwxak4dxxc@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/27/2017 03:27 PM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.13.10-rt3 patch set.

Thanks!! Wonderful!
I'm seeing this (old Lenovo T510 running Fedora 26):

--------
[   54.942022] ============================================
[   54.942023] WARNING: possible recursive locking detected
[   54.942026] 4.13.10-200.rt3.1.fc26.ccrma.x86_64+rt #1 Not tainted
[   54.942026] --------------------------------------------
[   54.942028] csd-sound/1392 is trying to acquire lock:
[   54.942029]  (&lock->wait_lock){....-.}, at: [<ffffffffb19b2a5d>] 
rt_spin_lock_slowunlock+0x4d/0xa0
[   54.942038]
                but task is already holding lock:
[   54.942039]  (&lock->wait_lock){....-.}, at: [<ffffffffb1165c79>] 
futex_lock_pi+0x269/0x4b0
[   54.942044]
                other info that might help us debug this:
[   54.942045]  Possible unsafe locking scenario:

[   54.942045]        CPU0
[   54.942045]        ----
[   54.942046]   lock(&lock->wait_lock);
[   54.942046]   lock(&lock->wait_lock);
[   54.942047]
                 *** DEADLOCK ***

[   54.942047]  May be due to missing lock nesting notation

[   54.942048] 1 lock held by csd-sound/1392:
[   54.942049]  #0:  (&lock->wait_lock){....-.}, at: 
[<ffffffffb1165c79>] futex_lock_pi+0x269/0x4b0
[   54.942051]
                stack backtrace:
[   54.942053] CPU: 2 PID: 1392 Comm: csd-sound Not tainted 
4.13.10-200.rt3.1.fc26.ccrma.x86_64+rt #1
[   54.942054] Hardware name: LENOVO 4313CTO/4313CTO, BIOS 6MET64WW 
(1.27 ) 07/15/2010
[   54.942055] Call Trace:
[   54.942059]  dump_stack+0x8e/0xd6
[   54.942065]  __lock_acquire+0x72f/0x13b0
[   54.942071]  ? sched_clock+0x9/0x10
[   54.942074]  ? futex_lock_pi+0x269/0x4b0
[   54.942076]  lock_acquire+0xa3/0x250
[   54.942077]  ? lock_acquire+0xa3/0x250
[   54.942079]  ? rt_spin_lock_slowunlock+0x4d/0xa0
[   54.942080]  ? reacquire_held_locks+0xf8/0x180
[   54.942083]  _raw_spin_lock_irqsave+0x4d/0x90
[   54.942084]  ? rt_spin_lock_slowunlock+0x4d/0xa0
[   54.942085]  rt_spin_lock_slowunlock+0x4d/0xa0
[   54.942087]  rt_spin_unlock+0x2a/0x40
[   54.942089]  futex_lock_pi+0x277/0x4b0
[   54.942090]  ? futex_wait_queue_me+0x100/0x170
[   54.942092]  ? futex_wait+0x227/0x250
[   54.942096]  do_futex+0x304/0xc20
[   54.942099]  ? wake_up_new_task+0x1ec/0x370
[   54.942102]  ? _do_fork+0x176/0x750
[   54.942104]  ? up_read+0x2a/0x30
[   54.942106]  SyS_futex+0x13b/0x180
[   54.942110]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   54.942113]  entry_SYSCALL_64_fastpath+0x1f/0xbe
[   54.942116] RIP: 0033:0x7fe500f2d7b2
[   54.942116] RSP: 002b:00007ffd13017110 EFLAGS: 00000246 ORIG_RAX: 
00000000000000ca
[   54.942117] RAX: ffffffffffffffda RBX: 00007fe4e7df7700 RCX: 
00007fe500f2d7b2
[   54.942118] RDX: 0000000000000001 RSI: 0000000000000086 RDI: 
0000557e090dd3f0
[   54.942119] RBP: 00007ffd13017280 R08: 0000000000000000 R09: 
0000000000000001
[   54.942119] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[   54.942120] R13: 00007ffd13017210 R14: 00007fe4e7df79c0 R15: 
0000000000000000
--------

Best,
-- Fernando


> Changes since v4.13.10-rt2:
>
>   - A dcache related live lock could occur. The writer could get
>     preempted within the critical section and the reader would spin to
>     see the update completed. This update would never complete if the
>     writer was preempted by a reader with a higher priority. Reported by
>     Oleg Karfich.
>
>   - The tpm_tis driver can cause latency spikes (~400us) after multiple
>     writes to the chip is followed by a read operation. This read causes
>     a flush of all the cached writes to the chip and is blocking the CPU
>     until the operation completes. Reported and patched by Haris
>     Okanovic.
>
>   - The upgrade to v4.13-RT broke the zram driver. Patched by Mike
>     Galbraith.
>
>   - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patchset
>     has been update to v3.
>
>   - The static SRCU notifier wasn't compiling with SRCU_TINY. Reported
>     by kbuild test robot.
