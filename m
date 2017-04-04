From: Henrik Austad <henrik@austad.us>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Tue, 4 Apr 2017 07:42:47 +0200
Message-ID: <20170404054247.GE12288@icarus.home.austad.us>
References: <CAOuSAjfVPjd5VFDdvzd6NN=ddCeVtmQj_WAB6xDt6R7Yxux73w@mail.gmail.com>
 <CAJ2oMhKPbh5BJW+JBGtLSvUxukB2e1MA_DierJ1P6k5Cbs+Ohg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Cc: Alison Chaiken <alison@peloton-tech.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34508 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdDDFmw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 01:42:52 -0400
Received: by mail-lf0-f45.google.com with SMTP id z15so86263401lfd.1
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Apr 2017 22:42:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKPbh5BJW+JBGtLSvUxukB2e1MA_DierJ1P6k5Cbs+Ohg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 08:06:23AM +0300, Ran Shalit wrote:
> On Mon, Apr 3, 2017 at 5:38 AM, Alison Chaiken <alison@peloton-tech.com> =
wrote:
> >  Ran Shalit <ranshalit@gmail.com> wrote:
> >> I have found in
> >> https://wiki.linuxfoundation.org/realtime/documentation/howto/applicat=
ions/cyclic
> >> that there is EDF scheduler option for creating a periodic RT thread.
> >> Yet, I could not understand what's behind the EDF scheduler
> >
> >
> > Have a look at "Using SCHED_DEADLINE" at
> >
> > http://elinux.org/ELC_Europe_2016_Presentations
> >
> > Also, look for papers on this topic by Juri Lelli.
> >
> > HTH,
> > Alison
>=20
> Hi Alison,
>=20
> Thank you very much.
> I reviewed the material, which is very interesting, but I am not yet
> sure which timer are used internally in SCHED_DEADLINE.
> Is it posix or non-posix ?

A "posix-timer" is a userspace-construct. A posix-timer will use the=20
hrtimer in the kernel - which ends up in the same subsystem used by the=20
deadline scheduler.

--=20
Henrik Austad

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljjMlcACgkQ6k5VT6v45llC6ACg0i4ykkAt/baG43Qv/uFvchKp
jvQAnA2LbWuu5ezi8jo3dlK5HFV9kvFC
=j7nx
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
