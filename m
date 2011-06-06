From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 22:35:43 +0200
Message-ID: <4DED3A1F.2030605@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de> <20110605222954.GA13340@opentech.at> <4DEC0A7F.7090207@web.de> <20110606002142.GA32539@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig44F9A6CE29FD9891DEF14F02"
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:45925 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1FFUg1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 16:36:27 -0400
In-Reply-To: <20110606002142.GA32539@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44F9A6CE29FD9891DEF14F02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-06 02:21, Nicholas Mc Guire wrote:
>>
>> There are good examples - in the RT domain - for both models. Sharing =
a
>> device does not necessarily mean making things dynamic or even
>> unpredictable.
>>
>=20
> then I maybe dont get the "exclusive" issue you note - if the highest p=
riority task does not have exclusive access - assuming that there is not =
contention free sharing - how can you give guarantees ? I can imagin shar=
ing if the highest priority has unconstraint access to the reource and an=
y other access is controled by the highest priority task (i.e. queue repl=
ication like ARINC 653 queueing ports) but if you have multiple instances=
 of different priority accessing a resource I don't see how this could be=
 done while giving guarantees on timing (assuming that it is not possible=
 to provide all access as physically atomic instructions)

Just the classic way: If there is a critical path while accessing the
device, make it exclusive via locking. If the length of the critical
path is controllable by a low-prio task, you either need to include that
workload in the WCET estimation or you need to apply some limits/quotas
to prevent unbounded path lengths.

>=20
> Do you have an example at hand of such a shared I/O device scheme that =
can guarantee rt timing ?

Let's make it simple: What prevents sharing the process image exposed by
an abstract I/O devices in form of a MMIO region between multiple user
processes? That you may not rely on the hardware to avoid that processes
tap on each other's shoes? But that can be sorted out by privileged
driver that enforces access rules, dispatches variable update events to
listeners or ensures that only consistent modifications are transferred
to the physical process.

Where do we loose RT here?

Jan


--------------enig44F9A6CE29FD9891DEF14F02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3tOh8ACgkQitSsb3rl5xRDjACfVseExb9OeYYLg55CjI6huadM
huQAnjpY9wlCM4HzKq8gwPqMXGpJmmR9
=ggab
-----END PGP SIGNATURE-----

--------------enig44F9A6CE29FD9891DEF14F02--
