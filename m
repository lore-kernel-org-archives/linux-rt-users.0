From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 13:47:33 -0500
Message-ID: <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
 <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
 <20170322110116.4b14dafd@vmware.local.home>
 <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Lionel Debieve <lionel.debieve@st.com>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:35692 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934855AbdCVSrp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 14:47:45 -0400
Content-Disposition: inline
In-Reply-To: <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 01:30:12PM -0500, Grygorii Strashko wrote:
>=20
> On 03/22/2017 01:01 PM, Steven Rostedt wrote:
> > On Wed, 22 Mar 2017 12:37:59 -0500
> > Julia Cartwright <julia@ni.com> wrote:
> >=20
> > > Which kernel were you testing on, here?  From what I can tell, this
> > > should have been fixed with Thomas's commit:
> > >=20
> > >    2a1d3ab8986d ("genirq: Handle force threading of irqs with primary
> > > and thread handler")
> >=20
> > Thanks Julia for looking into this. I just looked at the code, and saw
> > that it does very little with the lock held, and was fine with the
> > conversion. But if that interrupt handler should be in a thread, we
> > should see if that's the issue first.
>=20
>=20
> It will not be threaded because there are IRQF_ONESHOT used.
>=20
> 	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> 					sti_mbox_irq_handler,
> 					sti_mbox_thread_handler,
> 					IRQF_ONESHOT, mdev->name, mdev);

Indeed.  I had skipped over this important detail when I was skimming
through the code.

Thanks for clarifying!

Is IRQF_ONESHOT really necessary for this device?  The primary handler
invokes sti_mbox_disable_channel() on the interrupting channel, which I
would hope would acquiesce the pending interrupt at the device-level?

Also, as written there are num_inst reads of STI_IRQ_VAL_OFFSET in the
primary handler, which seems inefficient...(unless of course reading
incurs side effects, here).

   Julia

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljSxsIACgkQjNrC4UVN
dG+ZBQf+MNhCZIreNw8H3U5vsSJfYTF1+/ddkeJ8hCINX97yp9Xjf6boOQy0Tstg
DrLQle1L8hKNevqeexaUaPAfsdy1Q7KHGIGCEUKNeqovp+ip17zi4zllstSOY9BZ
swIT9y7TE/h4cLXRtubEq3NKapXQolwXJ3ZLY4j3OnzcxQPCf+1Z8QmJXExSUOE9
DiCYDtmOnwo/G2/CKG5qOAAveUS0gEjlyrP32klQDfEuwc2ZzRqVhimNkkcbegeF
zklPaYuNeSaNtKR4WPiGRBhH6+Y/0H11xsMwMuqvdw3vz3p3p1S0ECaOkpAs1HFy
Wo3DXi/VMq9vCC+uCjmBFqKPAHvcgw==
=EySp
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
