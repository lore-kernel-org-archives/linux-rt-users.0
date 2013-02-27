From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Wed, 27 Feb 2013 10:09:57 -0600
Message-ID: <20130227100957.22994960@riff.lan>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0e29mee8YvhxFwwOBcDvcR1"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab3B0QKB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 11:10:01 -0500
In-Reply-To: <CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/0e29mee8YvhxFwwOBcDvcR1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Feb 2013 08:26:45 +0200
Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> On Mon, Feb 25, 2013 at 11:21 PM, Clark Williams <williams@redhat.com> wr=
ote:
> > Changing your scheduling policy requires extra privileges. You can
> > either run cyclictest as root, or if your distribution uses PAM, you
> > can set up a file in /etc/security/limits.d which enable group access to
> > changing scheduler policy. You can name the file whatever you want, I
> > usually call mine 99-realtime.conf:
> >
> > # cat <<EOF >/etc/security/limits.d/99-realtime.conf
> > @realtime       -       rtprio  99
> > @realtime       -       memlock unlimited
> > EOF
> >
> > Then create a group named realtime and add your username to the newly
> > created group:
> >
> > # groupadd realtime
> > # usermod -a -G realtime yourUserID
> >
> > Log out, then log back in and you should be able to verift that you're
> > in the realtime group using the 'groups' command. Once you're username
> > is a member of the realtime group, you should be able to run cyclictest
> > without being root.
>=20
> This problem persists even when I run cyclictest as root. I have also
> set up PAM as described above and added root to the realtime group
> without any success.
> I have also tried "sudo ./cyclictest" and " su -c './cyclictest'
>=20
> Is this perhaps a more fundamental problem?
>=20
> Just to recap: I applied the patch-3.2-rt10 patch cleanly to a v3.2
> kernel customized for a TI OMAP (ARM) processor. CONFIG_PREEMPT_RT was
> enabled and CPU frequency scaling disabled.
>=20

This shouldn't have anything to do with the PREEMPT_RT patchset.
Changing scheduling policy via the sched_setscheduler(2) syscall is a
fundamental component of the Linux scheduler.=20

What happens if you compile and run this program on your kernel?
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <errno.h>
#include <memory.h>

int main(int argc, char **argv)
{
	int ret;
	struct sched_param s;

	memset(&s, 0, sizeof(s));
	s.sched_priority =3D 1;
	if ((sched_setscheduler(0, SCHED_FIFO, &s))) {
		fprintf(stderr, "error changing policy: %s\n", strerror(errno));
		exit(errno);
	}
	printf("successfully changed policy to SCHED_FIFO priority 1\n");
	exit(0);
}

Clark

--Sig_/0e29mee8YvhxFwwOBcDvcR1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEuL9UACgkQHyuj/+TTEp0iogCgp5CoDXQDujuub4uXpjxsLTzV
assAoOIzU9bIj2/Fd0Rrvxpa4nDgTUq3
=ioYy
-----END PGP SIGNATURE-----

--Sig_/0e29mee8YvhxFwwOBcDvcR1--
