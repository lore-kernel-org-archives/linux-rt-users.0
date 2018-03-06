Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:34669 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeCFSV5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Mar 2018 13:21:57 -0500
Date: Tue, 6 Mar 2018 19:21:54 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Message-ID: <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
References: <1520350053.1744.6.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1520350053.1744.6.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-03-06 15:27:33 [+0000], Roosen Henri wrote:
> Hi,
> 
> Ever since 4.9 we've been chasing random kernel crashes which are
> reproducible on RT in SMP on iMX6Q. It happens when the system is
> stressed using hackbench, however, only when hackbench is used with
> sockets, not when used with pipes.
> 
> Lately we've upgraded to v4.14.20-rt17, which doesn't solve the issue,
> but instead locks up the kernel. After switching on some Lock-Debugging 
> we've been able to catch a trace (see below). It would be great if
> someone could have a look at it, or guide me in tracing down the root-
> cause.

The backtrace suggests that the rq lock is taken with interrupts
disabled and then with interrupts enabled. But based on the call-trace
it should be with interrupts disabled in both cases.
I do have a imx6q running hackbench on a regular basis and I haven't
seen this. Do you see this backtrace on every hackbench invocation or
just after some time. The uptime suggest after ~5 hours.
Do you have the .config somewhere?

> Thanks,
> Henri
> 
> [18586.277233] ================================
> [18586.277236] WARNING: inconsistent lock state
> [18586.277245] 4.14.20-rt17-henri-1 #15 Tainted: G        W
> [18586.277248] --------------------------------
> [18586.277253] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [18586.277263] hackbench/18985 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [18586.277267]  (&rq->lock){?...}, at: [<c0992134>]  __schedule+0x128/0x6ac
> [18586.277300] {IN-HARDIRQ-W} state was registered at:
> [18586.277314]   lock_acquire+0x288/0x32c
> [18586.277324]   _raw_spin_lock+0x48/0x58
> [18586.277338]   scheduler_tick+0x40/0xb4
> [18586.277349]   update_process_times+0x38/0x6c
> [18586.277359]   tick_periodic+0x120/0x148
> [18586.277366]   tick_handle_periodic+0x2c/0xa0
> [18586.277378]   twd_handler+0x3c/0x48
> [18586.277389]   handle_percpu_devid_irq+0x290/0x608
> [18586.277395]   generic_handle_irq+0x28/0x38
> [18586.277402]   __handle_domain_irq+0xd4/0xf0
> [18586.277409]   gic_handle_irq+0x64/0xa8
> [18586.277414]   __irq_svc+0x70/0xc4
> [18586.277420]   lock_acquire+0x2a4/0x32c
> [18586.277425]   lock_acquire+0x2a4/0x32c
> [18586.277440]   down_write_nested+0x54/0x68
> [18586.277453]   sget_userns+0x310/0x4f4
> [18586.277465]   mount_pseudo_xattr+0x68/0x170
> [18586.277477]   nsfs_mount+0x3c/0x50
> [18586.277484]   mount_fs+0x24/0xa8
> [18586.277490]   vfs_kern_mount+0x58/0x118
> [18586.277496]   kern_mount_data+0x24/0x34
> [18586.277507]   nsfs_init+0x20/0x58
> [18586.277522]   start_kernel+0x2f8/0x360
> [18586.277528]   0x1000807c
> [18586.277532] irq event stamp: 19441
> [18586.277542] hardirqs last  enabled at (19441): [<c099665c>] _raw_spin_unlock_irqrestore+0x88/0x90
> [18586.277550] hardirqs last disabled at (19440): [<c09962f8>] _raw_spin_lock_irqsave+0x2c/0x68
> [18586.277562] softirqs last  enabled at (0): [<c0120c18>] copy_process.part.5+0x370/0x1a54
> [18586.277568] softirqs last disabled at (0): [<  (null)>]   (null)
> [18586.277571]
>                other info that might help us debug this:
> [18586.277574]  Possible unsafe locking scenario:
> 
> [18586.277576]        CPU0
> [18586.277578]        ----
> [18586.277580]   lock(&rq->lock);
> [18586.277587]   <Interrupt>
> [18586.277588]     lock(&rq->lock);
> [18586.277594]
>                 *** DEADLOCK ***
> 
> [18586.277599] 2 locks held by hackbench/18985:
> [18586.277601]  #0:  (&u->iolock){+.+.}, at: [<c081de30>] unix_stream_read_generic+0xb0/0x7e4
> [18586.277624]  #1:  (rcu_read_lock){....}, at: [<c081b73c>] unix_write_space+0x0/0x2b0
> [18586.277640]
>                stack backtrace:
> [18586.277651] CPU: 1 PID: 18985 Comm: hackbench Tainted: G        W       4.14.20-rt17-henri-1 #15
> [18586.277654] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [18586.277683] [<c0111600>] (unwind_backtrace) from [<c010bfe8>] (show_stack+0x20/0x24)
> [18586.277701] [<c010bfe8>] (show_stack) from [<c097d79c>] (dump_stack+0x9c/0xd0)
> [18586.277714] [<c097d79c>] (dump_stack) from [<c0175424>] (print_usage_bug+0x1c8/0x2d0)
> [18586.277725] [<c0175424>] (print_usage_bug) from [<c0175970>] (mark_lock+0x444/0x69c)
> [18586.277736] [<c0175970>] (mark_lock) from [<c0177114>] (__lock_acquire+0x23c/0x172c)
> [18586.277748] [<c0177114>] (__lock_acquire) from [<c017935c>] (lock_acquire+0x288/0x32c)
> [18586.277759] [<c017935c>] (lock_acquire) from [<c0996150>] (_raw_spin_lock+0x48/0x58)
> [18586.277774] [<c0996150>] (_raw_spin_lock) from [<c0992134>] (__schedule+0x128/0x6ac)
> [18586.277789] [<c0992134>] (__schedule) from [<c09929c0>] (preempt_schedule_irq+0x5c/0x8c)
> [18586.277801] [<c09929c0>] (preempt_schedule_irq) from [<c010cc8c>] (svc_preempt+0x8/0x2c)
> [18586.277815] [<c010cc8c>] (svc_preempt) from [<c0190b60>] (__rcu_read_unlock+0x40/0x98)
> [18586.277829] [<c0190b60>] (__rcu_read_unlock) from [<c081b9a4>] (unix_write_space+0x268/0x2b0)
> [18586.277847] [<c081b9a4>] (unix_write_space) from [<c07643d8>] (sock_wfree+0x70/0xac)
> [18586.277860] [<c07643d8>] (sock_wfree) from [<c081aff0>] (unix_destruct_scm+0x74/0x7c)
> [18586.277876] [<c081aff0>] (unix_destruct_scm) from [<c076a8dc>] (skb_release_head_state+0x78/0x80)
> [18586.277891] [<c076a8dc>] (skb_release_head_state) from [<c076ac28>] (skb_release_all+0x1c/0x34)
> [18586.277905] [<c076ac28>] (skb_release_all) from [<c076ac5c>] (__kfree_skb+0x1c/0x28)
> [18586.277919] [<c076ac5c>] (__kfree_skb) from [<c076b470>] (consume_skb+0x228/0x2b4)
> [18586.277933] [<c076b470>] (consume_skb) from [<c081e3d4>] (unix_stream_read_generic+0x654/0x7e4)
> [18586.277947] [<c081e3d4>] (unix_stream_read_generic) from [<c081e65c>] (unix_stream_recvmsg+0x5c/0x68)
> [18586.277969] [<c081e65c>] (unix_stream_recvmsg) from [<c075f0e0>] (sock_recvmsg+0x28/0x2c)
> [18586.277983] [<c075f0e0>] (sock_recvmsg) from [<c075f174>] (sock_read_iter+0x90/0xb8)
> [18586.277998] [<c075f174>] (sock_read_iter) from [<c02559ec>] (__vfs_read+0x108/0x12c)
> [18586.278010] [<c02559ec>] (__vfs_read) from [<c0255ab0>] (vfs_read+0xa0/0x10c)
> [18586.278021] [<c0255ab0>] (vfs_read) from [<c0255f4c>] (SyS_read+0x50/0x88)
> [18586.278035] [<c0255f4c>] (SyS_read) from [<c01074e0>]

Sebastian
