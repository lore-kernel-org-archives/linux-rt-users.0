From: Clark Williams <williams@redhat.com>
Subject: Re: Help regarding Cyclictest.
Date: Tue, 6 Jan 2015 15:26:49 -0600
Message-ID: <20150106152649.0cb27c34@sluggy>
References: <CAOZUVQzdrVL6vz5NaLfaXcSovOKNjE9M7Vi4QguVLaUyDDCdog@mail.gmail.com>
 <20141223122606.11f2ff27@sluggy>
 <CAOZUVQx+YEQu7_QBDqg-HNeM7B0OqyaPeW=V5uUQWrPMoa7c7w@mail.gmail.com>
 <CAOZUVQzxATsud4L8+Z7EFRTyp9Jhu5nNcS5TyLZxWDo46R+6Dg@mail.gmail.com>
 <20141228163640.2d50be80@sluggy>
 <CAOZUVQwOgcNkJz46E0rDy_8W-Po=cSkTLg2gf7sQc9XRNftUyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/jUC+soG_k/PFQch21bZFSQ3"; protocol="application/pgp-signature"
To: Ipsit Kumar <kumaripsit1@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932688AbbAFV06 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jan 2015 16:26:58 -0500
In-Reply-To: <CAOZUVQwOgcNkJz46E0rDy_8W-Po=cSkTLg2gf7sQc9XRNftUyw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/jUC+soG_k/PFQch21bZFSQ3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


On Fri, 2 Jan 2015 15:02:11 +0530
Ipsit Kumar <kumaripsit1@gmail.com> wrote:

> Hi sir,
> Good Afternoon.
> Thank you for your reply.
>=20
> I am facing some issues with cyclictest.
> Basically i am using this tool on ARM platform, specifically on TCI6614 e=
vm.
> I am seeing strange spike in the cyclictest result.
>=20
>=20
>=20
>=20
>=20
> *root # ./cyclictest -t1 -p80 -i 10000 -l 10000# /dev/cpu_dma_latency set
> to 0uspolicy: fifo: loadavg: 0.70 0.48 0.61 1/434 15283           T: 0
> (15226) P:80 I:10000 C:  10000 Min:      5 Act:    9 Avg:   17 Max:    57=
97*
>=20
> When I am plotting the Histogram, I see the latency to go beyond 3ms once.
> I am unable to figure out what is the reason behind this.
> Checked with the kernel configuration and found that the CPU Frequency
> scaling is Disabled.
> No power management features are enabled.
>=20
> It would be a great help, if you could point out something I am doing
> wrong.
>=20
> Thank you.

Sorry for the slow response time, but I've been swamped with things
here at work following the Christmas break.=20

First, I don't see anything offhand that you're doing wrong. What
version of the realtime kernel are you running?=20

I think your best bet may be to take this to the Linux Realtime users
mailing list (in CC).=20

To get a sense of where things are going wrong, you can run cyclictest
with the -b option, like this:

$ cyclictest -t1 -p80 -i 10000 -l 10000 -b 500

This will enable the ftrace system and will cause the event tracepoints
to be enabled. When a latency is measured greater than the specified
argument (in this case 500 microseconds), cyclictest will first stop
ftrace and will then exit. You can at that point use the trace-cmd
command to save off the trace buffers:

$ trace-cmd extract

This will generate the file trace.bin which is a binary
representation of the kernel trace buffers. You can then generate a
latency trace report using:

$ trace-cmd report -l

This will give you an idea of what code paths were taken prior to the
latency spike. From here it's a matter of figuring out what happened
and how to prevent it from happening.

