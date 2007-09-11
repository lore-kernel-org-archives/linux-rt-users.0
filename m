From: "David Bahi" <dbahi@novell.com>
Subject: Re: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Tue, 11 Sep 2007 11:39:27 -0600
Message-ID: <46E67E6F0200006C000182F4@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC5E268DF.0__="
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:6301 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239AbXIKRjg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2007 13:39:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__PartC5E268DF.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 2007-09-11 at 02:10 +0000, David Bahi wrote:
> trying to get a crashdump in a clean -rt series kernel which hardlocks
> on the ltp openposix conformance interfaces sched_yield 1-1.test ...
>=20
> i was trying with nmi_watchdog =3D 1 (x86_64 machine, dual cpu, quad =
core,
> HT enabled) and it would report NMI LOCKUP on presentation of the login
> prompt - no chance to run the test.
>=20
>                            linux-2.6.22.1-rt9   linux-2.6.23-rc4-rt1
> lockup on openposix=20
> sched_yield test occurs            yes                  yes
>=20
> crash on login prompt
> with nmi_watchdog=3D1                yes*                 yes*
>=20
>   (*) console logs attached
>=20
>=20

fyi 2.6.23-rc4 w/o -rt passes the LTP openposix sched_yeild test and
does *not* crash (NMI LOCKUP) if nmi_watchdog=3D1 is a boot arg.

so these don't seem to be related to what i'm seeing at least:

  http://thread.gmane.org/gmane.linux.kernel/577449

db


--=__PartC5E268DF.0__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCRzV0STdIMjhKSFlhekxhUVJBbXl5QUo5SjVCbmV5VmpCcVhxN2pQbVFJ
c2YvdzlXR0VnQ2VMMzZ1CjV6UHpDV3FPY0RqTWkzR3FiaDRuYmVBPQo9dEl2OQotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__PartC5E268DF.0__=--
