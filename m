From: =?ISO-8859-2?Q?P=E1sztor_Szil=E1rd?= <szilard.pasztor@evosoft.com>
Subject: Mysterious delay (interrupt?)
Date: Mon, 25 Jun 2007 09:55:38 +0200
Message-ID: <20070625095538.6b642a7b.szilard.pasztor@evosoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__25_Jun_2007_09_55_38_+0200_vkTVjcZex023B4es"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from evo2.evosoft.com ([195.228.139.85]:55771 "HELO evo2.evosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750781AbXFYKcm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2007 06:32:42 -0400
Received: from EVOXCH1.evosoft.com (unknown [10.10.110.13])
	by mail2.evosoft.hu (Postfix) with ESMTP id A4D8A1BB1C1A
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2007 10:11:31 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Signature=_Mon__25_Jun_2007_09_55_38_+0200_vkTVjcZex023B4es
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

  I'm using the RT patch for a project where I have to communicate over
ethernet and 8 serial ports (via a pci multi-interface card). I must gain C=
PU
time for a while in every millisecond which is my periodic cycle time.
  Most things seem ok, but for some strange reason, 2-3 ms latencies show up
rarely about once out of 200000 cycle runs or so when the machine is under
load, mostly of interrupts.
  It took a while for me to track it down but finally found that this laten=
cy
is not related to a slower part of my cycle, but is caused indirectly by an
ioctl() call in the cycle with TIOCMGET read command on the serial ports th=
at
translates to a driver-dependent get_mctrl call inside the kernel. If the c=
all
is in, the delay shows up elsewhere every time, spread across the cycle (fo=
und
that with extensive timestamping) so I'm thinking of some interrupt kicking=
 in
a while after the ioctl() call. Commenting the call out eliminates the prob=
lem
completely, but it unfortunately eliminates the functionality of my code as
well since things depend on the line states so I cannot spare the read of t=
he
modem status register.

I'm currently using 2.6.19-rt15 but this problem shows up with every kernel
and patch version I've tried (starting from 2.6.16 to 2.6.20) and I'm not
really able to test newer versions currently because the server is under he=
avy
use. However, I suspect that this problem is not an easy sight to come by a=
nd
probably still persists. Of course my task is running with the highest
real-time priority. The lower level serial driver that is in use is
drivers/serial/8250.c.

  I'm afraid I don't have a deep enough insight to track it down any furthe=
r,
so I thought I'd try if this description rings a bell with more knowledgeab=
le
persons.

Any help would be greatly appreciated.

s.

  -------------------------------------------------------------------------=
---
  |  Hard work often pays off after time, but laziness always pays off now.=
  |
  -------------------------------------------------------------------------=
---

--Signature=_Mon__25_Jun_2007_09_55_38_+0200_vkTVjcZex023B4es
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGf3T6xoToz8jNC5ARAiZrAKDD1RFkhoOkVh4EGkY9/3v3HM6ZYwCfeASY
FXefamzk6gSvJHm/L8PcyY8=
=m9yu
-----END PGP SIGNATURE-----

--Signature=_Mon__25_Jun_2007_09_55_38_+0200_vkTVjcZex023B4es--