>=20
> On Mon, Dec 29, 2014 at 4:06 AM, Clark Williams <williams@redhat.com> wro=
te:
>=20
> > You won't be able to use cyclictest to determine those. Cyclictest
> > measures scheduler latency (the amount of time from an event occurrence
> > to when a thread is scheduled because of that event). Scheduler latency
> > has interrupt latency and context switch time as components.
> >
> > Also, realize that interrupt latency and context switch time are going
> > to be close to constants, as well as very small components of the
> > overall scheduler latency. If you're going to measure those, you should
> > look at ftrace tracepoints or the 'perf' utility.
> >
> > On Wed, 24 Dec 2014 13:17:03 +0530
> > Ipsit Kumar <kumaripsit1@gmail.com> wrote:
> >
> > > Hello sir,
> > > Its really great to use this tool.
> > > I was trying to know the interrupt Latency and the context switch
> > latency.
> > > Would you like to give me pointer to trace those using cyclic test and
> > > the way to measure the performance using the the ARM performance coun=
ter
> > ?
> > >
> > > Thanks a lot for your help sir.
> > >
> > > On Wed, Dec 24, 2014 at 9:14 AM, Ipsit Kumar <kumaripsit1@gmail.com>
> > wrote:
> > >
> > > > Thanks a lot for your reply.
> > > >
> > > >
> > > >
> > > > On Tue, Dec 23, 2014 at 11:56 PM, Clark Williams <williams@redhat.c=
om>
> > > > wrote:
> > > >
> > > >> On Tue, 23 Dec 2014 15:52:18 +0530
> > > >> Ipsit Kumar <kumaripsit1@gmail.com> wrote:
> > > >>
> > > >> > hello sir,
> > > >> > I am using the cyclictest tool to do some latency test on my lin=
ux
> > rt
> > > >> > kernel.
> > > >> > I am unable to understand the statistics that are being printed.
> > > >> > I want to know what is min max and avg that are being printed ?
> > > >> > Would be a great help to hear from you sir.
> > > >> >
> > > >> > Thank you.
> > > >> >
> > > >> > --
> > > >> > Regards:
> > > >> > Ipsit Kumar Senapati
> > > >> > *.*
> > > >>
> > > >> Cyclictest measures what I call "scheduler latency". It measures t=
he
> > > >> time between when the program should wakeup and when it actually d=
oes.
> > > >> Some pseudo code:
> > > >>
> > > >>         t1 =3D clock_gettime()
> > > >>         while running
> > > >>                 clock_nanosleep(interval)
> > > >>                 t2 =3D clock_gettime()
> > > >>                 delta =3D t2 - (t1 + interval)
> > > >>                 t1 =3D t2
> > > >>
> > > >> So in a perfect world we would wakeup at time t1+interval, but of
> > > >> course we're not perfect and there's system overhead to take into
> > > >> account. The delta value is the scheduler latency.
> > > >>
> > > >> The min value printed out is the lowest scheduler latency recorded,
> > > >> while the max value is the largest scheduler latency recorded for a
> > > >> particular core, both reported in microseconds. The avg value is a
> > > >> running average of the delta values for a particular core.
> > > >>
> > > >> Clark
> > > >>
> > > >
> > > >
> > > >
> > > > --
> > > > Regards:
> > > > Ipsit Kumar Senapati
> > > > *.*
> > > >
> > >
> > >
> > >
> > > --
> > > Regards:
> > > Ipsit Kumar Senapati
> > > *.*
> >
>=20
>=20
>=20
> --=20
> Regards:
> Ipsit Kumar Senapati
> *.*

--Sig_/jUC+soG_k/PFQch21bZFSQ3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrFMeAAoJEEersVlSw9NzZv0QALos4qshuYejDcsmYFxtQOL5
nGeZdutmUShqn2DHwWgy8nKrdvTVCUOM+/S0eGSfo5yQrmgCKkloJmsXdxbOKLj6
SLecXvWz+UT7bh3LBHhyCOwf+Txb/Y9Q2F8dJ3q0yywnRYKnFBH8hQj3pj5iBFW7
LkIKaJaKQ+wyYUQTYySwasvv+hANMTm+4MBEiMltDJcKLn7jut67glRmvkAYnJfU
aQvLzenpVYncWcZdog5yM/vclZFilO3wPwpqYGTbM/8itpj7YjUcwvJbvzrBUSny
VgpkOBNrUbUShmuJBPKsqphnbd7HvYsvJDLbCwLqqBVqypAMo6nP479zMzIL9nWg
fKqQuy5VwdptyY+3VwZp3rsaocSdN5O4gzAaEIyuufc+tPxUafRTRdmAivEr/PMt
mcFUTh30H97zHUh2n1gd8CtkR06C4yFgZoB0wD5Wul+t0cNVEOyfQXEPIM+eUqA3
wN9kbD1TOyFnuClX+GuZ/vBKyj7f8RJAUEUYfup48VbGKvip28ff5PG0Rcvlxwtq
tatS84QVZ3v4NICMWDUV/K2kiRP92qIjJoNZN4Pjb5SKkkojuLyHIYRHBH863Ikh
DZQoEtciv0xfIP8QH2CAnGFOPTaoDj2dFp0ovCOIaGXC1f/zIh+6tpf+qSS7eVZo
B+CldT2ZbpI/VxoETydJ
=chKC
-----END PGP SIGNATURE-----

--Sig_/jUC+soG_k/PFQch21bZFSQ3--
