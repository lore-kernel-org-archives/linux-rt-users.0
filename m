From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Tweaking pengutronix' debian packages for rt kernels
Date: Sun, 2 Jan 2011 22:00:32 +0100
Message-ID: <20110102210032.GM14221@pengutronix.de>
References: <20110101161000.GY32493@bzzt.net> <20110101172523.GA29870@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arnout Engelen <arnouten@bzzt.net>, linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36894 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1ABVAg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Jan 2011 16:00:36 -0500
Content-Disposition: inline
In-Reply-To: <20110101172523.GA29870@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jan 01, 2011 at 06:25:23PM +0100, Nicholas Mc Guire wrote:
> On Sat, 01 Jan 2011, Arnout Engelen wrote:
>=20
> > Hi,
> >=20
> > http://www.pengutronix.de/software/linux-rt/debian_en.html mentions=
 this=20
> > would be the right place to discuss the Pengutronix Debian packages=
 containing
> > RT-patched kernels.
> >=20
> > Is there any guide that documents how to build tweaked versions of =
these=20
> > packages? Pengutronix seems to be doing a great job, but for exampl=
e the=20
> > package for the 2.6.33.7.2-rt30 kernel doesn't contain the 'nouveau=
' graphics
> > driver, which I happen to use.=20
> >
>=20
> roughly:
> * apt-get install build-essential libncurses5-dev kernel-package
> * grab sources: http://debian.pengutronix.de/debian/pool/non-free/l/l=
inux-2.6/linux-2.6_2.6.33.7.2-rt30.orig.tar.gz
>  Note that you can't verify the sources as no signature file is provi=
ded (bad)
>  ...or simply grab a verified kernel from kernel.org and the appropri=
ate patch
Hmm, they should be verifiable using the normal Debian tools:

	http://debian.pengutronix.de/debian/dists/sid/Release is signed
	http://debian.pengutronix.de/debian/dists/sid/Release lists the
md5 and sha1 sum of non-free/source/Sources.gz
	http://debian.pengutronix.de/debian/dists/sid/non-free/source/Sources.=
gz  has the sums for
		linux-2.6_2.6.33.7.2-rt30.orig.tar.gz
		linux-2.6_2.6.33.7.2-rt30-1.diff.gz
		linux-2.6_2.6.33.7.2-rt30-1.dsc

This is what apt would check for you when you just do

	apt-get source linux-2.6

to grab and unpack the sources.  (You only need to pay attention that
you get the Pengutronix sources, not the Debian ones.  This depends on
the source lines in your sources.list and probably some configuration i=
n
/etc/apt/preferences)
=09
> * unpack sources
> * copy the config file to .config in the kernel source tree.
Note there are multiple config files that are all used to build the
config actually being used.

> * make menuconfig and add the driver you need
> * adjust /etc/kernel-pkg.conf (atleast maintainer and email - so you =
get blamed if you screwed up ;)
> * compile and sign package: CONCURRENCY_LEVEL=3D4 make-kpkg --pgpsign=
 YOURNAME --initrd --append-to-version=3D-nouveau --revision=3D2.6.33.7=
 kernel-image kernel-source
=46or that you don't need the pengutronix sources.  The (IMHO) more
appropriate way is to edit config/config and then use

	debuild -us -uc

and then go and get you a coffee (or two).
>=20
> Notes:
> * Note that you get a build failure on lenny as it does not find the =
utsreleas version in the right location for newer kernels (newer than 2=
=2E6.26 that is) so you have to manually cp include/generated/utsreleas=
e.h include/linux/utsrelease.h and rerun the make-kpkg command
> * provide package AND sginature to the users of this package.
> * CONCURRENCY_LEVEL is just like -j4 here - so adjust to what is suit=
able for your compile box
You have to use DEBIAN_KERNEL_JOBS=3D4 for the way described above.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
