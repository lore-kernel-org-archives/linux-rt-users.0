From: Julia Cartwright <julia@ni.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Fri, 3 Mar 2017 14:32:35 -0600
Message-ID: <20170303203235.GE29100@jcartwri.amer.corp.natinst.com>
References: <20170210190708.gkx5pzxnd6uhfczn@linutronix.de>
 <1487011713.17279.27.camel@intel.com>
 <20170215165447.zr4k5rmenwvormdk@linutronix.de>
 <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com>
 <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
 <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
 <1488424982.29259.32.camel@intel.com>
 <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tlsmith3777@gmail.com" <tlsmith3777@gmail.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:34444 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751722AbdCCUcu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2017 15:32:50 -0500
Content-Disposition: inline
In-Reply-To: <20170303194159.GD29100@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 01:41:59PM -0600, Julia Cartwright wrote:
> On Thu, Mar 02, 2017 at 03:23:02AM +0000, Patel, Vedang wrote:
[..]
> > Case 1:
> > 	TASK		CPU=A0	TIMESTAMP	EVENT		=A0
> > =A0 =A0 =A0 cyclictest-2351=A0=A0[003]=A0=A07773.130964: hrtimer_start:=
=A0=A0=A0=A0=A0=A0=A0=A0hrtimer=3D0xffff88046b098828 function=3Dposix_timer=
_fn/0x0 expires=3D7767043047952 softexpires=3D7767043047952
> > =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.130978: sched_sw=
itch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] S =3D=3D> ktimersoftd/=
3:36 [98]
> > =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.130992: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:23=
51 [19]
> > =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.131003: sched_sw=
itch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] D =3D=3D> ktimersoftd/=
3:36 [19] <--- cyclictest is in TASK_UNINTERRUPTIBLE state.
> > =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131006: signal_gen=
erate:=A0=A0=A0=A0=A0=A0sig=3D14 errno=3D0 code=3D131070 comm=3Dcyclictest =
pid=3D2351 grp=3D0 res=3D0
> > =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131018: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:23=
51 [19]
> > =A0=A0=A0=A0=A0=A0cyclictest-2351=A0=A0[003]=A0=A07773.131031: sched_sw=
itch:=A0=A0=A0=A0=A0=A0=A0=A0=A0cyclictest:2351 [19] D =3D=3D> ktimersoftd/=
3:36 [19]
> > =A0=A0=A0ktimersoftd/3-36=A0=A0=A0=A0[003]=A0=A07773.131046: sched_swit=
ch:=A0=A0=A0=A0=A0=A0=A0=A0=A0ktimersoftd/3:36 [98] R =3D=3D> cyclictest:23=
51 [19]
>=20
> This ktimersoftd -> cyclictest -> ktimersoftd -> cyclictest "bounce" is
> a result of how the signal completion code for the posix itimers is
> done.
>=20
>    [ktimersoftd]                [cyclictest]
>      lock task->sighand
>      set pending signal
>      signal_wake_up(task)  --->
>                                  lock task->sighand (*blocked*, state D)
>                            <---
>      trace signal_generate
>      unlock task->sighand
>                            --->
>                                  while (!pending signal)
>                                    unlock task->sighand
>                                    wait for signal
>                                    lock task->sighand
>                                  unlock task->sighand

A corrected diagram below (same codepaths, layed out differently):

    [ktimersoftd]                [cyclictest]
                                  lock task->sighand
                                  while (!pending signal) {
                                    unlock task->sighand
                                    wait for signal (state S)

                   ... after interval ...

      lock task->sighand
      set pending signal
      signal_wake_up(task)  --->    (woken, state R)
                                    lock task->sighand (*blocked*, state D)
                            <---
      trace signal_generate
      unlock task->sighand
                            --->  }
                                  unlock task->sighand
                                  ...

   Julia

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli50uAACgkQjNrC4UVN
dG9bTwf8DEaSIJvbVo9nsw9ti+cWrM6rlfHnrTHF1pyoYqqsgkVL9onD4XSXKoGV
mq3GOGNKfjVTZP6MKwEKr7Tk4/FIGNCVR+9xUExNwFtR0kzl9JytEq/0MwWJ6+QJ
bS9tNkJcmXGp3DiVjX3ZHKc+XSf/LTFXf+6t718VsrFKwx0Z256Lr8o1zkPpw5fm
2kleX2Sm2majCwd2lzgB6sq5grQHs7n+bmemw2iXlV57skPCjBH1+Vk6xn0SmHZE
pGH2xWnQd2usHOSwlIuds5UN6s7wdSgwrKkK3vhVN1c9Y9eXtgkY6dIv7bL7Vf+I
zweJXZG6yIUZ/aionMjk/3HK0IPCMA==
=rKva
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
