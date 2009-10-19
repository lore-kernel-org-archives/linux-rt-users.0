From: Clark Williams <williams@redhat.com>
Subject: Re: fork() blocking rt-threads?
Date: Mon, 19 Oct 2009 10:33:39 -0500
Message-ID: <20091019103339.583b6511@torg>
References: <20091016162521.457c18ee@gmx.at>
	<20091016162258.GH3394@uudg.org>
	<87k4yvb8s8.fsf@usbix.spacelabs.org>
	<75b66ecd0910172311i36c519b1xec6b0cb0c4eb18e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/MQ4yxKxyk_k=8uZNha/Z+ad"; protocol="application/pgp-signature"
Cc: Nedko Arnaudov <nedko@arnaudov.name>,
	linux-rt-users@vger.kernel.org
To: Lee Revell <rlrevell@joe-job.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbZJSPdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Oct 2009 11:33:43 -0400
In-Reply-To: <75b66ecd0910172311i36c519b1xec6b0cb0c4eb18e8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/MQ4yxKxyk_k=8uZNha/Z+ad
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2009 02:11:22 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, Oct 16, 2009 at 12:31 PM, Nedko Arnaudov <nedko@arnaudov.name> wr=
ote:
> >> Another question that comes to mind is: was Ardour running with a real=
time
> >> priority too? Higher or lower prio than jack's?
> >
> > Ardour process has realtime thread(s) started by libjack.
>=20
> AFAICT, fork() is inherently unusable from any thread of a process
> with realtime threads.  It locks the page tables and the process
> structure of the parent among other things.
>=20
> Anyone know if posix_spawn() is supported by any major distro's glibc?
>  Apparently it was developed to solve this exact problem.
>=20
> http://www.opengroup.org/onlinepubs/009695399/functions/posix_spawn.html
>=20

Just tried it on a RHEL5.4 and Fedora 11 system. The pthread_spawn(3P)
function is implemented using vfork(2) under the covers. Makes sense,
since the stated intent is to work without VM.=20

Still, anyone wanting to create processes/threads in a realtime
environment needs to do that stuff up front, since there's a ton of
work required to make a scheduleable entity. Whether you're just
creating a pthread or you're generating a full-up process, memory will
have to be allocated and locks taken.  Not sure I'd depend on
*anything* to do the right thing for me...

Clark

--Sig_/MQ4yxKxyk_k=8uZNha/Z+ad
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrchtgACgkQHyuj/+TTEp12fwCcD3Wan07U4YGqz0ub8TF2oYiy
D6cAoLtahBYrm2oUu6JYFgUVH6cohsnr
=6wLc
-----END PGP SIGNATURE-----

--Sig_/MQ4yxKxyk_k=8uZNha/Z+ad--
