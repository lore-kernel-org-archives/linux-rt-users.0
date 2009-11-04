From: Tim Blechmann <tim@klingt.org>
Subject: rt file i/o
Date: Wed, 04 Nov 2009 16:25:35 +0100
Message-ID: <hcs6dr$235$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2141DE75949BEBA07BAEA98"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44194 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297AbZKDP0G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 10:26:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N5hkQ-0002Sm-5z
	for linux-rt-users@vger.kernel.org; Wed, 04 Nov 2009 16:26:10 +0100
Received: from 85-127-249-188.dynamic.xdsl-line.inode.at ([85.127.249.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2009 16:26:10 +0100
Received: from tim by 85-127-249-188.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2009 16:26:10 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2141DE75949BEBA07BAEA98
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all,

having read the howto build an rt-application, i am trying to think of a
way to handle disk i/o in my application.

the howto suggest to avoid file i/o in non-rt helper threads, but to
move them to another process. while the howto suggests using network
socket, i'm curious, if other ipc primitives like shared memory would
give better throughput? or would i experience any issues, like is it
possible to lock shared memory to physical ram?

thanks, tim

--=20
tim@klingt.org
http://tim.klingt.org

Art is either a complaint or do something else
  John Cage quoting Jasper Johns



--------------enigC2141DE75949BEBA07BAEA98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrxnPUACgkQdL+4qsZfVsvALACdFtpWzgdLi/aeNBJO0jTVtGro
cDwAnAjBE8LKslAmW4lWwORH+z1XtKqR
=tm5N
-----END PGP SIGNATURE-----

--------------enigC2141DE75949BEBA07BAEA98--

