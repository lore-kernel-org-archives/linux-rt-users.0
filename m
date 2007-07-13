From: "David Bahi" <dbahi@novell.com>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 14:21:42 -0600
Message-ID: <46978A760200006C00014998@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA1867DC6.3__="
Cc: <mingo@elte.hu>, <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:25639 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbXGMUVu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 16:21:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__PartA1867DC6.3__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 2007-07-13 at 09:29 -0700, Daniel Walker wrote:
> On Fri, 2007-07-13 at 10:11 -0600, David Bahi wrote:
> > On Fri, 2007-07-13 at 13:36 +0200, Remy Bohmer wrote:
> > > Thomas,
> > >=20
> >=20
> > > It should be: http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/
> > >=20

> Below is an only compile tested patch to drop the spinlocks out of the
> c3 enter idle function, and use atomics instead. It looks related to
> your panic.. I'm in the process of testing it, but you more than welcome
> to try it..

outstanding!

2.6.22.1-rt3-rt #1 SMP PREEMPT RT Fri Jul 13 16:08:12 EDT 2007 \
 x86_64 x86_64 x86_64 GNU/Linux

thank you very much - this is a confirmed fix for my t60p laptop.=20

cyclictest results ran as i typed this:

./cyclictest -p80 -t2 -n
0.15 0.04 0.01 3/217 5011

T: 0 ( 4963) P:80 I:1000 C: 168698 Min:      4 Act:   67 Avg:   33 Max:
832
T: 1 ( 4964) P:79 I:1500 C: 112466 Min:      4 Act:   50 Avg:   34 Max:
825



--=__PartA1867DC6.3__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCR2w5N1FIMjhKSFlhekxhUVJBaXp5QUtDWndvTkVCcFVyZ1NaQzdROG1j
WlRBYkZld053Q2dqWnBICnU5Umg1bWYvaHZzaHpTeW9XM0gxYm9jPQo9ME5vegotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__PartA1867DC6.3__=--
