From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc4-rt1
Date: Wed, 12 Aug 2009 15:45:30 -0500
Message-ID: <1250109930.7493.165.camel@lexx>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0904081937191.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904092046440.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904181204420.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904251500150.4529@localhost.localdomain>
	 <alpine.LFD.2.00.0904290036500.4529@localhost.localdomain>
	 <alpine.LFD.2.00.0905012348200.3375@localhost.localdomain>
	 <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain>
	 <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain>
	 <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain>
	 <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <1249500006.4365.86.camel@lexx>
	 <alpine.LFD.2.00.0908112005190.1283@localhost.localdomain>
Reply-To: will_schmidt@vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32907 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbZHLUpe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2009 16:45:34 -0400
In-Reply-To: <alpine.LFD.2.00.0908112005190.1283@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-08-11 at 20:09 +0200, Thomas Gleixner wrote:
> On Wed, 5 Aug 2009, Will Schmidt wrote:
> > /test/willschm/linux-2.6.31-rtx/kernel/spinlock.c:103: error: impli=
cit
> > declaration of function =E2=80=98_raw_atomic_spin_relax=E2=80=99
>=20
> Fix below. Thanks,

Thanks Thomas,
   Still doesn't boot, but after turning on every spinlock and early
debug option I could find I have some more data.  :-)=20

The .find_legacy_serial_ports function in the backtrace is very very
early during boot.   I'll do a bit more looking around to see if it's
anything obvious,.. =20

Thanks,=20
-Will

-----><-----

=46ound initrd at 0xc000000003b00000:0xc000000003c8d000                =
                                                                       =
              =20
 -> pSeries_init_early()                                               =
                                                                       =
            =20
 -> fw_cmo_feature_init()                                              =
                                                                       =
            =20
CMO_PageSize =3D 4096                                                  =
                                                                       =
              =20
CMO not enabled, PrPSP=3D-1, SecPSP=3D-1                               =
                                                                       =
                =20
 <- fw_cmo_feature_init()                                              =
                                                                       =
            =20
 <- pSeries_init_early()                                               =
                                                                       =
            =20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
2.6.31-rc4-rt1-wms.aug12 #2                 =20
---------------------------------------------
swapper/0 is trying to acquire lock:
 (devtree_lock){......}, at: [<c0000000006683fc>] .of_find_property+0x7=
8/0x140

but task is already holding lock:
 (devtree_lock){......}, at: [<c0000000006694f0>] .of_find_compatible_n=
ode+0x48/0x158

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (devtree_lock){......}, at: [<c0000000006694f0>] .of_find_compati=
ble_node+0x48/0x158

stack backtrace:
Call Trace:
[c000000000fbf700] [c0000000000181ac] .show_stack+0x124/0x320 (unreliab=
le)
[c000000000fbf7d0] [c00000000001a410] .dump_stack+0x28/0x3c
[c000000000fbf850] [c000000000118214] .validate_chain+0x6f4/0xed8
[c000000000fbf910] [c000000000119244] .__lock_acquire+0x84c/0x900
[c000000000fbfa10] [c00000000011a3ec] .lock_acquire+0x144/0x194
[c000000000fbfae0] [c0000000007ac620] ._atomic_spin_lock+0x58/0x84
[c000000000fbfb70] [c0000000006683fc] .of_find_property+0x78/0x140
[c000000000fbfc10] [c000000000668508] .of_get_property+0x44/0x78
[c000000000fbfcb0] [c000000000668f78] .of_device_is_compatible+0x48/0x1=
18
[c000000000fbfd60] [c000000000669554] .of_find_compatible_node+0xac/0x1=
58
[c000000000fbfe00] [c000000000b49db8] .find_legacy_serial_ports+0x358/0=
xb8c
[c000000000fbfee0] [c000000000b3d798] .setup_system+0x3d0/0x6c8
[c000000000fbff90] [c0000000000083c8] .start_here_common+0xc/0x44
BUG: spinlock lockup on CPU#0, swapper/0, c000000000ea9f48
Call Trace:
[c000000000fbf8f0] [c0000000000181ac] .show_stack+0x124/0x320 (unreliab=
le)
[c000000000fbf9c0] [c00000000001a410] .dump_stack+0x28/0x3c
[c000000000fbfa40] [c0000000004785c4] ._raw_spin_lock+0x2a8/0x2e8
[c000000000fbfae0] [c0000000007ac62c] ._atomic_spin_lock+0x64/0x84
[c000000000fbfb70] [c0000000006683fc] .of_find_property+0x78/0x140
[c000000000fbfc10] [c000000000668508] .of_get_property+0x44/0x78
[c000000000fbfcb0] [c000000000668f78] .of_device_is_compatible+0x48/0x1=
18
[c000000000fbfd60] [c000000000669554] .of_find_compatible_node+0xac/0x1=
58
[c000000000fbfe00] [c000000000b49db8] .find_legacy_serial_ports+0x358/0=
xb8c
[c000000000fbfee0] [c000000000b3d798] .setup_system+0x3d0/0x6c8
[c000000000fbff90] [c0000000000083c8] .start_here_common+0xc/0x44











