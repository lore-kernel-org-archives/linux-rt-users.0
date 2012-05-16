From: Clark Williams <williams@redhat.com>
Subject: Re: good load / stress suite?
Date: Wed, 16 May 2012 10:55:01 -0500
Message-ID: <20120516105501.17018110@redhat.com>
References: <4FB2E1DD.7020203@gmto.org>
	<1337133337.6724.24.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/38F6UM=FwPibx5zSxT6cSay"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Matthieu Bec <mbec@gmto.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab2EPPzJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2012 11:55:09 -0400
In-Reply-To: <1337133337.6724.24.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/38F6UM=FwPibx5zSxT6cSay
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 May 2012 21:55:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2012-05-15 at 16:08 -0700, Matthieu Bec wrote:
> > Hello all,
> >=20
> > I was wondering what people used to check RT_PREEMPT behavior under=20
> > load/stress?
>=20
> There is a test suite that Red Hat uses called rt-eval (I believe).
> Clark can give you more info on that.

It's called rteval and I have a git tree here:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rteval.git

It's basically some python scripting to do much of what Steven describes
below. When it starts up it kicks off a kernel make with 2* the number
of available processors (make -j <n*2>) and runs hackbench, both in
loop. Then it kicks off cyclictest to measure the system latency under
load.=20

I usually run it like this:

	$ sudo rteval --duration=3D12h

At the end it summarizes the results of the run.

>=20
> >=20
> > I'm trying to test the accuracy of my timers and have a test where I=20
> > setup a kernel module with an hr-timer flipping RTS bit on serial COM0=
=20
> > periodically, which I can look on an oscilloscope. the scope triggers o=
n=20
> > rising edge, I call jitter what shows on the falling side:
> > under no specific load I get ~ 10 us (worst case waiting a long time)
> >=20
> >=20
> > My initial idea for stressing the system was to compile a kernel, make=
=20
> > -j 8 (#cores) that I thought would exercise CPU and IO if anything. As=
=20
> > it happens, it's "mostly good" but I do get occasional (but repeatable)=
=20
> > wild excursions (>100us)
>=20
> The tests I do is the following:
>=20
> I run "cyclictest -n -p 80 -t -i 250" then in another window I run a
> kernel compile using distcc (to stress the network as well) with make
> -j40, it basically does:
>=20
> while :; make clean; make -j40; done
>=20
> Then I also run hackbench (written by Rusty Russell), with:
>=20
> while :; hackbench 50 ; done
>=20
> I run the above on a single machine, while on another machine I run
> ktest against the -rt kernel to test different configs (with and without
> PREEMPT_RT enabled and such). I do this for both i386 and x86_64.
>=20
>=20
> >=20
> > Looking around, I found a tool called 'stress' -=20
> > http://weather.ou.edu/~apw/projects/stress/
> > Under these new conditions, the system behaves really well again ~20 us=
=20
> > stable all the way.
> >=20
> > So both tests give different result, I'm not sure which to trust.
> > I was thinking maybe there is some weird interaction with the kernel an=
d=20
> > building the kernel that make the 'bad' test invalid?
> >=20
> > I have RT_PREEMPT 3.0.18-rt34 SMP x86_64
> >=20
>=20
> Now, I run the above stress tests that I mentioned for several hours
> before I release a stable kernel. I run this on a 2.6GHz xeon core2, and
> I may hit at most 70us latency with cyclictest. That's a high, it
> usually stays below 50us. We consider >100us on this type of hardware a
> bug which needs to be fixed.
>=20
> -- Steve
>=20
>=20

--Sig_/38F6UM=FwPibx5zSxT6cSay
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+zzdUACgkQHyuj/+TTEp0i1ACgjDeJj7B7fx+U9vrFMxjG4ZzQ
VfwAoMm3lmNGlO65caHnImmJyIYq5hVa
=V4ys
-----END PGP SIGNATURE-----

--Sig_/38F6UM=FwPibx5zSxT6cSay--
