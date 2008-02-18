From: Dominique Michel <dominique.michel@citycable.ch>
Subject: Re: cyclictest?
Date: Mon, 18 Feb 2008 19:23:04 +0100
Message-ID: <20080218192304.175b9186@citycable.ch>
References: <5bdc1c8b0801101634j583da294k319dbaa55405f26e@mail.gmail.com>
	<5bdc1c8b0801101650x3984d726j7fb69c7405dd121f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.110]:58100 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751141AbYBRSWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 13:22:38 -0500
In-Reply-To: <5bdc1c8b0801101650x3984d726j7fb69c7405dd121f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le Thu, 10 Jan 2008 16:50:06 -0800,
"Mark Knecht" <markknecht@gmail.com> a =C3=A9crit :

> On Jan 10, 2008 4:34 PM, Mark Knecht <markknecht@gmail.com> wrote:
> > Hi,
> >    I hadn't heard of cyclictest before an email today. I guess as a
> > user instead of a developer I don't pay much attention.
> >
> >    Can someone point me toward directions for building this on a Ge=
ntoo
> > machine?
> >
> > Thanks,
> > Mark
> >

On gentoo, you have 2 choices: To follow the install procedure in the t=
arball
and install the software in /usr/local or in ~/somewhere, or to do your=
 own
ebuild and install it in /usr.

The advantages of making an ebuild are that portage will take care of t=
his
package like any other program and that in case of upgrade, it will be =
very
little work to do in order to upgrade (in many cases, it is just to bum=
p the
ebuild, that is to rename it with the new version number and redigest i=
t).

To make the ebuild:=20
ebuild howto:
http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml?part=3D2&cha=
p=3D1
gentoo devmanual: http://devmanual.gentoo.org/ The devman is a very goo=
d
reading. Even if you don't want to do an ebuild, the chapter on the ext=
ernal
tools that portage can use (tools like sed) contain the best short intr=
oduction
I know for those tools.

To place your ebuild in portage:
http://gentoo-wiki.com/HOWTO_Installing_3rd_Party_Ebuilds
This howto use /usr/local/portage. I prefer /usr/portage/local. But it =
is just
a detail.=20

To publish your ebuild, 2 solutions: -make a bug report asking for a ne=
w soft
in portage and join the ebuild. Peoples doing a search on bugzilla will=
 find it
even if it never reach portage.
- put it into the sunrise
overlay: http://gentoo-wiki.com/Portage_Overlay_Listing#Sunrise_-_Gento=
o_User_Overlay

Dominique

>=20
> Browsing around I found this link:
>=20
> http://rt.wiki.kernel.org/index.php/Cyclictest
>=20
> But the link to get the tarball is stale. When I trace it through and
> get to the page it shows a
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests.git
>=20
> I found another email in Google that suggested running this command:
>=20
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests=
=2Egit
>=20
> which does download some source code. make built it but I'm not sure
> how to get any data.
>=20
> I found a Live CD at OSADL. Would that be a recommended way for me to
> look at my machine? I'm downloading it now.
>=20
> Thanks,
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Dominique Michel

Mes 3 projets pr=C3=A9f=C3=A9r=C3=A9s auxquels je contribue:
 * FVWM-Crystal, le bureau bas=C3=A9 sur FVWM:
      http://fvwm-crystal.org
 * AlsaPlayer, le lecteur audio avec contr=C3=B4le de vitesse en contin=
u:
      www.alsaplayer.org
 * L'overlay pour la MAO sous gentoo:
      http://proaudio.tuxfamily.org/wiki/index.php?title=3DMain_Page
