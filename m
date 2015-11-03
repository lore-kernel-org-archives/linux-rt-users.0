From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Tue, 3 Nov 2015 20:42:46 +0100
Message-ID: <20151103194246.GA19824@sisyphus.home.austad.us>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us>
 <5638F239.1030804@ni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: linux-rt-users@vger.kernel.org, josh.cartwright@ni.com
To: Jonathan David <jonathan.david@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33641 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbbKCTmv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2015 14:42:51 -0500
Received: by wmeg8 with SMTP id g8so93490392wme.0
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2015 11:42:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5638F239.1030804@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 11:43:21AM -0600, Jonathan David wrote:
> On 10/22/2015 12:59 AM, Henrik Austad wrote:
> >On Wed, Oct 21, 2015 at 05:07:48PM -0500, Jonathan David wrote:
> >>There is a noticeable impact on determinism when a large number of
> >>writes are flushed. Writes to the hardware registers are sent across
> >>the PCI bus and take a significant amount of time to complete after
> >>a flush, which causes high priority tasks (including interrupts) to
> >>be delayed.
> >
> >Do you see this in the entire system, or on the core where the write was
> >triggered?
>=20
> Only on the core where the writes are issued.

Ok, not a global freeze then :)

> >>Adding a delay after long series of writes gives them time to
> >>complete, and for higher priority tasks to run unimpeded.
> >
> >Aren't we running with threaded interrupts?
> >
> >What happens to the thread(s) pushing data to the network?
> >What about xmit-buffer once it is full? Which thread will block on send =
or
> >have its sk_buff dropped?
>=20
> All of this is totally irrelevant to the problem we are seeing.

If this is irrelevant, why hack at the network-driver, hmm?

> The e1000x driver itself is not responsible for the delay here.=20

=2E.. then why hack the network-driver?

> The issue is with PCI where issuing a large number of MMIO writes=20
> followed by a read (to force said writes to execute) will stall the CPU.=
=20
> When the CPU is stalled, no interrupts are serviced, including the local=
=20
> apic timer interrupt, which was responsible for waking up cyclictest.=20
> This behavior was observed within traces gathered from cyclictest with=20
> ftrace enabled.

So you get bogged down with interrupts disabled; so back to my question,=20
are we not running with threaded interrupts? What exactly are we triggering=
=20
here?

> >I'm not sure if adding random delay and giving an unpredictable impact on
> >completely random threads is the best way to solve this..
>=20
> Agreed, we know that this is a hack. Do you have any better solutions?

- Send less data over the network ;)
- affine network interrupts to a non-rt core and place rt-tasks on cores=20
  shielded from interrupts (why are you not doing this already?)
- Look at the PCI driver and add breathers there (e.g. after X MMIO=20
  writes, enable interrupts, disable interrupts and continue)

I'm sure adding random delay to the network-driver solves your particular=
=20
problem, and that is fine, but I fear that you'll just end up opening a=20
nasty can of worms. Debugging this when (not if) it fails is not going to=
=20
be very pretty methinks.

Anyhow, I'm not about to tell you what you can or cannot do, just that I=20
see some rather nasty bumps in the road ahead of you with the current=20
solution.

--=20
Henrik Austad

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlY5DjYACgkQ6k5VT6v45lncxgCbB/dcwFiR3TsZhfm0jj7quY9T
rA8AniXMdbfWw+wmq+6H5HVtTReyzPZ1
=Nz7N
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
