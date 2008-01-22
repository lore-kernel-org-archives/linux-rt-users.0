From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 18:20:03 +0530
Message-ID: <20080122125003.GA9929@linux.vnet.ibm.com>
References: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET> <20080122115436.GC8660@linux.vnet.ibm.com> <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:39220 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYAVMuG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 07:50:06 -0500
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0MCnYYU027920
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 23:49:34 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0MCo411639184
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 23:50:04 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m0MCo5vQ020321
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 23:50:05 +1100
Content-Disposition: inline
In-Reply-To: <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Lampersperger Andreas <lampersperger.andreas@heidenhain.de> [2008-01-=
22 13:14:40]:

> No, there is no BIOS option which indicates HPET support. But the
> BIOS on my system is IMHO very very bad. It knows nothing about the
> features on the board. Is ist crucial to have here BIOS support? Or
> can these features be enabled by e.g. boot parameters?
Hi,
afaik, there needs to be h/w support enabled [via bios] as hpet is a ha=
rdware feature.
Without h/w enablement, the kernel can't do much.



> -----Urspr=FCngliche Nachricht-----
> Von: Chirag Jog [mailto:chirag@linux.vnet.ibm.com]=20
> Gesendet: Dienstag, 22. Januar 2008 12:55
> An: Lampersperger Andreas
> Cc: linux-rt-users@vger.kernel.org
> Betreff: Re: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
>=20
> * Lampersperger Andreas <lampersperger.andreas@heidenhain.de> [2008-0=
1-22 12:09:42]:
>=20
> > Hello,
> >=20
> > does anyone have a hint how to enable High resolution timers on my=20
> > system (with a Intel ICH2 (which has afaik 8254 Timers). Is this=20
> > hardware not enough for hr-timers?
> Check your BIOS settings.
> If your h/w supports HPET, there should be an option in the BIOS to t=
urn it on.
>=20
> <snip>
> --
> Cheers,
> Chirag Jog
>=20
>=20
> ---------------------------------------------------------------------=
----------------------------------
> Registergericht: Traunstein / Code of Register HRB 275 Sitz / Head Of=
fice: Traunreut
> Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Bur=
khard
> Geschaeftsfuehrung / Managing Director: Thomas Sesselmann
>=20

--=20
Cheers,
Chirag Jog
