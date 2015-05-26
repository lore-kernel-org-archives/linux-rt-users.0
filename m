From: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Subject: Re: debian RT kernel
Date: Tue, 26 May 2015 09:24:48 +0200
Message-ID: <7f79-55642000-25-50abc380@46760505>
References: <1432329729.12412.48.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	=?utf-8?q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>,
	linux-rt-users@vger.kernel.org
To: "Ben Hutchings" <ben@decadent.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp01.univ-lille1.fr ([193.49.225.19]:34010 "EHLO
	smtp01.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbEZHZH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 03:25:07 -0400
in-reply-to: <1432329729.12412.48.camel@decadent.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

So if I understand well, the installation of RT package in a brand new =
PC:

- step 1: installation of a distribution (I have installed debian jessi=
e)
- step 2: to be able to have access of RT packages in development:
follow the link you gave me (4.3 and 4.2 steps) by replacing "dist" by =
"sid"
- step 3: install RT packages in development using apt-get install (hea=
ders and image RT) ??

Thanks a lot, and sorry for my level in linux kernel ... =20
The RT kernel is very usefull for me and I find the RT-PREEMPT developm=
ent very interesting :)

CB

Le Vendredi 22 Mai 2015 23:22 CEST, Ben Hutchings <ben@decadent.org.uk>=
 a =C3=A9crit:=20
=20
> On Fri, 2015-05-22 at 17:52 +0200, Braud Caroline wrote:
> > Hello,
> >=20
> > Sorry to ask but where is  the Debian packaging repo for 4.0-rt ?
>=20
> See the kernel handbook:
> http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-commo=
n-official-vcs
>=20
> In this case you want the 'sid' distribution.
>=20
> Ben.
>=20
> --=20
> Ben Hutchings
> One of the nice things about standards is that there are so many of t=
hem.
=20
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
