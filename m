From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Thu, 27 Aug 2009 23:33:57 -0400
Message-ID: <4A975025.8030500@novell.com>
References: <1251282598.3514.20.camel@raz>  <alpine.DEB.1.10.0908260943090.9924@gentwo.org>  <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>  <1251300625.18584.18.camel@twins>  <alpine.DEB.1.10.0908261136590.9933@gentwo.org>  <1251302598.18584.31.camel@twins>  <alpine.DEB.1.10.0908261211340.9933@gentwo.org>  <20090826180407.GA13632@elte.hu>  <alpine.DEB.1.10.0908261509580.9933@gentwo.org>  <20090826193252.GA14721@elte.hu>  <alpine.DEB.1.10.0908261627110.5554@gentwo.org>  <20090826135041.e6169d18.akpm@linux-foundation.org>  <4A95A5EE.90400@nortel.com> <1251322663.3882.48.camel@raz> <4A96B997.1070001@nortel.com> <alpine.DEB.1.10.0908271257270.17470@gentwo.org> <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain> <4A97071F.5070804@novell.com> <4A973DAE.4020508@redh
 at.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93B83232ABC25043A2695632"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christoph Lameter <cl@linux-foundation.org>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <4A973DAE.4020508@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93B83232ABC25043A2695632
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rik,

Rik van Riel wrote:
> Gregory Haskins wrote:
>=20
>> 2) Modify FIFO so that it disables tick by default...update accounting=

>> info at next reschedule event.
>=20
> I like it.  The only thing to watch out for is that
> events that wake up higher-priority FIFO tasks do
> not get deferred :)
>=20

Yeah, agreed.  My (potentially half-baked) proposal should work at least
from a pure scheduling perspective since FIFO technically does not
reschedule based on a tick, and wakeups/migrations should still work
bidirectionally with existing scheduler policies.

However, and to what I believe is your point: its not entirely clear to
me what impact, if any, there would be w.r.t. any _other_ events that
may be driven off of the scheduler tick (i.e. events other than
scheduling policies, like timeslice expiration, etc).  Perhaps someone
else like Thomas, Ingo, or Peter have some input here.

I guess the specific question to ask is: Does the scheduler tick code
have any role other than timeslice policies and updating accounting
information?  Examples would include timer-expiry, for instance.  I
would think most of this logic is handled by finer grained components
like HRT, but I am admittedly ignorant of the actual timer voodoo ;)

Kind Regards,
-Greg


--------------enig93B83232ABC25043A2695632
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqXUCUACgkQP5K2CMvXmqEDOgCeOkTQln9Gx/bcBXM8iRZ5faAF
dU4An086DWdCFVYr6T0wocVmNMDryvKH
=4Xge
-----END PGP SIGNATURE-----

--------------enig93B83232ABC25043A2695632--
