From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Fri, 6 Nov 2015 06:53:49 +0100
Message-ID: <20151106055349.GA10665@icarus.home.austad.us>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us>
 <5638F239.1030804@ni.com>
 <20151103194246.GA19824@sisyphus.home.austad.us>
 <563930CF.9090800@ni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: linux-rt-users@vger.kernel.org, josh.cartwright@ni.com
To: Jonathan David <jonathan.david@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37398 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbKFFxy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Nov 2015 00:53:54 -0500
Received: by wmll128 with SMTP id l128so31772285wml.0
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2015 21:53:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <563930CF.9090800@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 04:10:23PM -0600, Jonathan David wrote:
> On 11/03/2015 01:42 PM, Henrik Austad wrote:
> >On Tue, Nov 03, 2015 at 11:43:21AM -0600, Jonathan David wrote:
> >>On 10/22/2015 12:59 AM, Henrik Austad wrote:
>=20
> >>>>Adding a delay after long series of writes gives them time to
> >>>>complete, and for higher priority tasks to run unimpeded.
> >>>
> >>>Aren't we running with threaded interrupts?
> >>>
> >>>What happens to the thread(s) pushing data to the network?
> >>>What about xmit-buffer once it is full? Which thread will block on sen=
d or
> >>>have its sk_buff dropped?
> >>
> >>All of this is totally irrelevant to the problem we are seeing.
> >
> >If this is irrelevant, why hack at the network-driver, hmm?
>=20
> It is relevant to the network driver, as this is where the symptoms were
> discovered; however, it has no relation to the packet delivery path. This=
 is
> related purely to link configuration.

I was under the impression that a PCI link configuration/training was down=
=20
to speed etc, not how many MMIO read/writes it could do. Then again, a lot=
=20
of this stuff is pure (black) magic.

> >>The e1000x driver itself is not responsible for the delay here.
> >
> >... then why hack the network-driver?
>=20
> Lack of better known options.
>=20
> >>The issue is with PCI where issuing a large number of MMIO writes
> >>followed by a read (to force said writes to execute) will stall the CPU.
> >>When the CPU is stalled, no interrupts are serviced, including the local
> >>apic timer interrupt, which was responsible for waking up cyclictest.
> >>This behavior was observed within traces gathered from cyclictest with
> >>ftrace enabled.
> >
> >So you get bogged down with interrupts disabled;
>=20
> No, interrupts are entirely enabled while the PCI MMIO writes/read are
> issued; but the local apic timer still arrives late, presumably because t=
he
> CPU is waiting to complete whatever writes remain in the buffer.

Heh, strange, is the interrupt signal itself delivered late as well, or=20
just the handling of it?

> I think this might be the root of our miscommunication. You are asking go=
od
> questions about threaded interrupts, etc, but it isn't clear how they are
> related to the specific problem we are seeing.

Perhaps a trace of the problem could be shared?

A full function-trace with irq-events and timer-events would be appreciated=
=20
:)

--=20
Henrik Austad

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlY8QG0ACgkQ6k5VT6v45llZcwCdF3J+t1zkAOHPnhRicrIP8i3d
ixIAoLxVXjFWgin5/506gUbZg7Xhb3Xg
=WwWv
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
