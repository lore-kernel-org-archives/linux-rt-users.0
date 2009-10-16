From: Nedko Arnaudov <nedko@arnaudov.name>
Subject: Re: fork() blocking rt-threads?
Date: Fri, 16 Oct 2009 19:31:03 +0300
Message-ID: <87k4yvb8s8.fsf@usbix.spacelabs.org>
References: <20091016162521.457c18ee@gmx.at> <20091016162258.GH3394@uudg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37862 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbZJPQfB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2009 12:35:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Myplf-0000OR-PL
	for linux-rt-users@vger.kernel.org; Fri, 16 Oct 2009 18:35:03 +0200
Received: from kokiche.atia.com ([89.190.197.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Oct 2009 18:35:03 +0200
Received: from nedko by kokiche.atia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Oct 2009 18:35:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--=-=-=
Content-Transfer-Encoding: quoted-printable

"Luis Claudio R. Goncalves" <lclaudio@uudg.org> writes:

> On Fri, Oct 16, 2009 at 04:25:21PM +0200, hollunder@gmx.at wrote:
> | Hi,
> | I'm a Linux audio user and following the rt kernel development closely
> | (only as a user).
> | I've experienced something that might be relevant for all of us.
> |=20
> | When loading the plug-in 'lv2fil' in one of our most relevant
> | Linux audio applications, ardour, and opening the ui, fork() was used.
> | This usually blocks the rt thread long enough to wreak havoc to the
> | underlying rt audio server jack.
> |=20
> | What's relevant here is the ill effect of fork() and that tests
> | showed that vfork() works a lot better.
> | One ticket associated with this is:
> | http://nedko.arnaudov.name/soft/lv2fil/trac/ticket/9
> |=20
> | Ardour also uses some gtk function (to open a page in the
> | default webbrowser) that uses fork() and causes the same problem.
> |=20
> | Again, it seems the problem stems from the fork() implementation and is
> | present at least in 2.6.21.x through 2.6.31.x(-rt).
> | I'm quite sure this doesn't only affect us audio people.
> |=20
> | I hope this information is of help and someone will look into it.
>
> Do you know how people benchmarked fork, vfork and clone? Is it easier th=
an
> reproducing the issue you observed?

I did some benchmarks, IIRC, vfork was slower than fork; clone and
clone2 were giving xruns and were not faster.

> Another question that comes to mind is: was Ardour running with a realtime
> priority too? Higher or lower prio than jack's?

Ardour process has realtime thread(s) started by libjack.

If someone is interested, lv2fil code has disabled code for
measuring fork-and-like execution time.

=2D-=20
Nedko Arnaudov <GnuPG KeyID: DE1716B0>

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFK2J/K6bb4v94XFrARAhY8AJwN3idH2kweRPyRtHwWLyXrot5T7gCggMtk
Y+LRWNvNL/z/++Ffa8N5PX4=
=hH8o
-----END PGP SIGNATURE-----
--=-=-=--

