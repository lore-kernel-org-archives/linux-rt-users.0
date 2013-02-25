From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Mon, 25 Feb 2013 15:21:22 -0600
Message-ID: <20130225152122.49c408ec@riff.lan>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/n9oVJpNAR1jTRSHi0CUMql_"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758391Ab3BYWBp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2013 17:01:45 -0500
In-Reply-To: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/n9oVJpNAR1jTRSHi0CUMql_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Feb 2013 22:03:06 +0200
Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> Dear RT Folks,
>=20
> After successfully patching a 3.2 kernel (gumstix platform) with
> patch-3.2-rt10, I obtained the rt-tests suite from
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>=20
> I enabled CONFIG_PREEMPT_RT in menuconfig and disabled "CPU frequency sca=
ling".
>=20
> Compilation of rt-tests ("make all") on the platform is also successful.
>=20
> When trying to execute cyclictest, the program reports: "Unable to
> change scheduling policy! either run as root or join realtime group"
>=20
> Looking in rt-utils.c, it appears that set_scheduler is unable to
> select SCHED_FIFO scheduling policy.
>=20
> Do you have any hints on how to fix this problem, or at least narrow
> it down further? Could it
>=20
>  Best Regards,
> Hartmut Behrens
> --
>

Changing your scheduling policy requires extra privileges. You can
either run cyclictest as root, or if your distribution uses PAM, you
can set up a file in /etc/security/limits.d which enable group access to
changing scheduler policy. You can name the file whatever you want, I
usually call mine 99-realtime.conf:

# cat <<EOF >/etc/security/limits.d/99-realtime.conf
@realtime	-	rtprio	99
@realtime	- 	memlock unlimited
EOF

Then create a group named realtime and add your username to the newly
created group:

# groupadd realtime
# usermod -a -G realtime yourUserID

Log out, then log back in and you should be able to verift that you're
in the realtime group using the 'groups' command. Once you're username
is a member of the realtime group, you should be able to run cyclictest
without being root.=20

Clark


--Sig_/n9oVJpNAR1jTRSHi0CUMql_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEr1dIACgkQHyuj/+TTEp007QCgy6DaPKEM/YdBEPqYhMZ/E3Xk
fLMAnAlkSLyiN7WdVZB5BnWSDsWwtEO+
=v294
-----END PGP SIGNATURE-----

--Sig_/n9oVJpNAR1jTRSHi0CUMql_--
