From: John Kacur <jkacur@redhat.com>
Subject: Re: lockdep splat with 3.2-rc2-rt3+
Date: Mon, 21 Nov 2011 09:44:06 +0100
Message-ID: <CAONaPpEdxdZLTDzf11ojT7tqHoVqsp3YFwx_UJafvRpyKHCjrQ@mail.gmail.com>
References: <20111120113621.7d738d55@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53960 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1KUIoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Nov 2011 03:44:07 -0500
Received: by vbbfc21 with SMTP id fc21so2241934vbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Nov 2011 00:44:07 -0800 (PST)
In-Reply-To: <20111120113621.7d738d55@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Nov 20, 2011 at 6:36 PM, Clark Williams
<clark.williams@gmail.com> wrote:
> Thomas/Peter,
>
> I have the following lockdep splat running 3.2-rc2-rt3+:
>
> [ 8807.696833] BUG: MAX_LOCKDEP_ENTRIES too low!
> [ 8807.696835] turning off the locking correctness validator.
> [ 8807.696839] Pid: 1347, comm: Xorg Tainted: G =A0 =A0 =A0 =A0W =A0 =
=A03.2.0-rc2-rt3+ #4
> [ 8807.696841] Call Trace:
> [ 8807.696847] =A0[<ffffffff81086d79>] add_lock_to_list.constprop.21+=
0x45/0xa7
> [ 8807.696854] =A0[<ffffffff81088844>] check_prev_add+0x187/0x207
> [ 8807.696859] =A0[<ffffffff8101576e>] ? native_sched_clock+0x34/0x36
> [ 8807.696862] =A0[<ffffffff810154f1>] ? __cycles_2_ns+0xe/0x3a
> [ 8807.696865] =A0[<ffffffff8108894f>] check_prevs_add+0x8b/0x104
> [ 8807.696869] =A0[<ffffffff81088d29>] validate_chain+0x361/0x39d
> [ 8807.696872] =A0[<ffffffff81089404>] __lock_acquire+0x37a/0x3f3
> [ 8807.696877] =A0[<ffffffff810b802e>] ? rcu_preempt_note_context_swi=
tch+0x16d/0x184
> [ 8807.696883] =A0[<ffffffff814dbdf2>] ? __schedule+0xca/0x505
> [ 8807.696886] =A0[<ffffffff81089960>] lock_acquire+0xc4/0x108
> [ 8807.696889] =A0[<ffffffff814dbdf2>] ? __schedule+0xca/0x505
> [ 8807.696893] =A0[<ffffffff810b802e>] ? rcu_preempt_note_context_swi=
tch+0x16d/0x184
> [ 8807.696897] =A0[<ffffffff814de23a>] _raw_spin_lock_irq+0x4a/0x7e
> [ 8807.696900] =A0[<ffffffff814dbdf2>] ? __schedule+0xca/0x505
> [ 8807.696903] =A0[<ffffffff810b8d16>] ? rcu_note_context_switch+0x34=
/0x39
> [ 8807.696906] =A0[<ffffffff814dbdf2>] __schedule+0xca/0x505
> [ 8807.696909] =A0[<ffffffff814dc285>] ? preempt_schedule_irq+0x36/0x=
5f
> [ 8807.696912] =A0[<ffffffff81140876>] ? dentry_iput+0x49/0xaf
> [ 8807.696914] =A0[<ffffffff814dc28f>] preempt_schedule_irq+0x40/0x5f
> [ 8807.696916] =A0[<ffffffff814de926>] retint_kernel+0x26/0x30
> [ 8807.696919] =A0[<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
> [ 8807.696921] =A0[<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
> [ 8807.696925] =A0[<ffffffff810857ef>] ? arch_local_irq_restore+0x6/0=
xd
> [ 8807.696927] =A0[<ffffffff8108987a>] lock_release+0x89/0xab
> [ 8807.696929] =A0[<ffffffff814ddabb>] rt_spin_unlock+0x20/0x2c
> [ 8807.696931] =A0[<ffffffff81140876>] dentry_iput+0x49/0xaf
> [ 8807.696933] =A0[<ffffffff81141392>] dentry_kill+0xcd/0xe4
> [ 8807.696935] =A0[<ffffffff811417b9>] dput+0xf1/0x102
> [ 8807.696938] =A0[<ffffffff81130922>] __fput+0x1a9/0x1c1
> [ 8807.696951] =A0[<ffffffffa002b3da>] ? drm_gem_handle_create+0xe1/0=
xe1 [drm]
> [ 8807.696953] =A0[<ffffffff81130957>] fput+0x1d/0x1f
> [ 8807.696959] =A0[<ffffffffa002b17e>] drm_gem_object_release+0x17/0x=
19 [drm]
> [ 8807.696973] =A0[<ffffffffa009a13d>] nouveau_gem_object_del+0x55/0x=
64 [nouveau]
> [ 8807.696980] =A0[<ffffffffa002b408>] drm_gem_object_free+0x2e/0x30 =
[drm]
> [ 8807.696983] =A0[<ffffffff8125acd7>] kref_put+0x43/0x4d
> [ 8807.696989] =A0[<ffffffffa002b0d8>] drm_gem_object_unreference_unl=
ocked+0x36/0x43 [drm]
> [ 8807.696996] =A0[<ffffffffa002b1f0>] drm_gem_object_handle_unrefere=
nce_unlocked.part.0+0x27/0x2c [drm]
> [ 8807.697002] =A0[<ffffffffa002b2e8>] drm_gem_handle_delete+0xac/0xb=
d [drm]
> [ 8807.697010] =A0[<ffffffffa002b7d9>] drm_gem_close_ioctl+0x28/0x2a =
[drm]
> [ 8807.697016] =A0[<ffffffffa0029a2c>] drm_ioctl+0x2ce/0x3ae [drm]
> [ 8807.697018] =A0[<ffffffff8112eb28>] ? do_sync_read+0xc2/0x102
> [ 8807.697021] =A0[<ffffffff8104aa12>] ? finish_task_switch+0x3f/0xf8
> [ 8807.697027] =A0[<ffffffffa002b7b1>] ? drm_gem_destroy+0x43/0x43 [d=
rm]
> [ 8807.697031] =A0[<ffffffff8113e165>] do_vfs_ioctl+0x27e/0x296
> [ 8807.697033] =A0[<ffffffff81089dff>] ? trace_hardirqs_on_caller.par=
t.20+0xbd/0xf4
> [ 8807.697035] =A0[<ffffffff811305c7>] ? fget_light+0x3a/0xa4
> [ 8807.697038] =A0[<ffffffff8113e1d3>] sys_ioctl+0x56/0x7b
> [ 8807.697040] =A0[<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
> [ 8807.697043] =A0[<ffffffff814e46c2>] system_call_fastpath+0x16/0x1b
>
>
> $ sudo cat /proc/lockdep_stats
> =A0lock-classes: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1667=
 [max: 8191]
> =A0direct dependencies: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16384 [max: 1=
6384]
> =A0indirect dependencies: =A0 =A0 =A0 =A0 =A0 =A0 =A0 64565
> =A0all direct dependencies: =A0 =A0 =A0 =A0 =A0 =A0 76304
> =A0dependency chains: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 29400 [max:=
 32768]
> =A0dependency chain hlocks: =A0 =A0 =A0 =A0 =A0 =A0125503 [max: 16384=
0]
> =A0in-hardirq chains: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
> =A0in-softirq chains: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0in-process chains: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 29378
> =A0stack-trace entries: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0236171 [max: 2=
62144]
> =A0combined max dependencies: =A0 =A0 =A0 =A0 =A0675717
> =A0hardirq-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
> =A0hardirq-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1498
> =A0softirq-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0softirq-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1498
> =A0irq-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
> =A0irq-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1498
> =A0hardirq-read-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0hardirq-read-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 217
> =A0softirq-read-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0softirq-read-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 217
> =A0irq-read-safe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0irq-read-unsafe locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 217
> =A0uncategorized locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A044
> =A0unused locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00
> =A0max locking depth: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> =A0max bfs queue depth: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01016
> =A0debug_locks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0
>
>
> I've saved /proc/{lockdep, lock_stat, lockdep-chains} if you want to
> see them.
>
> System is a Lenovo Thinkpad W510, quadcore i7 (HT enabled), with 4GB =
of
> RAM.
>

Me too, I've had this problem with quite a few kernels for awhile,
although I probably enable more debug options than Clark does. This is
a real PITA - because I really like lockdep functionality, and don't
feel like I should have to give up other debug functionality to have
it. If there is nothing obviously wrong I think we ought to consider a
patch to raise the MAX_LOCKDEP_ENTRIES, at least optionally at config
time.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
