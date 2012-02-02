From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 00:44:10 +0100
Message-ID: <201202030044.10516.tim01@vlsi.informatik.tu-darmstadt.de>
References: <4F292FE0.7090302@digi.com> <20120202201336.GF25594@pengutronix.de> <1328218466.5882.119.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Uwe =?iso-8859-15?q?Kleine-K=F6nig?="
	<u.kleine-koenig@pengutronix.de>, Tim Sander <tim.sander@hbm.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org, efault@gmx.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:39890 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756743Ab2BBXoZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 18:44:25 -0500
In-Reply-To: <1328218466.5882.119.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Guys

Am Donnerstag 02 Februar 2012, 22:34:26 schrieb Steven Rostedt:
> On Thu, 2012-02-02 at 21:13 +0100, Uwe Kleine-K=F6nig wrote:
> > enabled the ksoftirq is also running wild with 3.0-rt. This also ha=
ppens
> > when I fail to reproduce that on a pcm043 machine using 3.0.18-rt34=
=2E Can
> > you provide me your config. Does the problem occur on every boot fo=
r
> > you? If not, how often do I need to reboot?
>=20
> Note, you also said (on IRC) that you boot off this card via NFS root=
=2E
> I'm not sure Tim has the same setup, and that may be a big difference=
 in
> how this bug comes about.
>=20
> It's a race issue, and it may require enabling the network interface
> after the system is up and running.
Its indeed a race and it is most of the time only triggered when ubifs =
is=20
attached or the ubifs worker thread is active in background. The error =
must be=20
there sleeping for at least 2.6.31. We where using 2.6.33-rt (if i reme=
mber=20
correctly) and it might occoured once but i wasn't sure back then. Whic=
h lead=20
me to the complete wrong direction that ubi was at fault. The bug occur=
s only=20
very seldom with static ip addresses configured. So dhcp is needed to=20
reproduce this bug more easily. Then i found out that connman is a good=
 way to=20
trigger this bug. So to trigger i started dhclient, connman and if it d=
idn't=20
show up i did some "ifconfig eth0 up/down" poking. But the first time i=
 had=20
the hw debugger wired it didn't show up for some reason even when i was=
 trying=20
to trigger it for an hour or so.

@Uwe: I am currently at home and its to late to fire my work computer u=
p.=20
You'll get the kconfig tomorrow... ahm later.
I will then also test the patch of Steve if i manage that before leavin=
g to=20
=46OSDEM :-).

Best regards
Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
