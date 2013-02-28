From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Thu, 28 Feb 2013 09:27:08 -0600
Message-ID: <20130228092708.7da98c75@riff.lan>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<20130225152122.49c408ec@riff.lan>
	<CA+69FtDP0K5AqmL+Hi4vouuoOdHN2md4DrUkkZ1rtZFZAzfcJw@mail.gmail.com>
	<20130227100957.22994960@riff.lan>
	<CA+69FtB+_vt+L8VcsLs31DudkYE0iz7ckL=obQGkBP=f7smvSQ@mail.gmail.com>
	<20130227140013.0f28c91b@riff.lan>
	<CA+69FtBGT0NJ5Yh1Qqc9YWh+PuM_p=dng8=ApK1ie4ia0QvPiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/4vAAumsP.lAsDcJbqqXJifR"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655Ab3B1P1L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Feb 2013 10:27:11 -0500
In-Reply-To: <CA+69FtBGT0NJ5Yh1Qqc9YWh+PuM_p=dng8=ApK1ie4ia0QvPiA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/4vAAumsP.lAsDcJbqqXJifR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Feb 2013 17:07:06 +0200
Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> On Wed, Feb 27, 2013 at 10:00 PM, Clark Williams <williams@redhat.com> wr=
ote:
> > Well this is a new one on me. Some questions:
> >
> > Do you have SELinux running?
>=20
> No SELinux is disabled
>=20
> >
> > Are there any files in /etc/security/limits.d other than the one you put
> > there?
> >
> Yes there are:
>=20
> root@overo:/etc/security# ls -l
> total 40
> -rw-r--r-- 1 root root 4620 Feb 26  2013 access.conf
> -rw-r--r-- 1 root root 3635 Feb 26  2013 group.conf
> -rw-r--r-- 1 root root 1825 Feb 26  2013 limits.conf
> drwxr-xr-x 2 root root 4096 Feb 26  2013 limits.d
> -rw-r--r-- 1 root root 1442 Feb 26  2013 namespace.conf
> drwxr-xr-x 2 root root 4096 Feb 26  2013 namespace.d
> -rwxr-xr-x 1 root root 1020 Feb 26  2013 namespace.init
> -rw-r--r-- 1 root root 2980 Feb 26  2013 pam_env.conf
> -rw-r--r-- 1 root root 2180 Feb 26  2013 time.conf
>=20
>=20
> > Other than that I can't think of a reason why sched_setscheduler()
> > would fail as root.

That's /etc/security, I was asking for /etc/security/limits.d.=20

Since you said that disabling RT_GROUP_SCHED fixed it, I looked at
kernel/sched/core.c and found this block of code in
__sched_setscheduler():

#ifdef CONFIG_RT_GROUP_SCHED
	if (user) {
		/*
		 * Do not allow realtime tasks into groups that have no runtime
		 * assigned.
		 */
		if (rt_bandwidth_enabled() && rt_policy(policy) &&
				task_group(p)->rt_bandwidth.rt_runtime =3D=3D 0 &&
				!task_group_is_autogroup(task_group(p))) {
			task_rq_unlock(rq, p, &flags);
			return -EPERM;
		}
	}
#endif

There are plenty of places in __sched_setscheduler() to get punted out
with -EPERM, but this looks likely. My guess is that you have something
going on (or not going on) wrt cgroups and you got kicked out by one of
the above tests.=20

I think if you look at the RT wiki, it recommends not turning on
RT_GROUP_SCHED for PREEMPT_RT systems (if it doesn't, it *should*).=20

Clark

--Sig_/4vAAumsP.lAsDcJbqqXJifR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEvd0wACgkQHyuj/+TTEp1D1gCeKo8muLmtPnKk3fPD1dJWQaxS
paMAoJRcqTH47WHdSLn7aY6MvdsTdkTG
=OAs7
-----END PGP SIGNATURE-----

--Sig_/4vAAumsP.lAsDcJbqqXJifR--
