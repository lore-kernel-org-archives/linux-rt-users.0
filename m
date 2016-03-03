From: Josh Cartwright <joshc@ni.com>
Subject: Re: AW: AW: Large latencies with 4.4.1-rt6
Date: Thu, 3 Mar 2016 09:42:27 -0600
Message-ID: <20160303154227.GA28102@jcartwri.amer.corp.natinst.com>
References: <1A2AF5F768264E479963C4D8C015EB691B6A461B@DLREXMBX01.intra.dlr.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Cc: tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:47558 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756367AbcCCPml (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Mar 2016 10:42:41 -0500
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B6A461B@DLREXMBX01.intra.dlr.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Martin-

On Thu, Mar 03, 2016 at 09:44:25AM +0000, Martin.Wirth@dlr.de wrote:
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: Thomas Gleixner [mailto:tglx@linutronix.de]
> > Gesendet: Dienstag, 1. M=E4rz 2016 11:08
> > An: Wirth, Martin
> > Cc: bigeasy@linutronix.de
> > Betreff: Re: AW: AW: AW: Large latencies with 4.4.1-rt6
> >=20
> > Can you try to gather a trace:
> >=20
> > cyclictest -Sp99 -m -i200 -f -b500

Cyclictest should have mentioned which CPU was triggering the break, the
most valuable traces are from that CPU.

> > You might need to up the interval a bit, but that should give us the re=
ason for
> > this hickup.
> >
>
> I finally found the reason for the ms range latencies.
>
> When we bought the cpu -card about 2 years ago we had problems with
> the built-in DP to VGA bridge in combination with a KVM switch.  To
> solve this I added, as suggested on a linux forum, the kernel
> parameter  i915.disable_power_well=3D0. With former kernels this did no
> harm, but with 4.4 it causes the large latencies. The i915 driver even
> warns that  disable_power_well is deprecated and dangerous now but I
> overlooked this in the kernel log.
>
> So now that this is gone, I still see a lot of 100 =B5s range latencies
> with 4.4.3-rt9. Interestingly I get even larger ones of up to 200 =B5s
> when tracing is not enabled (over 12 h runs).
>
> The traces around such a 100 =B5s hickup look like this:
>
[..]
>      cc1-17437   0d..h... 195934553us : irq_exit <-do_IRQ
>      cc1-17437   0d..h... 195934553us : irqtime_account_irq <-irq_exit
>      cc1-17437   0d..h... 195934553us : preempt_count_sub <-irq_exit
>      cc1-17437   0d...... 195934553us!: rcu_irq_exit <-irq_exit
>      cc1-17437   0d...... 195934680us : do_IRQ <-ret_from_intr
>      cc1-17437   0d...... 195934681us : irq_enter <-do_IRQ
>      cc1-17437   0d...... 195934681us : rcu_irq_enter <-irq_enter
>      cc1-17437   0d...... 195934681us : irqtime_account_irq <-irq_enter
>      cc1-17437   0d...... 195934681us : in_serving_softirq <-irqtime_acco=
unt_irq
>      cc1-17437   0d...... 195934681us : preempt_count_add <-irq_enter
>      cc1-17437   0d..h... 195934681us : exit_idle <-do_IRQ
>      cc1-17437   0d..h... 195934682us : handle_irq <-do_IRQ
>      cc1-17437   0d..h... 195934682us : handle_edge_irq <-handle_irq
>      cc1-17437   0d..h... 195934682us : _raw_spin_lock <-handle_edge_irq
>      cc1-17437   0d..h... 195934682us : preempt_count_add <-_raw_spin_lock
>      cc1-17437   0d..h1.. 195934682us : irq_chip_ack_parent <-handle_edge=
_irq
>      cc1-17437   0d..h1.. 195934682us : apic_ack_edge <-irq_chip_ack_pare=
nt
>      cc1-17437   0d..h1.. 195934682us : irq_complete_move <-apic_ack_edge
>      cc1-17437   0d..h1.. 195934682us : irq_move_irq <-apic_ack_edge
>      cc1-17437   0d..h1.. 195934682us : handle_irq_event <-handle_edge_irq
>      cc1-17437   0d..h1.. 195934683us : preempt_count_sub <-handle_irq_ev=
ent
>      cc1-17437   0d..h... 195934683us : handle_irq_event_percpu <-handle_=
irq_event
>      cc1-17437   0d..h... 195934683us : irq_default_primary_handler <-han=
dle_irq_event_percpu
>      cc1-17437   0d..h... 195934683us : __irq_wake_thread <-handle_irq_ev=
ent_percpu
>      cc1-17437   0d..h... 195934683us : wake_up_process <-__irq_wake_thre=
ad
>      cc1-17437   0d..h... 195934683us : try_to_wake_up <-wake_up_process
>      cc1-17437   0d..h... 195934683us : _raw_spin_lock_irqsave <-try_to_w=
ake_up
>      cc1-17437   0d..h... 195934683us : preempt_count_add <-_raw_spin_loc=
k_irqsave
>      cc1-17437   0d..h1.. 195934683us : select_task_rq_rt <-try_to_wake_up
>      cc1-17437   0d..h1.. 195934684us : __rcu_read_lock <-select_task_rq_=
rt
>      cc1-17437   0d..h1.. 195934684us : __rcu_read_unlock <-select_task_r=
q_rt
>      cc1-17437   0d..h1.. 195934684us : _raw_spin_lock <-try_to_wake_up
>      cc1-17437   0d..h1.. 195934684us : preempt_count_add <-_raw_spin_lock
>      cc1-17437   0d..h2.. 195934684us : ttwu_do_activate.constprop.100 <-=
try_to_wake_up
>      cc1-17437   0d..h2.. 195934684us : activate_task <-ttwu_do_activate.=
constprop.100
>      cc1-17437   0d..h2.. 195934684us : update_rq_clock.part.89 <-activat=
e_task
>      cc1-17437   0d..h2.. 195934684us : enqueue_task_rt <-activate_task
>      cc1-17437   0d..h2.. 195934684us : dequeue_rt_stack <-enqueue_task_rt
>      cc1-17437   0d..h2.. 195934684us : dequeue_top_rt_rq <-dequeue_rt_st=
ack
>      cc1-17437   0d..h2.. 195934685us : cpupri_set <-enqueue_task_rt
>      cc1-17437   0d..h2.. 195934685us : update_rt_migration <-enqueue_tas=
k_rt
>      cc1-17437   0d..h2.. 195934685us : _raw_spin_lock <-enqueue_task_rt
>      cc1-17437   0d..h2.. 195934685us : preempt_count_add <-_raw_spin_lock
>      cc1-17437   0d..h3.. 195934685us : preempt_count_sub <-enqueue_task_=
rt
>      cc1-17437   0d..h2.. 195934685us : enqueue_top_rt_rq <-enqueue_task_=
rt
>      cc1-17437   0d..h2.. 195934685us : ttwu_do_wakeup <-ttwu_do_activate=
=2Econstprop.100
>      cc1-17437   0d..h2.. 195934686us : check_preempt_curr <-ttwu_do_wake=
up
>      cc1-17437   0d..h2.. 195934686us : resched_curr <-check_preempt_curr
>      cc1-17437   0d..h2.. 195934686us : native_smp_send_reschedule <-resc=
hed_curr
>      cc1-17437   0d..h2.. 195934686us : flat_send_IPI_mask <-native_smp_s=
end_reschedule
>      cc1-17437   0d..h2.. 195934687us : task_woken_rt <-ttwu_do_wakeup
>      cc1-17437   0d..h2.. 195934687us : preempt_count_sub <-try_to_wake_up
>      cc1-17437   0d..h1.. 195934687us : __rcu_read_lock <-try_to_wake_up
>      cc1-17437   0d..h1.. 195934687us : __rcu_read_unlock <-try_to_wake_up
>      cc1-17437   0d..h1.. 195934687us : _raw_spin_unlock_irqrestore <-try=
_to_wake_up
>      cc1-17437   0d..h1.. 195934687us : preempt_count_sub <-_raw_spin_unl=
ock_irqrestore
>      cc1-17437   0d..h... 195934687us : note_interrupt <-handle_irq_event=
_percpu
>      cc1-17437   0d..h... 195934687us : _raw_spin_lock <-handle_irq_event
>      cc1-17437   0d..h... 195934688us : preempt_count_add <-_raw_spin_lock
>      cc1-17437   0d..h1.. 195934688us : preempt_count_sub <-handle_edge_i=
rq
>      cc1-17437   0d..h... 195934688us : irq_exit <-do_IRQ =20

Do you have more complete traces of what's going on on the other CPUs as
well?  As far as I can see here, CPU0 is handling a couple interrupts,
which trigger remote wakeups of irqthreads running on the other
CPUs..nothing unusual?

  Josh

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW2FtgAAoJEKp7ZBKwQFAr1VkH/0UOmz59ZiKv0cKe+GSesb3V
PzrMiDmDEFQFnxfekDLYwPKMVHZbSTx0OzwUBthJAzPiySSzbuGF5jqAopHiobHA
A96fiiluAZs1DRM6Fa2G4CyiDvcKDMtTQTSzRAWnG/p17TARSoJyvQzazOojgcVQ
nJ9i3wjkh4jWNGM/sGwYlpucj1f9f9ER+WrVPYwdnAe72D7Xt9s067oVftXfuUQC
dwrzEJ3zEAPhNf0Fv2gQ6KrX9+Z6x1GWIjr28lV3sDt3q4KvHXlFcnF6AIQjaoMA
nBMuqsC9eXFRfGrFYODJ1DK1jij6V0qn8Kr7pWXyXfGkyKTzGorbL70CAKc82/4=
=I4UB
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
