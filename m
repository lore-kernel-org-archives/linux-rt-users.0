From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:29:42 -0400
Message-ID: <48B823F6.1010509@novell.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBECBE93C59AE269ACCF9414C"
Cc: Gregory Haskins <gregory.haskins@gmail.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:51150 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYH2QcS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:32:18 -0400
In-Reply-To: <20080829162216.GW26610@one.firstfloor.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBECBE93C59AE269ACCF9414C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andi Kleen wrote:
>> Im running it on a x86_64 box as we speak.  How can I tell if there is=
 a
>> certain mode that is permitting this?
>>    =20
>
> If the boot up says you're running with PMtimer then it uses the fallba=
ck
> (usually happens on pre Fam10h AMD boxes). A typical Intel box
> would use the faster ring 3 only TSC path and then explode with your
> change I bet.=20
>  =20

Thinking about this some more, perhaps the issue is I am not hitting the
contended path in vsyscall?

-Greg



--------------enigBECBE93C59AE269ACCF9414C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki4I/YACgkQlOSOBdgZUxmOWwCfV+N6HBTlTeyzEy3A0TH1iMF/
K+kAn0GFKYL6LTtr93N3qT8XCSX7U6IR
=QH1h
-----END PGP SIGNATURE-----

--------------enigBECBE93C59AE269ACCF9414C--
