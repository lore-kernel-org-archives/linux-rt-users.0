From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: AW: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Fri, 21 Dec 2012 08:23:17 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBCEE96@fe20099s.ecn.etasgroup.com>
References: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
 <alpine.LFD.2.02.1212201856140.3148@ionos>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F9467A784CC48947B1D879F07370839E0EBCEE96fe20099secnetas_"
Cc: Jan Kiszka <jan.kiszka@web.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:27179 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2LUIXr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 03:23:47 -0500
In-Reply-To: <alpine.LFD.2.02.1212201856140.3148@ionos>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--_002_F9467A784CC48947B1D879F07370839E0EBCEE96fe20099secnetas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

thanks for the response.
> On Wed, 19 Dec 2012, Koehrer Mathias (ETAS/ESS2) wrote:
> > > >
> > > > I have detected the following issue:
> > > > I use an x86 PC using kernel 3.2.34-rt51 and I want to run VirtualB=
ox 4.2.4
> using
> > > this PC as host.
> > >
> > > > However, the PC freezes completely when loading the vbox driver "vb=
oxdrv".
> > > > Using the very same kernel without the RT_PREEMPT patch shows no is=
sues.
> > > >
> > > > Using an older version of VirtualBox (V4.1.22) works fine as well.
> > > >
> > > > I know that this might be slightly off-topic. However there might b=
e some
> > > RT_PREEMPT users that have detected the same issue and know a solutio=
n for
> this.
> > >
> > > (...)
> > > Try enabling lock debugging. Likely there is an incompatibility in th=
e
> > > vbox driver or even a bug, and that may reveal more details.
> >
> > In addition, I did a long debug session (using a parallel port LED adap=
ter any
> many PC resets...) to identify the issue.
> > Lock debugging did not work as really everything was frozen or the PC.
> > However, I finally identified the critical lines of code.
> > The relevant source file is the attached file "spinlock-r0drv-linux.c" =
of the
> VirtualBox OSE V4.2.4.
> > The freeze happens in line 158 (spin_unlock_irqrestore()).
> >
> > ----------- BEGIN CODE FRAGMENT --------------------
> > RTDECL(void) RTSpinlockRelease(RTSPINLOCK Spinlock)
> > {
> >     PRTSPINLOCKINTERNAL pThis =3D (PRTSPINLOCKINTERNAL)Spinlock;
> >     RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE_VARS();
> >     AssertMsg(pThis && pThis->u32Magic =3D=3D RTSPINLOCK_MAGIC,
> >               ("pThis=3D%p u32Magic=3D%08x\n", pThis, pThis ? (int)pThi=
s->u32Magic :
> 0));
> >     RT_ASSERT_PREEMPT_CPUID_SPIN_RELEASE(pThis);
> >
> >     if (pThis->fFlags & RTSPINLOCK_FLAGS_INTERRUPT_SAFE)
> >     {
> >         unsigned long fIntSaved =3D pThis->fIntSaved;
> >         pThis->fIntSaved =3D 0;
> >         spin_unlock_irqrestore(&pThis->Spinlock, fIntSaved);   // <--- =
Here is the
> freeze!
> >     }
> >     else
> >         spin_unlock(&pThis->Spinlock);
> >
> >     RT_ASSERT_PREEMPT_CPUID();
> > }
> > RT_EXPORT_SYMBOL(RTSpinlockRelease);
> > ----------- END CODE FRAGMENT --------------------
>=20
> Was it really necessary to expose us to the camel case inflicted
> horror of the VirtualBox spinlock abstraction layer just a few days
> before Christmas?
Sorry for  that!

> You said:
> > Lock debugging did not work as really everything was frozen or the PC.
>=20
> That's an indicator that something is really wrong. Can you just run
> the same crap on a non-rt kernel with CONFIG_PROVE_LOCKING enabled ?

I did. It shows actually an error.
Here is the relevant dmesg output:

