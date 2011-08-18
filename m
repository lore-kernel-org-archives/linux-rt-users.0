From: Clark Williams <williams@redhat.com>
Subject: proposed change to cyclictest -b <n> behavior
Date: Thu, 18 Aug 2011 12:37:17 -0500
Message-ID: <20110818123717.2ff10c06@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/mxyrA72l4nPGhNQTXhFxNzF"; protocol="application/pgp-signature"
Cc: Steven Rostedt <srostedt@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61583 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1HRRhV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Aug 2011 13:37:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7IHbKcJ020676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Aug 2011 13:37:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/mxyrA72l4nPGhNQTXhFxNzF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

All,

I was updating cyclictest in the rt-tests package to handle the 3.0-rt
kernel changes and was talking to Steven Rostedt about ftrace options
and he suggested this change to the -b (breaktrace) option: use event
tracing rather than function tracing by default.=20

The default for -b is to enable the function tracer. What Steven is
suggesting is to trace using the already installed tracepoints to get
an idea of where a latency occurs, rather than incurring the function
tracer (mcount) overhead by default. This is equivalent to doing:

# cyclictest -b 1000 --event --tracer=3Dnop

I like the idea, but wanted to ask the cyclictest users if this would
break anything. I actually think that the whole ftrace interface for
cyclictest needs to be overhauled, since it was done very ad hoc and is
not all that well thought out, but I'm not quite ready to take that on
now.=20

So, anyone object to me making this change?

Clark

--Sig_/mxyrA72l4nPGhNQTXhFxNzF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk5NTc0ACgkQHyuj/+TTEp2UQwCgvdismjqxosth1eOtiB7tI1Z2
+oIAn3Leb1i7avgtpnYyUdEiDwFCVKcW
=iCm0
-----END PGP SIGNATURE-----

--Sig_/mxyrA72l4nPGhNQTXhFxNzF--
