From: Clark Williams <williams@redhat.com>
Subject: Re: Tweak Latency on Intel ATOM
Date: Thu, 11 Feb 2010 09:34:47 -0600
Message-ID: <20100211093447.3c0a97cd@torg>
References: <loom.20100209T081421-234@post.gmane.org>
	<20100210163818.7f54ec3a@torg>
	<4B73B7B5.4070509@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/L09lbNwDJvUbMy1Zdu/2py8"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Max =?ISO-8859-1?B?TfxsbGVy?= <mxmr@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab0BKPfC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2010 10:35:02 -0500
In-Reply-To: <4B73B7B5.4070509@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/L09lbNwDJvUbMy1Zdu/2py8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Feb 2010 08:54:29 +0100
Max M=FCller <mxmr@gmx.net> wrote:

> Clark Williams schrieb:
> > On Tue, 9 Feb 2010 07:41:58 +0000 (UTC)
> > Max Miller <mxmr@gmx.net> wrote:
> >
> >  =20
> >> Hello,
> >>
> >> im am using the PREEMPT-RT patch on linux 2.6.29.6. It runs on a MSI96=
5GSE
> >> industial board with Intel ATOM CPU (N270, 1,6GHz) and i945GSE Northbr=
idge.=20
> >>
> >> I got about 45=B5s as maximum and 13=B5s as average latency when hyper=
threading is
> >> disabled. With enabled Hyperthreading the maximum latency increses to =
about
> >> 100=B5s. I measured the latency with cyclictest.=20
> >>
> >> What can i do to get better maximum latency? Can I do somthing in the =
kernel
> >> configuration or are there some kernel bootoptions? Or is it still imp=
ossible
> >> with this CPU to get better results?
> >>
> >> Thanks in advance,
> >> Max Miller=20
> >>
> >>
> >>    =20
> >
> > Make sure you turn off any power management settings in the BIOS and
> > turn off the irqbalance and cpuspeed services on the Linux side.
> >
> > What cyclictest command are you using to measure latency?
> >
> > Clark
> >  =20
>=20
> I run cyclictest as follows:
>=20
> cyclictest -n -t3 -p99

You might want to try the new cyclictest option --smp (which is really
the options -t, -a -n) and I'd back the priority down to -p95 just to
keep out of the way of watchdog and migration threads. In general, when
I run it on a multi-core box I use:

	$ cyclictest --smp -m -p95 -d0

Lately on AMD boxes I use --numa, which makes calls into libnuma to
allocated memory on local nodes for the measurement threads.

If you want to get fancy and look at at the history of the run, you can
use the -h <n> option to keep a histogram of <n> buckets (1 bucket =3D=3D 1
microsecond).=20

>=20
> For generating additional system load i run (one to several instances):
>=20
> while true; do echo "blah" > /dev/null; done &
>=20
> Then i watch the max. latency from the thread with the highest priority.
> Sometimes i add the parameter '-h' to generate a history. In this=20
> history i can
> see that the most latency times are under 20=B5s, only  about 5ppm are=20
> worse than 30=B5s.
> Am i doing this correctly?

You're seeing some nice numbers there (any max latency under 100us is
pretty good).=20

I have a python program I've been developing named 'rteval' which kicks
off a kernel compile and a scheduler benchmark called 'hackbench', then
runs cyclictest with the histogram option. After the run it generates a
report on how well cyclictest did with the loads in place. If you're
interested, you can get rteval from my kernel.org git repo:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rteval.=
git

It's not 100% complete, but it's getting there.=20

>=20
>=20
> The only powersave setting in the BIOS is "Intel speedstep" which i=20
> disabled.
>=20
>=20
> I will check with disabled "irqbalance and cpuspeed services" disabled=20
> and will report later.
>=20
>=20
> What should the adequate max. latency on this system?
>=20
>=20

I'd say you're doing pretty good keeping under 50us. You might want to
try it under a heavier load than the shell script you've been running.
If you don't want to fool with rteval, try kicking off a kernel compile
in another window like this:

$ while true; do make -j4 clean bzImage modules; done

and then run cyclictest. A kernel compile with parallel jobs (-j) is a
good overall load of computation and I/O.


--Sig_/L09lbNwDJvUbMy1Zdu/2py8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkt0I5sACgkQHyuj/+TTEp3+4ACeOAbOVYlZmZLrYuq4D2Dsvfhi
tQAAnAk0B82FG0GybTdIt5MgbrLBClvB
=D6NU
-----END PGP SIGNATURE-----

--Sig_/L09lbNwDJvUbMy1Zdu/2py8--
