From: Henrik Austad <henrik@austad.us>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Tue, 4 Apr 2017 07:38:17 +0200
Message-ID: <20170404053817.GD12288@icarus.home.austad.us>
References: <CAJ2oMhJ-QgYCttetEF49nDge2UkheudG1MXJemerPm0P7zvUhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Cc: Alison Chaiken <alison@peloton-tech.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35849 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdDDFiX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 01:38:23 -0400
Received: by mail-lf0-f42.google.com with SMTP id x137so86392985lff.3
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Apr 2017 22:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJ-QgYCttetEF49nDge2UkheudG1MXJemerPm0P7zvUhA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 03:53:27PM +0300, Ran Shalit wrote:
> On Mon, Apr 3, 2017 at 8:06 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> > On Mon, Apr 3, 2017 at 5:38 AM, Alison Chaiken <alison@peloton-tech.com=
> wrote:
> >>  Ran Shalit <ranshalit@gmail.com> wrote:
> >>> I have found in
> >>> https://wiki.linuxfoundation.org/realtime/documentation/howto/applica=
tions/cyclic
> >>> that there is EDF scheduler option for creating a periodic RT thread.
> >>> Yet, I could not understand what's behind the EDF scheduler
> >>
> >>
> >> Have a look at "Using SCHED_DEADLINE" at
> >>
> >> http://elinux.org/ELC_Europe_2016_Presentations
> >>
> >> Also, look for papers on this topic by Juri Lelli.
> >>
> >> HTH,
> >> Alison
> >
> > Hi Alison,
> >
> > Thank you very much.
> > I reviewed the material, which is very interesting, but I am not yet
> > sure which timer are used internally in SCHED_DEADLINE.
> > Is it posix or non-posix ?
> >
> > Thanks,
> > Ran
>=20
> I am trying to understand which scheduler is better used with RT.
> In the wiki there is an example for SCHED_FIFO, periodic time.
> But in sched_deadline wiki ( https://wiki.automotivelinux.org/sched_deadl=
ine )
> it is said as following:
> "
>  Using SCHED_FIFO/SCHED_RR, instead, we can give that kind of
> guarantee only using a global period, with the constraint that =E2=80=9Ca
> subgroup must have a smaller or equal period to its parent=E2=80=9D.
> The latency experienced by a task (i.e., the time between two
> consecutive executions of a task) is not deterministic and cannot be
> bound, since it highly depends on the number of tasks running in the
> system at that time. Using EDF, instead, this time is deterministic,
> bounded and known at any instant of time."
>=20
> I am not sure now. Does it mean that using more than one SCHED_FIFO
> periodic thread is not deterministic compared with SCHED_DEADLINE?

It means that when you use priorities, you basically do a one-way mapping=
=20
between the inherit deadlines in your tasks to a set of static priorities.=
=20
As a developer you know *when* the tasks needs to complete, right? So then=
=20
the job is to pick a priority and hope that no other higher-prioritized=20
thread preempts you and cause you to miss your deadline.

And that is the problem with a complicated system, many tasks lead to an=20
intractable problem of getting all the priorities right, causing you no end=
=20
to the headache.

With SCHED_DEADLINE, you express your requirements directly as deadlines,=
=20
thus avoid that whole one-way mapping and instead the tasks relative=20
priority will adjust as the scheduler now has a _much_ more comprehensive=
=20
view of the requirements.

--=20
Henrik Austad

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljjMUkACgkQ6k5VT6v45lkg3gCfdwanURpyCnPINX0qp92CBkEm
MS8An3ewhAsSxJ1xTAjUaf7PZFKTqGrs
=DkL2
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
