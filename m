From: "Lampersperger Andreas" <lampersperger.andreas@heidenhain.de>
Subject: AW: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 13:14:40 +0100
Message-ID: <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET>
References: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET> <20080122115436.GC8660@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: "Chirag Jog" <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.heidenhain.lt ([194.25.102.130]:28262 "EHLO mx02.jhcn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYAVMPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 07:15:04 -0500
In-Reply-To: <20080122115436.GC8660@linux.vnet.ibm.com>
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

No, there is no BIOS option which indicates HPET support. But the
BIOS on my system is IMHO very very bad. It knows nothing about the
features on the board. Is ist crucial to have here BIOS support? Or
can these features be enabled by e.g. boot parameters?
=20

-----Urspr=FCngliche Nachricht-----
Von: Chirag Jog [mailto:chirag@linux.vnet.ibm.com]=20
Gesendet: Dienstag, 22. Januar 2008 12:55
An: Lampersperger Andreas
Cc: linux-rt-users@vger.kernel.org
Betreff: Re: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2

* Lampersperger Andreas <lampersperger.andreas@heidenhain.de> [2008-01-=
22 12:09:42]:

> Hello,
>=20
> does anyone have a hint how to enable High resolution timers on my=20
> system (with a Intel ICH2 (which has afaik 8254 Timers). Is this=20
> hardware not enough for hr-timers?
Check your BIOS settings.
If your h/w supports HPET, there should be an option in the BIOS to tur=
n it on.

<snip>
--
Cheers,
Chirag Jog


-----------------------------------------------------------------------=
--------------------------------
Registergericht: Traunstein / Code of Register HRB 275 Sitz / Head Offi=
ce: Traunreut
Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Burkh=
ard
Geschaeftsfuehrung / Managing Director: Thomas Sesselmann
