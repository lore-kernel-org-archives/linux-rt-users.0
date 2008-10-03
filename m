From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH 2/2] RT: remove "paranoid" limit in push_rt_task
Date: Fri, 03 Oct 2008 13:27:34 -0400
Message-ID: <48E65606.6040409@novell.com>
References: <20081003123745.17387.61782.stgit@dev.haskins.net> <20081003124305.17387.90233.stgit@dev.haskins.net> <48E62253.1090000@bull.net> <20081003154501.GB5032@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E2421D04FB8E75D32C66AE1"
To: Gilles Carry <Gilles.Carry@bull.net>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:50944 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYJCRXQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 13:23:16 -0400
In-Reply-To: <20081003154501.GB5032@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E2421D04FB8E75D32C66AE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Chirag Jog wrote:
> * Gilles Carry <Gilles.Carry@bull.net> [2008-10-03 15:46:59]:
>
>  =20
>> Sorry Greg,
>>
>> Neither PPC64 nor Intel64 make it with this patch.
>> At boot time, it stops at the BUG_ON you added:
>> 0xc00000000004eca4 is in push_rt_task (kernel/sched_rt.c:1102)
>>    =20
> I am also confirming this issue gilles reported.
>
> Although, i have a question:
> When we enable group scheduling (CONFIG_RT_GROUP_SCHED),
> all the problems disappear.
> After skimming through the rt scheduler code, I don't feel group=20
> scheduling alters the behavior of push/pull strategies in any way.
>
> So I am wonder whether enabling group scheduling
> actually solves the problem or just makes it tough=20
> to recreate?
>  =20
Hi Chirag,


The issue that Gilles pointed me at is a race condition.  I do not
suspect GROUP_SCHED itself has anything to do with the problem other
than it changes the timing.  HTH!

-Greg




--------------enig2E2421D04FB8E75D32C66AE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjmVgYACgkQlOSOBdgZUxmCHwCeON4kWz3qBkueaSNOsVLdNDQY
xVIAn1+tRmWW1t2s9gD3ceWrIiBC5h0a
=ywZW
-----END PGP SIGNATURE-----

--------------enig2E2421D04FB8E75D32C66AE1--
