From: "David Bahi" <dbahi@novell.com>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Tue, 11 Sep 2007 14:55:45 -0600
Message-ID: <46E6AC710200006C00018332@sinclair.provo.novell.com>
References: <46E699F80200008100010574@sinclair.provo.novell.com>
 <46E6AC710200006C00018332@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part082FA4C1.1__="
Cc: <linux-rt-users@vger.kernel.org>
To: <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:13129 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965631AbXIKUz4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2007 16:55:56 -0400
In-Reply-To: <46E6AC710200006C00018332@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__Part082FA4C1.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 2007-09-11 at 12:36 -0700, Daniel Walker wrote:
> On Tue, 2007-09-11 at 13:16 -0600, David Bahi wrote:
...snip...
>=20
> I guess I'm confused what's happening .. It sounds like with
> nmi_watchdog=3D1 , the system hangs and the watchdog catches it. With
> nmi_watchdog=3D2 the system doesn't hang, and the watchdog doesn't catch
> anything (assuming it's working)?

the LTP yeild_sched/1-1.test lockup only happens with the -rt patch
applied.

trying to use nmi_watchdog=3D1 with -rt and it reports LOCKUP at *boot*.
no chance to log in... no chance to run LTP test.  the console logs
attached at the beginning of this thread show this for latest -rt on
both 22 and 23-rc

trying to use nmi_watchdog=3D2 with -rt - does not LOCKUP at boot. but it
also does not appear to be working.  log in and run LTP test and system
hardlocks again and the watchdog never detects LOCKUP -> panic ->
crashdump (which is all set up with the hope to discover why the LTP
test is hanging :)

...snip...

> >   For x86-64, the needed APIC is always compiled in, and the NMI
> >   watchdog is always enabled with I/O-APIC mode (nmi_watchdog=3D1).  =
=20
> >   Currently, local APIC mode (nmi_watchdog=3D2) does not work on =
x86-64.
> >=20
> > Is this no longer true?  My experience with nmi_watchdog=3D2 and this =
LTP
> > openposix sched_yeild 1-1.test is that this test hardlocks the host =
and
> > that no watchdog is triggered with this setting.
>=20
> It looks like it should work .. I'd be surprised if it didn't work.. You
> can check if it's ticking in /proc/interrupts under NMI (it stops when
> the system is idle tho)

well... i've got counts - but like i said earlier it doesn't catch the
LOCKUP when the LTP test hardlocks the host.

luge:~ # cat /proc/interrupts |grep -Ee 'NMI|CPU'
           CPU0       CPU1       CPU2       CPU3 \
NMI:       1559        692        608        544 \

           CPU4       CPU5       CPU6       CPU7
           783        273        213        155


ah, but fortunately a serial console BREAK followed by 'c' dumps....

db


--=__Part082FA4C1.1__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCRzV3QThIMjhKSFlhekxhUVJBc1g4QUtDRThsWk9NQ1RsaHd5Q1cxdzNa
Vm9nTWJmeDVRQ2ZYM1p2CnRVOG5mcitNRkhETXBDNVRDQlZqRGVZPQo9SE82SAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__Part082FA4C1.1__=--
