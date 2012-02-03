From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 11:35:20 +0100
Message-ID: <20120203103520.GI25594@pengutronix.de>
References: <4F292FE0.7090302@digi.com>
 <201202021338.44950.tim.sander@hbm.com>
 <20120202201336.GF25594@pengutronix.de>
 <4F2BB59C.4080206@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Sander <tim.sander@hbm.com>, linux-rt-users@vger.kernel.org,
	lclaudio@uudg.org, rostedt@goodmis.org, efault@gmx.de
To: Hector Palacios <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45137 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab2BCKfZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 05:35:25 -0500
Content-Disposition: inline
In-Reply-To: <4F2BB59C.4080206@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Hector,

On Fri, Feb 03, 2012 at 11:23:24AM +0100, Hector Palacios wrote:
> On 02/02/2012 09:13 PM, Uwe Kleine-K=F6nig wrote:
> >On Thu, Feb 02, 2012 at 01:38:44PM +0100, Tim Sander wrote:
> >>Hi
> >>>When booting my platform with DHCP on, the DHCP request is sent by=
 the
> >>>network driver before the PHY has even started the autonegotiation=
=2E
> >>>Since the PHY is not ready, the TX interrupt returns with NETDEV_T=
X_BUSY
> >>>but the softirq [sirq-net-tx] seems to have entered an infinite sp=
in, as
> >>>my system is practically hung and 'top' reveals [sirq-net-tx/0] is
> >>>consuming 95% of CPU. This is preventing the PHY autonegotiation (=
which is
> >>>scheduled as a delayed work) to start, so the PHY is never ready a=
nd the
> >>>packet never reaches the network.
> >>Mh, i think i am hit by the same problem. I have a i.mx 35 and when=
 dhcp is
> >>enabled the ksoftirq is also running wild with 3.0-rt. This also ha=
ppens when
> >I fail to reproduce that on a pcm043 machine using 3.0.18-rt34. Can =
you
> >provide me your config. Does the problem occur on every boot for you=
? If
> >not, how often do I need to reboot?
>=20
> On my ARM iMX51 platform the problem occurs on every boot. Basically
> I'm launching udhcpc on the /etc/network/if-up.d/ifup script, to get
> a dynamic IP for the FEC.
Maybe your environment is special then (pick one or more from: board,
cable, phy, hub/switch, sun erruption, ice cream on your board or your
favourite hardware designer :-).

As the problem occurs for you on every boot you seem to be the one who
can debug that easily. Can you check if mainline is affected, too, afte=
r
boosting ksoftirqd? I.e. either use

	chrt -f -p 99 $(pidof ksoftirqd)

or add

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4eb3a0f..d08c046 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -861,6 +861,10 @@ static int __cpuinit cpu_callback(struct notifier_=
block *nfb,
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return notifier_from_errno(PTR_ERR(p));
 		}
+		sched_setscheduler_nocheck(p, SCHED_FIFO, &(struct sched_param){
+				.sched_priority =3D MAX_RT_PRIO-1,
+				});
+
 		kthread_bind(p, hotcpu);
   		per_cpu(ksoftirqd, hotcpu) =3D p;
  		break;

to your tree, whatever is easier for you.

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