--------------- BEGIN dmesg output -----------------
vboxdrv: Found 4 processor cores.
vboxdrv: fAsync=3D0 offMin=3D0x50c offMax=3D0x5940

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: inconsistent lock state ]
3.2.34-2 #1
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&(&pThis->Spinlock)->rlock){?.+...}, at: [<f883c7a9>] VBoxHost_RTSpinlock=
Acquire+0x15/0x24 [vboxdrv]
{HARDIRQ-ON-W} state was registered at:
  [<c104b99a>] __lock_acquire+0x509/0x1337
  [<c104cb3a>] lock_acquire+0x42/0x59
  [<c13204d5>] _raw_spin_lock+0x25/0x34
  [<f883c7b3>] VBoxHost_RTSpinlockAcquire+0x1f/0x24 [vboxdrv]
  [<f883986f>] VBoxHost_RTMpNotificationRegister+0x36/0x11a [vboxdrv]
  [<f88324f8>] supdrvInitDevExt+0x4f4/0x65c [vboxdrv]
  [<f8868053>] VBoxDrvLinuxInit+0x53/0xcd [vboxdrv]
  [<c100106b>] do_one_initcall+0x6b/0x10c
  [<c1054299>] sys_init_module+0x122f/0x13fa
  [<c1321990>] sysenter_do_call+0x12/0x36
irq event stamp: 278096
hardirqs last  enabled at (278093): [<c1007c3a>] mwait_idle+0x57/0x7c
hardirqs last disabled at (278094): [<c1320f34>] call_function_interrupt+0x=
28/0x34
softirqs last  enabled at (278096): [<c102e3db>] _local_bh_enable+0xd/0xf
softirqs last disabled at (278095): [<c102e7a8>] irq_enter+0x29/0x4e

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&pThis->Spinlock)->rlock);
  <Interrupt>
    lock(&(&pThis->Spinlock)->rlock);

 *** DEADLOCK ***

no locks held by swapper/1/0.

stack backtrace:
Pid: 0, comm: swapper/1 Tainted: G           O 3.2.34-2 #1
Call Trace:
 [<c131c0bb>] print_usage_bug.part.27+0x1f0/0x1fa
 [<c104b313>] mark_lock+0x334/0x4b2
 [<c104a95b>] ? check_usage_backwards+0xce/0xce
 [<c104b92d>] __lock_acquire+0x49c/0x1337
 [<c104cb3a>] lock_acquire+0x42/0x59
 [<f883c7a9>] ? VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
 [<c1320583>] _raw_spin_lock_irqsave+0x2e/0x3e
 [<f883c7a9>] ? VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
 [<f883c7a9>] VBoxHost_RTSpinlockAcquire+0x15/0x24 [vboxdrv]
 [<f8831d69>] ? supdrvGipMpEventOnline+0x14d/0x14d [vboxdrv]
 [<f8831c77>] supdrvGipMpEventOnline+0x5b/0x14d [vboxdrv]
 [<f8831d69>] ? supdrvGipMpEventOnline+0x14d/0x14d [vboxdrv]
 [<f8831d77>] supdrvGipInitOnCpu+0xe/0x10 [vboxdrv]
 [<f883b688>] rtmpLinuxWrapper+0x22/0x2d [vboxdrv]
 [<f883b666>] ? VBoxHost_RTMpCpuId+0xa/0xa [vboxdrv]
 [<c1051253>] generic_smp_call_function_interrupt+0x6b/0x112
 [<c1014595>] smp_call_function_interrupt+0x20/0x2e
 [<c1320f3b>] call_function_interrupt+0x2f/0x34
 [<c104007b>] ? __run_hrtimer.isra.28+0x33/0x9e
 [<c1007c42>] ? mwait_idle+0x5f/0x7c
 [<c10014c2>] cpu_idle+0x4d/0x76
 [<c14ff2e8>] start_secondary+0x1ab/0x1b2
vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
vboxdrv: Successfully loaded version 4.2.4 (interface 0x001a0004).
vboxpci: pci-stub module not available, cannot detach PCI devices
vboxpci: IOMMU not found (not compiled)
--------------- END dmesg output -----------------

I attached the kernel configuration used for this test.

Thanks for the support.

Regards and merry Christmas.

Mathias


--_002_F9467A784CC48947B1D879F07370839E0EBCEE96fe20099secnetas_
Content-Type: application/x-gzip; name="config.gz"
Content-Description: config.gz
Content-Disposition: attachment; filename="config.gz"; size=14433;
	creation-date="Fri, 21 Dec 2012 08:17:11 GMT";
	modification-date="Fri, 21 Dec 2012 08:17:05 GMT"
Content-Transfer-Encoding: base64

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
Klb/BzAeJHpu7AAA

--_002_F9467A784CC48947B1D879F07370839E0EBCEE96fe20099secnetas_--
