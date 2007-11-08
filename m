From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through
	2.6.23.1-rt11)
Date: Thu, 08 Nov 2007 08:56:07 -0500
Message-ID: <4732CF27.BA47.005A.0@novell.com>
References: <200711072334.40216.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part6E481767.3__="
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Darren Hart" <dvhltc@us.ibm.com>,
	"RT" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:41698 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753964AbXKHN7E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 08:59:04 -0500
In-Reply-To: <200711072334.40216.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__Part6E481767.3__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> On Thu, Nov 8, 2007 at  2:34 AM, in message
<200711072334.40216.dvhltc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com> =
wrote:

> Greg,
>=20
> Here are the results I promised you.

Darren,
   First off, thanks a bunch for running through those tests!

> I don't think they are particularly interesting

They *are* interesting in the sense that peaks of 40ish for an 8-way are =
excellent IMO ;)  But yeah, i see what you mean; theres no interesting =
difference between them.

Do you have any comparative data from runs in -rt1 or earlier kernels?

> perhaps more iterations, say 1000000?=20

We generally load the system up a lot more (e.g. "make -j 128")  or let it =
run for a long time with the make in a loop (or both).  For instance, here =
is the last data I gathered (with plot attached).  This was for a single =
pass of "make mrproper; make allmodconfig; time make -j 128"
=20
23.1-rt7
-----------------
real    10m49.312s
user    49m59.674s
sys     16m15.404s

26.38 76.02 56.11 1/304 21301

T: 0 ( 5959) P:90 I:100 C:7500381 Min:      2 Act:    2 Avg:    4 Max:     =
 78
T: 1 ( 5960) P:89 I:200 C:3750191 Min:      2 Act:    3 Avg:    5 Max:     =
 91
T: 2 ( 5961) P:88 I:300 C:2500127 Min:      2 Act:    3 Avg:    4 Max:     =
 66
T: 3 ( 5962) P:87 I:400 C:1875096 Min:      2 Act:    5 Avg:    6 Max:     =
106
T: 4 ( 5963) P:86 I:500 C:1500077 Min:      2 Act:    6 Avg:    5 Max:     =
 92
T: 5 ( 5964) P:85 I:600 C:1250064 Min:      2 Act:    5 Avg:    6 Max:     =
 93
T: 6 ( 5965) P:84 I:700 C:1071483 Min:      2 Act:    3 Avg:    6 Max:     =
 78
T: 7 ( 5966) P:83 I:800 C: 937548 Min:      2 Act:    5 Avg:    6 Max:     =
 97

23.1-rt10
-----------------

real    10m39.046s
user    56m31.662s
sys     12m51.158s

7.64 63.88 62.70 1/291 30774

T: 0 (15455) P:90 I:100 C:8001856 Min:      2 Act:    3 Avg:    4 Max:     =
 65
T: 1 (15456) P:89 I:200 C:4000928 Min:      2 Act:    3 Avg:    4 Max:     =
 46
T: 2 (15457) P:88 I:300 C:2667286 Min:      2 Act:    3 Avg:    5 Max:     =
 54
T: 3 (15458) P:87 I:400 C:2000464 Min:      2 Act:    3 Avg:    5 Max:     =
 46
T: 4 (15459) P:86 I:500 C:1600372 Min:      2 Act:    3 Avg:    5 Max:     =
 46
T: 5 (15460) P:85 I:600 C:1333643 Min:      2 Act:    5 Avg:    5 Max:     =
 75
T: 6 (15461) P:84 I:700 C:1143123 Min:      2 Act:    5 Avg:    6 Max:     =
 52
T: 7 (15462) P:83 I:800 C:1000232 Min:      2 Act:    4 Avg:    5 Max:     =
 66

23.1-rt11
-----------------

real    10m41.610s
user    55m37.065s
sys     13m16.394s

101.92 101.56 61.65 1/308 21349

T: 0 ( 6028) P:90 I:100 C:6584414 Min:      2 Act:    3 Avg:    4 Max:     =
 55
T: 1 ( 6029) P:89 I:200 C:3292207 Min:      2 Act:    6 Avg:    5 Max:     =
 58
T: 2 ( 6030) P:88 I:300 C:2194805 Min:      2 Act:    5 Avg:    5 Max:     =
 54
T: 3 ( 6031) P:87 I:400 C:1646104 Min:      2 Act:    5 Avg:    5 Max:     =
 79
T: 4 ( 6032) P:86 I:500 C:1316883 Min:      2 Act:    5 Avg:    5 Max:     =
 60
T: 5 ( 6033) P:85 I:600 C:1097403 Min:      2 Act:    5 Avg:    6 Max:     =
 45
T: 6 ( 6034) P:84 I:700 C: 940631 Min:      2 Act:    3 Avg:    6 Max:     =
 45
T: 7 ( 6035) P:83 I:800 C: 823052 Min:      2 Act:    5 Avg:    6 Max:     =
 47

As Steven Rostedt pointed out on IRC, numbers coming from me are suspect =
;).  But we can at least use them to see if you can repro similar results.

Thanks again!

Regards,
-Greg


--=__Part6E481767.3__=
Content-Type: image/png; name="plot.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="plot.png"
Content-Description: Portable Network Graphics Format

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

--=__Part6E481767.3__=--
