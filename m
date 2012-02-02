From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 21:13:36 +0100
Message-ID: <20120202201336.GF25594@pengutronix.de>
References: <4F292FE0.7090302@digi.com>
 <201202021338.44950.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org,
	rostedt@goodmis.org, efault@gmx.de
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45924 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab2BBUNo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 15:13:44 -0500
Content-Disposition: inline
In-Reply-To: <201202021338.44950.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Tim,

On Thu, Feb 02, 2012 at 01:38:44PM +0100, Tim Sander wrote:
> Hi
> > When booting my platform with DHCP on, the DHCP request is sent by =
the
> > network driver before the PHY has even started the autonegotiation.
> > Since the PHY is not ready, the TX interrupt returns with NETDEV_TX=
_BUSY
> > but the softirq [sirq-net-tx] seems to have entered an infinite spi=
n, as
> > my system is practically hung and 'top' reveals [sirq-net-tx/0] is
> > consuming 95% of CPU. This is preventing the PHY autonegotiation (w=
hich is
> > scheduled as a delayed work) to start, so the PHY is never ready an=
d the
> > packet never reaches the network.
> Mh, i think i am hit by the same problem. I have a i.mx 35 and when d=
hcp is
> enabled the ksoftirq is also running wild with 3.0-rt. This also happ=
ens when
I fail to reproduce that on a pcm043 machine using 3.0.18-rt34. Can you
provide me your config. Does the problem occur on every boot for you? I=
f
not, how often do I need to reboot?

@Hector: Greeting to Spain. I don't have an imx51 machine handy, but
your config and your answers on my questions might help, too.

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
