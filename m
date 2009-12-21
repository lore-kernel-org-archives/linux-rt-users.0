From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/4] *** Add a get_cpu() library ***
Date: Mon, 21 Dec 2009 16:54:08 -0600
Message-ID: <20091221165408.1a053635@torg>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Jwpb2Mo+AZZF02/snXoUO0k"; protocol="application/pgp-signature"
Cc: Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038AbZLUWye (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 17:54:34 -0500
In-Reply-To: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/Jwpb2Mo+AZZF02/snXoUO0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Dec 2009 22:45:46 +0100
John Kacur <jkacur@redhat.com> wrote:

> I have added a get_cpu() library which should just do the right thing for=
 you
> whether your system uses sched_getcpu() (the most common case), getcpu()
> or the vsyscall version of getcpu().
>=20
> I have tested on Fedora, RHEL5 both 32 and 64-bit versions which cover al=
l of
> the cases above. I would really appreciate more testing and reports on ot=
her
> distributions. Of course comments and patches are also welcome.
>=20
> While doing this I changed the Makefile quite extensively. I hope you wil=
l find
> the changes simply and unify the Make process considerably. This could be
> further improved too - for example by creating a build directory.
>=20
> In addition to the changes below, Clark has fixed the odd CRLF issue, and
> has a patch queued-up from Carsten that was missed last time.
>=20
> Clark, you can pull the following changes from:
> git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
> branch: rt-tests-dev
>=20

Pulled and merged.

Tarball rt-tests-0.58.tar.gz pushed to kernel.org:

http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/rt-tests-=
0.58.tar.gz

Git tree updated with tag v0.58:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git


Clark

--Sig_/Jwpb2Mo+AZZF02/snXoUO0k
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAksv/JgACgkQHyuj/+TTEp0HDACeK6UC7w7HGZ3CjLStj3XwZ1Gg
jwgAn0uqx+3nnnRJse+aKYO2rhKt69Ow
=Axcv
-----END PGP SIGNATURE-----

--Sig_/Jwpb2Mo+AZZF02/snXoUO0k--
