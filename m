From: Julia Cartwright <julia@ni.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Fri, 3 Mar 2017 13:41:59 -0600
Message-ID: <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
References: <1486579285.29816.105.camel@intel.com>
 <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
 <1487011713.17279.27.camel@intel.com>
 <20170215165447.zr4k5rmenwvormdk@linutronix.de>
 <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com>
 <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
 <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
 <1488424982.29259.32.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:42375 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751593AbdCCTme (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2017 14:42:34 -0500
Content-Disposition: inline
In-Reply-To: <1488424982.29259.32.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vedang-

On Thu, Mar 02, 2017 at 03:23:02AM +0000, Patel, Vedang wrote:
[..]
> As for running cyclictest with posix timers, I see the following
> results with the same hardware and kernel:
>=20
> Case 1:
> ~/rt-tests# ./cyclictest -t1 -p 80 -i 500 -l 100000=A0=A0=A0
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.01 0.02 0.00 2/204 6936
>=20
> T: 0 ( 6926) P:80 I:500 C: 100000 Min:=A0=A0=A0=A0=A011 Act:=A0=A0=A016 A=
vg:=A0=A0=A015 Max:=A0=A0=A0=A0=A0=A065
>=20
>=20
> Case 2:
> ~/rt-tests# ./cyclictest -a 3 -t1 -p 80 -i 500 -l 100000
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.15 0.04 0.01 1/204 6954=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0
>=20
> T: 0 ( 6943) P:80 I:500 C: 100000 Min:=A0=A0=A0=A0=A031 Act:=A0=A0=A045 A=
vg:=A0=A0=A043 Max:=A0=A0=A0=A0=A0=A059
>=20
> Note that the first test is without any cpu affinity and the second
> test by pinning down =A0the cyclictest process to a CPU by providing the
> '-a' argument.
>=20
> I also tried tracing cyclictest using trace-cmd by enabling
> hrtimer_start, sched_switch, sched_migrate_task, signal_generate and
> grepping for cyclictest in the logs. I see the following transitions in
> both the cases:
>=20
> Case 1:
> 	TASK		CPU=A0	TIMESTAMP	EVENT		=A0
> =A0 =A0 =A0 cyclictest-2351=A0=A0[003]=A0=A07773.130964: hrtimer_start:=
=A0=A0=A0=A0=A0=A0=A0=A0hrtimer=3D0xffff88046b098828 function=3Dposix_timer=
_fn/0x0 expires=3D7767043047952 softexpires=3D7767043047952
> =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.130978: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] S =3D=3D> ktimersoftd/3:=
36 [98]
> =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.130992: sched_switch=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:2351=
 [19]
> =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.131003: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] D =3D=3D> ktimersoftd/3:=
36 [19] <--- cyclictest is in TASK_UNINTERRUPTIBLE state.
> =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131006: signal_gener=
ate:=A0=A0=A0=A0=A0=A0sig=3D14 errno=3D0 code=3D131070 comm=3Dcyclictest pi=
d=3D2351 grp=3D0 res=3D0
> =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131018: sched_switch=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:2351=
 [19]
> =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.131031: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] D =3D=3D> ktimersoftd/3:=
36 [19]
> =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131046: sched_switch=
:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:2351=
 [19]

This ktimersoftd -> cyclictest -> ktimersoftd -> cyclictest "bounce" is
a result of how the signal completion code for the posix itimers is
done.

   [ktimersoftd]                [cyclictest]
     lock task->sighand
     set pending signal
     signal_wake_up(task)  --->
                                 lock task->sighand (*blocked*, state D)
                           <---
     trace signal_generate
     unlock task->sighand
                           --->
                                 while (!pending signal)
                                   unlock task->sighand
                                   wait for signal
                                   lock task->sighand
                                 unlock task->sighand

Without PREEMPT_RT_FULL enabled, the critical section is executed with
"raw" spinlocks, and is therefore non-preemptible.  However, with
RT_FULL, the preemptibility of the section leads to the "bounce".

That should make it clear why ktimersoftd would be PI boosted, as well.

Now, it isn't clear to me why the affinitized scenario appears to make
this happen more frequently...  Nor do I have a handle on what to do to
fix this (if anything).

   Julia

PS: callstack for cyclictest:
      sigwait() (userspace)
      ...
         do_sigtimedwait()

    callstack for ktimersoftd:
       hrtimer_run_pending()
          posix_timer_fn()
            posix_timer_event()
              send_sigqueue(()

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli5xwQACgkQjNrC4UVN
dG8JlQf/a9ZrrCClRcThBdc3F83ZVzWnaW1MMs8IX+8QWFoR0U1J0svUjfo8u5e2
qj8eWcgG6JuAAErprKWEXrEaoXRYnOqGVAJgKYrDomA00pqHjND8Y+/oqLxU/v97
ooemHFewQE0Ii5L6am3YdK7CQdarKIqA5lSnW7kablFrfBCNxNE6UfcJWaJryXqv
tWREi42rTweZ/GQaccL4yE+jg/sZCDGmI30VzmuPyPgbHv87FVaUO3imvidYrFWn
lD6dt6S8p/1A0HA+Ow0nJnVTtmCLo1UmYrHyc1CfvSINtTT+RxN0PjFsczb7V+7Z
6KiJzB2UkhcldOUshFLFTgD71nKcgA==
=x2Ag
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
