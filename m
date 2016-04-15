From: Clark Williams <williams@redhat.com>
Subject: [RT PATCH] cputime: remove raw locks introduced by RT patchset
Date: Thu, 14 Apr 2016 22:09:43 -0500
Message-ID: <20160414220943.3d4d7dd2@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/4ZJqrQuJIg1BynSl+hxDUQV"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/4ZJqrQuJIg1BynSl+hxDUQV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sebastian,

This patch removes the raw spinlock operations when updating cputtime
in the vtime_* functions in kernel/sched/cputime.c.

Based on Frederic's commit b7ce2277f087fd052, there is no need for
the raw spinlocks in vtime_* functions to guard against writer
concurrency and the RT versions of write_seqcount_begin() and
write_seqcount_end() make calls to preempt_disable_rt() and
preempt_enable_rt(), so we'll be in atomic context while updating
cputime.

I've run this patch on x86_64 4.4.6-rt14 and the RHEL-RT kernel,=20
with 12h rteval runs on systems with both no tuning and systems
with isolcpus/rcu_nocbs/nohz_full cpus. No ill effects seen.=20

Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 kernel/sched/cputime.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0f75a38cff96..9a823ced7e4a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -696,45 +696,37 @@ static void __vtime_account_system(struct task_struct=
 *tsk)
=20
 void vtime_account_system(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	__vtime_account_system(tsk);
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
=20
 void vtime_gen_account_irq_exit(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	__vtime_account_system(tsk);
 	if (context_tracking_in_user())
 		tsk->vtime_snap_whence =3D VTIME_USER;
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
=20
 void vtime_account_user(struct task_struct *tsk)
 {
 	cputime_t delta_cpu;
=20
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	delta_cpu =3D get_vtime_delta(tsk);
 	tsk->vtime_snap_whence =3D VTIME_SYS;
 	account_user_time(tsk, delta_cpu, cputime_to_scaled(delta_cpu));
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
=20
 void vtime_user_enter(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	__vtime_account_system(tsk);
 	tsk->vtime_snap_whence =3D VTIME_USER;
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
=20
 void vtime_guest_enter(struct task_struct *tsk)
@@ -746,23 +738,19 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 * synchronization against the reader (task_gtime())
 	 * that can thus safely catch up with a tickless delta.
 	 */
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	__vtime_account_system(tsk);
 	current->flags |=3D PF_VCPU;
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
=20
 void vtime_guest_exit(struct task_struct *tsk)
 {
-	raw_spin_lock(&tsk->vtime_lock);
 	write_seqcount_begin(&tsk->vtime_seq);
 	__vtime_account_system(tsk);
 	current->flags &=3D ~PF_VCPU;
 	write_seqcount_end(&tsk->vtime_seq);
-	raw_spin_unlock(&tsk->vtime_lock);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
=20
@@ -775,30 +763,24 @@ void vtime_account_idle(struct task_struct *tsk)
=20
 void arch_vtime_task_switch(struct task_struct *prev)
 {
-	raw_spin_lock(&prev->vtime_lock);
 	write_seqcount_begin(&prev->vtime_seq);
 	prev->vtime_snap_whence =3D VTIME_SLEEPING;
 	write_seqcount_end(&prev->vtime_seq);
-	raw_spin_unlock(&prev->vtime_lock);
=20
-	raw_spin_lock(&current->vtime_lock);
 	write_seqcount_begin(&current->vtime_seq);
 	current->vtime_snap_whence =3D VTIME_SYS;
 	current->vtime_snap =3D sched_clock_cpu(smp_processor_id());
 	write_seqcount_end(&current->vtime_seq);
-	raw_spin_unlock(&current->vtime_lock);
 }
=20
 void vtime_init_idle(struct task_struct *t, int cpu)
 {
 	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&t->vtime_lock, flags);
 	write_seqcount_begin(&t->vtime_seq);
 	t->vtime_snap_whence =3D VTIME_SYS;
 	t->vtime_snap =3D sched_clock_cpu(cpu);
 	write_seqcount_end(&t->vtime_seq);
-	raw_spin_unlock_irqrestore(&t->vtime_lock, flags);
 }
=20
 cputime_t task_gtime(struct task_struct *t)
--=20
2.5.5


--Sig_/4ZJqrQuJIg1BynSl+hxDUQV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXEFt3AAoJEOI5asVwYXLrnbsQAL5uXGWZnvVVhTwZy3MnviZx
lBC9YtWBiIxHBxYQDG5RhnETHwVcB0ZDcbV1hQURxruxZWkUCQPcQ72OoCW1jl7x
5aPPaC8mB3SQ+DiPArkmuZtaIzcIBaCKXHY6kLC3PMXs7x8J1rFTStQeBX8CqYTW
ZJ7Wh07Z/BbFpuR/KBswQhDYRZl2ZZPJ3Snq2mRLit89JlBB3mxiXihpEsihAMTL
L49HaLRlwcujtWeR+InSPeqyAIJg+AZ4IIGL91a6NccDdEij0TjeSaFsC9OygB5Z
OPte2TfmxzB5s39NeSPCi216t8Z5lQD+e9BNgzjCzA6LS5yx6w4bjzp5JtEGV/8c
gPoOWF4qxNaxQHqsp2XkfO1wOkcsMzU9IaGNQFKIaOXEOo5aikb2EwhctKIHoZC6
HL2Sy2XeLRvg3q4R44nevMvWmIJnnQiKku2fMyG6xIASGJ9TBaLzqJdR8wcNMRJt
EW7vJGTGVlR+y+TyFymhU88r3g8+ersSWY1ho5CTeZnl6DuclJ0o7/10pt1n6ng6
LV7ai9n0kDzQrSOigukETi43e6pPuLeBCopbqvkRxnCRmT35FlXLczc3Mxvj7oH7
vMIH/x9uEr7Yt1JDlGnePeYl/o9xXYi7Lqoc4CqRQp1EG6s79QaxjsKTQzhilt3/
LjeGbVFwHEAMbXr6BXNz
=MRxk
-----END PGP SIGNATURE-----

--Sig_/4ZJqrQuJIg1BynSl+hxDUQV--
