From: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Subject: Re: debian RT kernel
Date: Mon, 01 Jun 2015 15:25:49 +0200
Message-ID: <738f-556c5d80-29-3481abc0@71319895>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	=?utf-8?q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>,
	linux-rt-users@vger.kernel.org,
	"Ben Hutchings" <ben@decadent.org.uk>
To: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp02.univ-lille1.fr ([193.49.225.20]:33234 "EHLO
	smtp02.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbFAN0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2015 09:26:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Here are the steps I have performed:
$apt-get install build-essential fakeroot rsync
$apt-get install subversion subversion-tools
$apt-get build-dep linux
$svn co svn://anonscm.debian.org/svn/kernel/dists/sid/linux
$apt-get source -d linux
$cd linux

and here is the first problem I have:
 $debian/rules orig
debian/rules:59: *** Cannot find orig tarball linux_4.0.4.orig.tar.xz. =
Arr=C3=AAt.


Here is what was downloaded by "apt-get source -d linux"
$ ls ../linux*
=2E./linux_3.16.7-ckt9-2.debian.tar.xz  ../linux_3.16.7-ckt9-2.dsc  ../=
linux_3.16.7-ckt9.orig.tar.xz
=2E./linux:
debian

I guess I should use the version in the link given by Ben:
http://snapshot.debian.org/package/linux/4.0.2-1/

But where is it defined ?=20

Here is what I can find using a command in the "rules" file:

$ dpkg-parsechangelog=20
Source: linux
Version: 4.0.4-2
Distribution: UNRELEASED
Urgency: medium
Maintainer: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 27 May 2015 21:36:56 +0100
Closes: 786716 787004 787029
Changes:
 linux (4.0.4-2) UNRELEASED; urgency=3Dmedium
 .
   [ Ben Hutchings ]
   * udeb: Remove i2o modules (fixes FTBFS on amd64) (Closes: #787004)=0D
 .
   [ Ian Campbell ]
   * [armhf] Enable PCIe support for IMX6 boards. Patch from Vagrant
     Cascadian (Closes: #787029)
   * [armhf] Add stmmac-platform module to nic-modules udeb. (Closes: #=
786716)


Thanks !=20
CB

Le Mardi 26 Mai 2015 09:24 CEST, "Braud Caroline" <Caroline.Braud@univ-=
lille1.fr> a =C3=A9crit:=20
=20
> Hello,
>=20
> So if I understand well, the installation of RT package in a brand ne=
w PC:
>=20
> - step 1: installation of a distribution (I have installed debian jes=
sie)
> - step 2: to be able to have access of RT packages in development:
> follow the link you gave me (4.3 and 4.2 steps) by replacing "dist" b=
y "sid"
> - step 3: install RT packages in development using apt-get install (h=
eaders and image RT) ??
>=20
> Thanks a lot, and sorry for my level in linux kernel ... =20
> The RT kernel is very usefull for me and I find the RT-PREEMPT develo=
pment very interesting :)
>=20
> CB
>=20
> Le Vendredi 22 Mai 2015 23:22 CEST, Ben Hutchings <ben@decadent.org.u=
k> a =C3=A9crit:=20
> =20
> > On Fri, 2015-05-22 at 17:52 +0200, Braud Caroline wrote:
> > > Hello,
> > >=20
> > > Sorry to ask but where is  the Debian packaging repo for 4.0-rt ?
> >=20
> > See the kernel handbook:
> > http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-com=
mon-official-vcs
> >=20
> > In this case you want the 'sid' distribution.
> >=20
> > Ben.
> >=20
> > --=20
> > Ben Hutchings
> > One of the nice things about standards is that there are so many of=
 them.
> =20
> =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
=20
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
