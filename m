From: Clark Williams <clark.williams@gmail.com>
Subject: lockdep splat with 3.2-rc2-rt3+
Date: Sun, 20 Nov 2011 11:36:21 -0600
Message-ID: <20111120113621.7d738d55@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0OsTB_d53Ea_1SvxvOG=t+p"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41334 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab1KTRgn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Nov 2011 12:36:43 -0500
Received: by vcbfk1 with SMTP id fk1so4858647vcb.19
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Nov 2011 09:36:42 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/0OsTB_d53Ea_1SvxvOG=t+p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thomas/Peter,

I have the following lockdep splat running 3.2-rc2-rt3+:

[ 8807.696833] BUG: MAX_LOCKDEP_ENTRIES too low!
[ 8807.696835] turning off the locking correctness validator.
[ 8807.696839] Pid: 1347, comm: Xorg Tainted: G        W    3.2.0-rc2-rt3+ =
#4
[ 8807.696841] Call Trace:
[ 8807.696847]  [<ffffffff81086d79>] add_lock_to_list.constprop.21+0x45/0xa7
[ 8807.696854]  [<ffffffff81088844>] check_prev_add+0x187/0x207
[ 8807.696859]  [<ffffffff8101576e>] ? native_sched_clock+0x34/0x36
[ 8807.696862]  [<ffffffff810154f1>] ? __cycles_2_ns+0xe/0x3a
[ 8807.696865]  [<ffffffff8108894f>] check_prevs_add+0x8b/0x104
[ 8807.696869]  [<ffffffff81088d29>] validate_chain+0x361/0x39d
[ 8807.696872]  [<ffffffff81089404>] __lock_acquire+0x37a/0x3f3
[ 8807.696877]  [<ffffffff810b802e>] ? rcu_preempt_note_context_switch+0x16=
d/0x184
[ 8807.696883]  [<ffffffff814dbdf2>] ? __schedule+0xca/0x505
[ 8807.696886]  [<ffffffff81089960>] lock_acquire+0xc4/0x108
[ 8807.696889]  [<ffffffff814dbdf2>] ? __schedule+0xca/0x505
[ 8807.696893]  [<ffffffff810b802e>] ? rcu_preempt_note_context_switch+0x16=
d/0x184
[ 8807.696897]  [<ffffffff814de23a>] _raw_spin_lock_irq+0x4a/0x7e
[ 8807.696900]  [<ffffffff814dbdf2>] ? __schedule+0xca/0x505
[ 8807.696903]  [<ffffffff810b8d16>] ? rcu_note_context_switch+0x34/0x39
[ 8807.696906]  [<ffffffff814dbdf2>] __schedule+0xca/0x505
[ 8807.696909]  [<ffffffff814dc285>] ? preempt_schedule_irq+0x36/0x5f
[ 8807.696912]  [<ffffffff81140876>] ? dentry_iput+0x49/0xaf
[ 8807.696914]  [<ffffffff814dc28f>] preempt_schedule_irq+0x40/0x5f
[ 8807.696916]  [<ffffffff814de926>] retint_kernel+0x26/0x30
[ 8807.696919]  [<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
[ 8807.696921]  [<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
[ 8807.696925]  [<ffffffff810857ef>] ? arch_local_irq_restore+0x6/0xd
[ 8807.696927]  [<ffffffff8108987a>] lock_release+0x89/0xab
[ 8807.696929]  [<ffffffff814ddabb>] rt_spin_unlock+0x20/0x2c
[ 8807.696931]  [<ffffffff81140876>] dentry_iput+0x49/0xaf
[ 8807.696933]  [<ffffffff81141392>] dentry_kill+0xcd/0xe4
[ 8807.696935]  [<ffffffff811417b9>] dput+0xf1/0x102
[ 8807.696938]  [<ffffffff81130922>] __fput+0x1a9/0x1c1
[ 8807.696951]  [<ffffffffa002b3da>] ? drm_gem_handle_create+0xe1/0xe1 [drm]
[ 8807.696953]  [<ffffffff81130957>] fput+0x1d/0x1f
[ 8807.696959]  [<ffffffffa002b17e>] drm_gem_object_release+0x17/0x19 [drm]
[ 8807.696973]  [<ffffffffa009a13d>] nouveau_gem_object_del+0x55/0x64 [nouv=
eau]
[ 8807.696980]  [<ffffffffa002b408>] drm_gem_object_free+0x2e/0x30 [drm]
[ 8807.696983]  [<ffffffff8125acd7>] kref_put+0x43/0x4d
[ 8807.696989]  [<ffffffffa002b0d8>] drm_gem_object_unreference_unlocked+0x=
36/0x43 [drm]
[ 8807.696996]  [<ffffffffa002b1f0>] drm_gem_object_handle_unreference_unlo=
cked.part.0+0x27/0x2c [drm]
[ 8807.697002]  [<ffffffffa002b2e8>] drm_gem_handle_delete+0xac/0xbd [drm]
[ 8807.697010]  [<ffffffffa002b7d9>] drm_gem_close_ioctl+0x28/0x2a [drm]
[ 8807.697016]  [<ffffffffa0029a2c>] drm_ioctl+0x2ce/0x3ae [drm]
[ 8807.697018]  [<ffffffff8112eb28>] ? do_sync_read+0xc2/0x102
[ 8807.697021]  [<ffffffff8104aa12>] ? finish_task_switch+0x3f/0xf8
[ 8807.697027]  [<ffffffffa002b7b1>] ? drm_gem_destroy+0x43/0x43 [drm]
[ 8807.697031]  [<ffffffff8113e165>] do_vfs_ioctl+0x27e/0x296
[ 8807.697033]  [<ffffffff81089dff>] ? trace_hardirqs_on_caller.part.20+0xb=
d/0xf4
[ 8807.697035]  [<ffffffff811305c7>] ? fget_light+0x3a/0xa4
[ 8807.697038]  [<ffffffff8113e1d3>] sys_ioctl+0x56/0x7b
[ 8807.697040]  [<ffffffff8111ea8e>] ? __local_lock_irq+0x26/0x79
[ 8807.697043]  [<ffffffff814e46c2>] system_call_fastpath+0x16/0x1b


$ sudo cat /proc/lockdep_stats=20
 lock-classes:                         1667 [max: 8191]
 direct dependencies:                 16384 [max: 16384]
 indirect dependencies:               64565
 all direct dependencies:             76304
 dependency chains:                   29400 [max: 32768]
 dependency chain hlocks:            125503 [max: 163840]
 in-hardirq chains:                      22
 in-softirq chains:                       0
 in-process chains:                   29378
 stack-trace entries:                236171 [max: 262144]
 combined max dependencies:          675717
 hardirq-safe locks:                     20
 hardirq-unsafe locks:                 1498
 softirq-safe locks:                      0
 softirq-unsafe locks:                 1498
 irq-safe locks:                         20
 irq-unsafe locks:                     1498
 hardirq-read-safe locks:                 0
 hardirq-read-unsafe locks:             217
 softirq-read-safe locks:                 0
 softirq-read-unsafe locks:             217
 irq-read-safe locks:                     0
 irq-read-unsafe locks:                 217
 uncategorized locks:                    44
 unused locks:                            0
 max locking depth:                      18
 max bfs queue depth:                  1016
 debug_locks:                             0


I've saved /proc/{lockdep, lock_stat, lockdep-chains} if you want to
see them.

System is a Lenovo Thinkpad W510, quadcore i7 (HT enabled), with 4GB of
RAM.

Clark

--Sig_/0OsTB_d53Ea_1SvxvOG=t+p
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJOyTqfAAoJEOIu7msziWiGgYEIAMkCeMTH48SCwcFQGn3Mwr6O
9G5gGt6ngQB4v3SzdMJd/qO5XwNItIzQ+vTR8uJYDSToL93ySNdzKyKrajhi73cA
5s6N6tCj71KQD5nLje372L4pR0dfxdjHnYK5IYCdjLHypBlq79yYK1zpSXBbEBgJ
2y5gHaAbeNGh/8ogvWC/ouxAL/paHs70jiQ+onpo5aViX6elmVPxhyzdH1EE99L4
lzfa5NyvnOyveHAPIS+xydql/90ZQSaxU/kOSL9188UU+8P/AxXRzU9MNfkxlEsS
JjYJeE5UbPTMJTzBdXeXm74aQeurhKPxgYkizxibg0drs8Zv0UhsLangVR9GDZQ=
=4XO2
-----END PGP SIGNATURE-----

--Sig_/0OsTB_d53Ea_1SvxvOG=t+p--