>=20
>     tglx
>=20
> -------
> commit ffc969930727238b847176c203bdbe1f9dffe403
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Aug 11 20:03:47 2009 +0200
>=20
>     locks: Fix PREEMPT=3Dy, LOCKBREAK=3Dy, DEBUG_LOCK_ALLOC=3Dn compi=
le
>    =20
>     Should be folded back into the atomic lock conversion
>    =20
>     Reported-by: Will Schmidt <will_schmidt@vnet.ibm.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>=20
> diff --git a/kernel/lock-internals.h b/kernel/lock-internals.h
> index 4f0bc8b..76f694c 100644
> --- a/kernel/lock-internals.h
> +++ b/kernel/lock-internals.h
> @@ -9,8 +9,8 @@
>   * (We do this in a function because inlining it would be excessive.=
)
>   */
>=20
> -#define BUILD_LOCK_OPS(op, locktype)					\
> -void __lockfunc _##op##_lock(locktype##_t *lock)			\
> +#define BUILD_LOCK_OPS(prefix, op, locktype)				\
> +void __lockfunc _##prefix##_lock(locktype##_t *lock)			\
>  {									\
>  	for (;;) {							\
>  		preempt_disable();					\
> @@ -20,15 +20,15 @@ void __lockfunc _##op##_lock(locktype##_t *lock)	=
		\
>  									\
>  		if (!(lock)->break_lock)				\
>  			(lock)->break_lock =3D 1;				\
> -		while (!op##_can_lock(lock) && (lock)->break_lock)	\
> +		while (!prefix##_can_lock(lock) && (lock)->break_lock)	\
>  			_raw_##op##_relax(&lock->raw_lock);		\
>  	}								\
>  	(lock)->break_lock =3D 0;						\
>  }									\
>  									\
> -EXPORT_SYMBOL(_##op##_lock);						\
> +EXPORT_SYMBOL(_##prefix##_lock);					\
>  									\
> -unsigned long __lockfunc _##op##_lock_irqsave(locktype##_t *lock)	\
> +unsigned long __lockfunc _##prefix##_lock_irqsave(locktype##_t *lock=
)	\
>  {									\
>  	unsigned long flags;						\
>  									\
> @@ -42,23 +42,23 @@ unsigned long __lockfunc _##op##_lock_irqsave(loc=
ktype##_t *lock)	\
>  									\
>  		if (!(lock)->break_lock)				\
>  			(lock)->break_lock =3D 1;				\
> -		while (!op##_can_lock(lock) && (lock)->break_lock)	\
> +		while (!prefix##_can_lock(lock) && (lock)->break_lock)	\
>  			_raw_##op##_relax(&lock->raw_lock);		\
>  	}								\
>  	(lock)->break_lock =3D 0;						\
>  	return flags;							\
>  }									\
>  									\
> -EXPORT_SYMBOL(_##op##_lock_irqsave);					\
> +EXPORT_SYMBOL(_##prefix##_lock_irqsave);				\
>  									\
> -void __lockfunc _##op##_lock_irq(locktype##_t *lock)			\
> +void __lockfunc _##prefix##_lock_irq(locktype##_t *lock)		\
>  {									\
> -	_##op##_lock_irqsave(lock);					\
> +	_##prefix##_lock_irqsave(lock);					\
>  }									\
>  									\
> -EXPORT_SYMBOL(_##op##_lock_irq);					\
> +EXPORT_SYMBOL(_##prefix##_lock_irq);					\
>  									\
> -void __lockfunc _##op##_lock_bh(locktype##_t *lock)			\
> +void __lockfunc _##prefix##_lock_bh(locktype##_t *lock)			\
>  {									\
>  	unsigned long flags;						\
>  									\
> @@ -67,9 +67,9 @@ void __lockfunc _##op##_lock_bh(locktype##_t *lock)=
			\
>  	/* irq-disabling. We use the generic preemption-aware	*/	\
>  	/* function:						*/	\
>  	/**/								\
> -	flags =3D _##op##_lock_irqsave(lock);				\
> +	flags =3D _##prefix##_lock_irqsave(lock);				\
>  	local_bh_disable();						\
>  	local_irq_restore(flags);					\
>  }									\
>  									\
> -EXPORT_SYMBOL(_##op##_lock_bh)
> +EXPORT_SYMBOL(_##prefix##_lock_bh)
> diff --git a/kernel/rwlock.c b/kernel/rwlock.c
> index 35460b3..eaf34c8 100644
> --- a/kernel/rwlock.c
> +++ b/kernel/rwlock.c
> @@ -146,8 +146,8 @@ EXPORT_SYMBOL(_write_lock);
>   *         _[read|write]_lock_irqsave()
>   *         _[read|write]_lock_bh()
>   */
> -BUILD_LOCK_OPS(read, rwlock);
> -BUILD_LOCK_OPS(write, rwlock);
> +BUILD_LOCK_OPS(read, read, rwlock);
> +BUILD_LOCK_OPS(write, write, rwlock);
>=20
>  #endif /* CONFIG_PREEMPT */
>=20
> diff --git a/kernel/spinlock.c b/kernel/spinlock.c
> index 6a3c0c4..e3194d5 100644
> --- a/kernel/spinlock.c
> +++ b/kernel/spinlock.c
> @@ -100,7 +100,7 @@ EXPORT_SYMBOL(_atomic_spin_lock);
>   *         _atomic_spin_lock_irqsave()
>   *         _atomic_spin_lock_bh()
>   */
> -BUILD_LOCK_OPS(atomic_spin, atomic_spinlock);
> +BUILD_LOCK_OPS(atomic_spin, spin, atomic_spinlock);
>=20
>  #endif /* CONFIG_PREEMPT */
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
