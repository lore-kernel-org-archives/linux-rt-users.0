From: Andrey Gursky <andrey.gursky@e-mail.ua>
Subject: Re: Mitigation of license for the symbol =?utf-8?b?X19ydF9tdXRleF9pbml0?= and more
Date: Mon, 8 Aug 2011 11:09:57 +0000 (UTC)
Message-ID: <loom.20110808T130452-687@post.gmane.org>
References: <CABg52H=D6vGam6W-0EqFFuSVh8LA5ouaYHv0wknVYzY0G0hh6w@mail.gmail.com> <20110808063006.GU31521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46470 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab1HHLPJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 07:15:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1QqNnX-0000hm-P0
	for linux-rt-users@vger.kernel.org; Mon, 08 Aug 2011 13:15:08 +0200
Received: from 1Cust29.tnt2.hdn1.deu.da.uu.net ([149.225.62.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Aug 2011 13:15:07 +0200
Received: from andrey.gursky by 1Cust29.tnt2.hdn1.deu.da.uu.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Aug 2011 13:15:07 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig <at> pengutronix.de> writes:

>=20
> On Mon, Aug 08, 2011 at 01:10:22AM +0200, Andrey Gursky wrote:
> > Hi!
> >=20
> > Since coming of the linux-3.0-rt patch I've decided to try to switc=
h
> > to that kernel, especially the goal of the RT_PREEMPT claims to mak=
e a
> > desktop kernel become a realtime one. Thanks to all rt-developers f=
or
> > this opportunity!
> >=20
> > I'm testing it on 3 platforms:
> > 1) notebook Core2Duo T7250,
> > 2) old Pentium 4 3.2 GHz with an old passive ISDN hisax-card,
> > 3) even older AthlonXP 2.8 GHz with TV-tuner.
> >=20
> > The first desktop problem is:
> > the symbol __rt_mutex_init is exported as GPL-only. This make the
> > usage of proprietary nvidia driver impossible, while the normal
> > __mutex_init is not only GPL. Could you change the license also for
> > the rt_mutex_init (...and maybe few more if they being linked with
> > nvidia/ati(?) driver just as with the vanilla "desktop" kernel)?
> >=20
> > The next issue is more complicated. On the P4 (platform 2) I use an
> > ISDN-hisax modem card and per-second internet account. After a time=
out
> > the connection is being hung up. In firefox I have a lot of tabs. S=
ome
> > web pages are "active". They try to call back on their own. While t=
his
> > is happening my gnome freezes sometimes. SysRq-R helps sometimes to
> > switch back to the console. But the gdm doesn't start anymore. Is t=
his
> > a relevant issue for the rt-project? What'd be the first place to l=
ook
> > at to debug this behavior?
> enable PROVE_LOCKING and see if that claims to find something. You mi=
ght
> have to setup netconsole for that to work.

As of 3.0-rt3 the NETCONSOLE depends on !PREEMPT_RT_FULL [=3Dy], so I c=
ouldn't
enable it. I've tried to satisfy the dependencies of NETCONSOLE_DYNAMIC=
:
Depends on: NETDEVICES [=3Dy] && NETCONSOLE [=3Dn] && SYSFS [=3Dy] && C=
ONFIGFS_FS [=3Dy]
&& (NETCONSOLE [=3Dn]!=3Dy || CONFIGFS_FS [=3Dy]!=3Dm)
Despite I have NETDEVICES=3Dy, SYSFS=3Dy, CONFIGFS_FS=3Dy and NETCONSOL=
E doesn't
appear in .config, it is impossible to turn on the NETCONSOLE_DYNAMIC.

Regards,
Andrey

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
