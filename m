From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: IBM test question
Date: Fri, 8 Feb 2008 10:06:03 +0100
Message-ID: <20080208100603.0d825e1d@frecb000686.frec.bull.fr>
References: <47AB0C53.3050703@parrot.com>
	<20080207163440.174181f2@frecb000686.frec.bull.fr>
	<47AB3189.7080505@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35542 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759694AbYBHJGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2008 04:06:02 -0500
In-Reply-To: <47AB3189.7080505@parrot.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 07 Feb 2008 17:27:53 +0100 Matthieu CASTET <matthieu.castet@par=
rot.com> wrote:

> Hi S=C3=A9bastien,
>=20
> S=C3=A9bastien Dugu=C3=A9 wrote:
> >   Hello Matthieu,
> >=20
> > On Thu, 07 Feb 2008 14:49:07 +0100 Matthieu CASTET <matthieu.castet=
@parrot.com> wrote:
> >=20
> >> hi,
> >>
> >> I am trying to use some IBM rt test on arm.
> >>
> >>
> >> I define atomic_add to
> >> assert(i=3D=3D1);
> >> return ++(v->counter);
> >>
> >> That's a bit ugly, but that should work for my need.
> >=20
> >   That would be the poor man's atomic_inc() and not sure it really =
does
> > what you think it does ;). Just for the record, pre-armv6 cores hav=
e no support
> > for userland atomic operations (aside from swapping).
> I can, if I use a kernel helper :) [1]

  Yep, but much slower.

>=20
> BTW what should do the atomic_add.
> On i386 it does the atomic add and return the value in memory before =
the=20
> add (Exchange and Add).

  Looking at the kernel and glibc, i386's atomic_add seems to be a void
function (unless I missed something).

> On powerpc, it seems to do the atomic add and return the new value.

  Yes, both for kernel and glibc implementations.

>=20
>=20
> >=20
> >> But I have a problem with the sched_latency test.
> >> On my platform the thread creation is quite slow (25ms), so with t=
he=20
> >> default value, I got a PERIOD MISSED.
> >=20
> >   The IBM RT tests have been integrated into the LTP and I recently
> > sent some updates to those testcases. Notably one the patches did i=
mprove
> > the thread starting time. Other patches did touch this particular t=
est too.
> >=20
> >   Could you try the latest release (from LTP) and tell me if things
> > have improved for you.
> Ok I will try them.
> >=20
> >   Also, the PASS/FAIL criteria are quite arbitrary. They happen to =
be fine
> > for most recent PC-class hardware but surely not for embedded syste=
ms and
> > should be tuned according to your RT requirements.
> Yes I saw that.
>=20
>=20
> >=20
> >> Also my cpu is quite slow (compared to last intel core or powerpc)=
=2E For=20
> >> example a sched_jitter run take 6s.
> >=20
> >   Ouch! What's your CPU (core type, clock speed)?
> Arm926 ~104.65 Mhz

  ARMv5 core then. You'll need the kernel helper then to be trully atom=
ic.

  Sebastien.
