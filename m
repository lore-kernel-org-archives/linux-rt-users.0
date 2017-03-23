From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Thu, 23 Mar 2017 15:51:54 -0500
Message-ID: <20170323205154.GP10423@jcartwri.amer.corp.natinst.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
 <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
 <20170322110116.4b14dafd@vmware.local.home>
 <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
 <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
 <7b1ffee6-1f78-7b9f-206e-27a9b6cd967f@st.com>
 <20170323102649.5zapjhvsuvu53b2h@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Cc: Lionel DEBIEVE <lionel.debieve@st.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323102649.5zapjhvsuvu53b2h@dell>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 10:26:49AM +0000, Lee Jones wrote:
> On Thu, 23 Mar 2017, Lionel DEBIEVE wrote:
>=20
> > On 03/22/2017 07:47 PM, Julia Cartwright wrote:
> > > On Wed, Mar 22, 2017 at 01:30:12PM -0500, Grygorii Strashko wrote:
> > >> On 03/22/2017 01:01 PM, Steven Rostedt wrote:
> > >>> On Wed, 22 Mar 2017 12:37:59 -0500
> > >>> Julia Cartwright <julia@ni.com> wrote:
> > >>>
> > >>>> Which kernel were you testing on, here?  From what I can tell, this
> > >>>> should have been fixed with Thomas's commit:
> > >>>>
> > >>>>     2a1d3ab8986d ("genirq: Handle force threading of irqs with pri=
mary
> > >>>> and thread handler")
> > >>> Thanks Julia for looking into this. I just looked at the code, and =
saw
> > >>> that it does very little with the lock held, and was fine with the
> > >>> conversion. But if that interrupt handler should be in a thread, we
> > >>> should see if that's the issue first.
> > >>
> > >> It will not be threaded because there are IRQF_ONESHOT used.
> > >>
> > >> 	ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> > >> 					sti_mbox_irq_handler,
> > >> 					sti_mbox_thread_handler,
> > >> 					IRQF_ONESHOT, mdev->name, mdev);
> > > Indeed.  I had skipped over this important detail when I was skimming
> > > through the code.
> > >
> > > Thanks for clarifying!
> > >
> > > Is IRQF_ONESHOT really necessary for this device?  The primary handler
> > > invokes sti_mbox_disable_channel() on the interrupting channel, which=
 I
> > > would hope would acquiesce the pending interrupt at the device-level?
>=20
> Not sure.  This part of the code is remanent from when I re-wrote it.
>=20
> What is the alternative?

If, on the completed execution of the registered primary handler, you
can ensure that the device is no longer asserting an interrupt to the
connected irq chip, then the IRQF_ONESHOT isn't necessary, because it's
safe for the irq core to unmask the interrupt after the primary handler
runs.

It appears that it might be able to make this guarantee, if that's what
sti_mbox_disable_channel() is doing.

> NB: What does 'acquiesce' mean in this context?  Is that a typo?

I mean 'acquiesce' to mean what I mention before: prevent the device
=66rom asserting the interrupt.  Perhaps it's a uncommon use of the word.

> > > Also, as written there are num_inst reads of STI_IRQ_VAL_OFFSET in the
> > > primary handler, which seems inefficient...(unless of course reading
> > > incurs side effects, here).
>
> Inefficient in what respect?

I've since looked again and realized that the register base is
recalculated based on 'instance', so disregard this comment.

   Julia

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljUNWoACgkQjNrC4UVN
dG8DmQf/UI+Ito7fwOvlfFhgib3eA/pNa9Q93W8eyM21SSQGJ2/ifYJlTzgY9lq3
Ryp8B1VKWBN1BTyKiRcbWQns4ZX2hWOlaeB1jewlRtI73BmbmA1b2GrFyfVwqP3s
WuLEXAhSHKWjf9WkWFPA/Jq/mQ2HQg0A/Y+4s3mSDnQ8yW0FVMPoj+iNIdXCcpxm
Ksl/MbC+3QcFVeir6X0rrPYdmmBtI8aHWLjCEHvjnvNgdd62DP2vHfMKHnQFl/2u
srsyKcGQoNsazVq2/uMtOR7d3HblbiuhPDkHAS/l4laklL/U5M4Wc52S77wKnCPe
yBeKwvJAMlnz8vH4xgbPPgnPzq+y4g==
=J4ft
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
