From: "David Bahi" <dbahi@novell.com>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Tue, 11 Sep 2007 13:16:28 -0600
Message-ID: <46E6952C0200006C00018312@sinclair.provo.novell.com>
References: <46E684F8020000F900010523@sinclair.provo.novell.com>
 <46E6952C0200006C00018312@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartBD9A109C.1__="
Cc: <linux-rt-users@vger.kernel.org>
To: <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:9709 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763355AbXIKTQj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2007 15:16:39 -0400
In-Reply-To: <46E6952C0200006C00018312@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__PartBD9A109C.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 2007-09-11 at 11:06 -0700, Daniel Walker wrote:
> On Tue, 2007-09-11 at 11:39 -0600, David Bahi wrote:
> > On Tue, 2007-09-11 at 02:10 +0000, David Bahi wrote:
> > > trying to get a crashdump in a clean -rt series kernel which =
hardlocks
> > > on the ltp openposix conformance interfaces sched_yield 1-1.test ...
> > >=20
> > > i was trying with nmi_watchdog =3D 1 (x86_64 machine, dual cpu, quad =
core,
> > > HT enabled) and it would report NMI LOCKUP on presentation of the =
login
> > > prompt - no chance to run the test.
> > >=20
> > >                            linux-2.6.22.1-rt9   linux-2.6.23-rc4-rt1
> > > lockup on openposix=20
> > > sched_yield test occurs            yes                  yes
> > >=20
> > > crash on login prompt
> > > with nmi_watchdog=3D1                yes*                 yes*
> > >=20
> > >   (*) console logs attached
> > >=20
> > >=20
> >=20
> > fyi 2.6.23-rc4 w/o -rt passes the LTP openposix sched_yeild test and
> > does *not* crash (NMI LOCKUP) if nmi_watchdog=3D1 is a boot arg.
> >=20
> > so these don't seem to be related to what i'm seeing at least:
> >=20
> >   http://thread.gmane.org/gmane.linux.kernel/577449
>=20
> The patches above are related to nmi_watchdog=3D2 . Is the same lock up
> detected with nmi_watchdog=3D2 ?

sorry to pull your work in to this thread wrongly Daniel.  my point was
really that the 23-rc4 kernel does not experience either failure for me
and that the current work being done for nmi_watchdog is unrelated so
this still needs attention.

no hang with nmi_watchdog=3D2 in 23-rc4 (non -rt)
no hang with nmi_watchdog=3D2 in 23-rc4-rt1

test box has dual quad xenons - not a core duo - so the coreduo_ed_ops
work around isn't needed, right?

and the endflag=3D1 isn't needed since x86_64 sets this in both code paths
(inefficiently).

	if (!atomic_read(&nmi_active)) {
		kfree(counts);
		atomic_set(&nmi_active, -1);
		endflag =3D 1;
		return -1;
	}
	endflag =3D 1;
	printk("OK.\n");


finally, i didn't try nmi_watchdog=3D2 earlier because the
Documentation/nmi_watchdog.txt file says it's not a useful setting for
x86_64.  quote:

  For x86-64, the needed APIC is always compiled in, and the NMI
  watchdog is always enabled with I/O-APIC mode (nmi_watchdog=3D1).  =20
  Currently, local APIC mode (nmi_watchdog=3D2) does not work on x86-64.

Is this no longer true?  My experience with nmi_watchdog=3D2 and this LTP
openposix sched_yeild 1-1.test is that this test hardlocks the host and
that no watchdog is triggered with this setting.

db




--=__PartBD9A109C.1__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCRzV1ajNIMjhKSFlhekxhUVJBdC9xQUtDTlk2MFlWaVhOVFkxUzlOOUlH
Y1ZROEkrMW9nQ2RFbnVlCnFHY1RneE5xM1lPYnJ3QnUxbWM2NjdNPQo9eTFqVAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__PartBD9A109C.1__=--
