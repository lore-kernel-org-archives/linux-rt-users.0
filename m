From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Wed, 27 Feb 2013 14:00:13 -0600
Message-ID: <20130227140013.0f28c91b@riff.lan>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
	<20130227100957.22994960@riff.lan>
	<CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/i2dd3AvQLikhpt8lo5ZUkHF"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab3B0UAl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 15:00:41 -0500
In-Reply-To: <CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/i2dd3AvQLikhpt8lo5ZUkHF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Feb 2013 18:22:20 +0200
Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> On Wed, Feb 27, 2013 at 6:09 PM, Clark Williams <williams@redhat.com> wro=
te:
> > What happens if you compile and run this program on your kernel?
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <sched.h>
> > #include <errno.h>
> > #include <memory.h>
> >
> > int main(int argc, char **argv)
> > {
> >         int ret;
> >         struct sched_param s;
> >
> >         memset(&s, 0, sizeof(s));
> >         s.sched_priority =3D 1;
> >         if ((sched_setscheduler(0, SCHED_FIFO, &s))) {
> >                 fprintf(stderr, "error changing policy: %s\n", strerror=
(errno));
> >                 exit(errno);
> >         }
> >         printf("successfully changed policy to SCHED_FIFO priority 1\n"=
);
> >         exit(0);
> > }
>=20
> When I run it as root I get "error changing policy: Operation not permitt=
ed".
>=20
> Does this mean that some hard limits are not correctly set for root?

Well this is a new one on me. Some questions:

Do you have SELinux running?

Are there any files in /etc/security/limits.d other than the one you put
there?

Other than that I can't think of a reason why sched_setscheduler()
would fail as root.=20

Clark

--Sig_/i2dd3AvQLikhpt8lo5ZUkHF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEuZc0ACgkQHyuj/+TTEp3w/gCgia3v98qKIIJBcFKrdum12nUR
UCgAmwYxCX7PquL2PsJ50JhrJ+RLli1/
=zqOQ
-----END PGP SIGNATURE-----

--Sig_/i2dd3AvQLikhpt8lo5ZUkHF--
