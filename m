From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 19:13:45 -0400
Message-ID: <1190070825.4433.78.camel@ghaskins-t60p.haskins.net>
References: <200709172012.21102.ak@suse.de>
	 <1190056047.3253.104.camel@imap.mvista.com>
	 <1190057923.3615.26.camel@sven.thebigcorporation.com>
	 200709172220.43871.ak@suse.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ABYhgAoyivjFpSX5FJEI"
Cc: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	Daniel Walker <dwalker@mvista.com>, mingo@elte.hu,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:49792 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbXIQXPo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 19:15:44 -0400
In-Reply-To: 200709172220.43871.ak@suse.de
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-ABYhgAoyivjFpSX5FJEI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-09-17 at 22:20 +0200, Andi Kleen wrote:

> I disagree for the oops case.  You want the simplest possible code
> here.

I would have to agree with Andi.  Being conservative here is probably a
good thing to avoid nasties like oops recursion.  No sense in polishing
the brass....;)  We already know the ship is sinking due to an earlier
error (which is the more important error anyway).  I would go so far as
to say the other arches should probably follow suit as well.

Or am I missing something?

Regards,
-Greg


--=-ABYhgAoyivjFpSX5FJEI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBG7wopSW61Ku6jJPkRAhmEAKCMw++LgakH/pCIkZYPst/thuwFIgCgrNBy
Gf2XI8sSXy9Q8LtJqkOE9Oo=
=ueXY
-----END PGP SIGNATURE-----

--=-ABYhgAoyivjFpSX5FJEI--
