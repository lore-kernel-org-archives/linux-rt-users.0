From: Clark Williams <williams@redhat.com>
Subject: Re: Help regarding Cyclictest.
Date: Fri, 9 Jan 2015 08:42:20 -0600
Message-ID: <20150109084220.1e99ca72@sluggy>
References: <CAOZUVQzdrVL6vz5NaLfaXcSovOKNjE9M7Vi4QguVLaUyDDCdog@mail.gmail.com>
	<20141223122606.11f2ff27@sluggy>
	<CAOZUVQx+YEQu7_QBDqg-HNeM7B0OqyaPeW=V5uUQWrPMoa7c7w@mail.gmail.com>
	<CAOZUVQzxATsud4L8+Z7EFRTyp9Jhu5nNcS5TyLZxWDo46R+6Dg@mail.gmail.com>
	<20141228163640.2d50be80@sluggy>
	<CAOZUVQwOgcNkJz46E0rDy_8W-Po=cSkTLg2gf7sQc9XRNftUyw@mail.gmail.com>
	<20150106152649.0cb27c34@sluggy>
	<20150108114232.6c0fc37f@gandalf.local.home>
	<CAOZUVQzPAvU5AieTF1GE79G37VksU9EoMfHrqYeA5W-Ciu9YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/QNhP/RvH4IddlLkeWSlZOqO"; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ipsit Kumar <kumaripsit1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37767 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbbAIOmh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jan 2015 09:42:37 -0500
In-Reply-To: <CAOZUVQzPAvU5AieTF1GE79G37VksU9EoMfHrqYeA5W-Ciu9YLQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/QNhP/RvH4IddlLkeWSlZOqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jan 2015 09:37:07 +0530
Ipsit Kumar <kumaripsit1@gmail.com> wrote:

> Thanks for the reply.
> I think I forgot to mention about the kernel I am running. It is Linux
> Kernel 3.3 with preemption enabled.
> Could this be a problem ? And do you think this kind of behavior is
> expected if I use a RT Patch.
>=20

Large spikes are not unusual running on a stock kernel. If you are
trying to prevent these spikes, you will need to run an RT kernel

--Sig_/QNhP/RvH4IddlLkeWSlZOqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr+jXAAoJEEersVlSw9Nz5AMP/iroOZ5M4J1/4tl9O1CefxQt
BwRqcxyl4ZelKcKmm/yqavzAJurEv0Y+ddGfgpF7xy/YI2jFCEcRMpZWzJ2DOSER
Duu31lV6LtPAvbr9kro7EO76xMnbc+BX5aszXm3GS7t16XFWOraxbI7FxSXAsTZM
22T7n5rA4SK5/UWzOg7rlqloMvb/OWXWOj3f7xEHjBcuGfO/0aR731dps7mOsaOo
Y9HHXy73H6a8eVgwCfL3PX/jWNJbUkZxGEfwZfl77mLNDWRm02GInYDwjqTZOZTA
7BbPseT2Bp60odpdxPHX0qRtHkJO8GzLVg8o4LXu4KfCWe10EgBctFBX9Mrte4i0
4bzy20D2mxlNA6YS9W6i+d5cq4AMtGRrw8H5cvLe/D6ia2sz/2rz5lUZuDy2CWoh
E/uy4r0TqZ8Yyr7iZZxkkOpUAl8CvLoDUGMAmjcMKEC8568gV6tYYqm47myOIqND
JGo6VhCzneXAgT4Ym5x1r0jAnopI3diSCM1Pqa/Tgtl9KPqEdQZCTNdQyw7/1j+r
t93FJ5lIIp2DXYA9f/3wZDLHayS8b0eqKICDQtDGRkwVrk7QuDGHsl6ZvYZneAnr
y+XI+PIGOO0zkS1XpRUSK0/tmKIk8Y2lptOlXzRrH7wWjh7pEIIKr7qeasBKdh/C
THiDFIrbjtXTl1ExZD8l
=zD1/
-----END PGP SIGNATURE-----

--Sig_/QNhP/RvH4IddlLkeWSlZOqO--
