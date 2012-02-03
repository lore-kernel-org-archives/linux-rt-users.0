From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 17:14:38 +0100
Message-ID: <4F2C07EE.10408@digi.com>
References: <4F292FE0.7090302@digi.com> <201202021338.44950.tim.sander@hbm.com> <20120202201336.GF25594@pengutronix.de> <4F2BB59C.4080206@digi.com> <20120203103520.GI25594@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Sander <tim.sander@hbm.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"efault@gmx.de" <efault@gmx.de>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail210.messagelabs.com ([216.82.250.179]:50861 "EHLO
	mail210.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2BCQOn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 11:14:43 -0500
In-Reply-To: <20120203103520.GI25594@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe,

On 02/03/2012 11:35 AM, Uwe Kleine-K=F6nig wrote:
>> On my ARM iMX51 platform the problem occurs on every boot. Basically
>> I'm launching udhcpc on the /etc/network/if-up.d/ifup script, to get
>> a dynamic IP for the FEC.
> Maybe your environment is special then (pick one or more from: board,
> cable, phy, hub/switch, sun erruption, ice cream on your board or you=
r
> favourite hardware designer :-).

No ice cream this time, promised!

> As the problem occurs for you on every boot you seem to be the one wh=
o
> can debug that easily. Can you check if mainline is affected, too, af=
ter
> boosting ksoftirqd? I.e. either use
>
> 	chrt -f -p 99 $(pidof ksoftirqd)
>
> or add
 > diff --git a/kernel/softirq.c b/kernel/softirq.c
 > index 4eb3a0f..d08c046 100644
 > --- a/kernel/softirq.c
 > +++ b/kernel/softirq.c
 > @@ -861,6 +861,10 @@ static int __cpuinit cpu_callback(struct notifi=
er_block *nfb,
 >   			printk("ksoftirqd for %i failed\n", hotcpu);
 >   			return notifier_from_errno(PTR_ERR(p));
 >   		}
 > +		sched_setscheduler_nocheck(p, SCHED_FIFO,&(struct sched_param){
 > +				.sched_priority =3D MAX_RT_PRIO-1,
 > +				});
 > +
 >   		kthread_bind(p, hotcpu);
 >     		per_cpu(ksoftirqd, hotcpu) =3D p;
 >    		break;

I added this patch and the problem was reproducible in 2.6.31.14. with =
=46reescale's=20
2.6.31 BSP, but not on 2.6.35.15 with Freescale's 2.6.35 BSP.

So I revised the differences in the driver and 'git blame' showed me th=
is commit=20
(Freescale's BSP for 2.6.35), which solves the problem:

commit bac5b435af4656802d3555aaeee983ae8fe5c96a
Author: Frank Li <Frank.Li@freescale.com>
Date:   Fri Dec 10 18:59:07 2010 +0800

     ENGR00136218 FEC: Fix dhcp fail when enable preempt at mx28

     DHCP fail when enable NO_HZ and preempt at mx28evk

     Signed-off-by: Zeng Zhaoming <b32542@freescale.com>
     Signed-off-by: Frank Li <Frank.Li@freescale.com>

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index e3ce064..f581960 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -253,6 +253,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net=
_device *dev)

         if (!fep->link) {
                 /* Link is down or autonegotiation is in progress. */
+               netif_stop_queue(dev);
                 return NETDEV_TX_BUSY;
         }

@@ -681,6 +682,7 @@ static void fec_enet_adjust_link(struct net_device =
*dev)
         if (phy_dev->link) {
                 if (fep->full_duplex !=3D phy_dev->duplex) {
                         fec_restart(dev, phy_dev->duplex);
+                       netif_wake_queue(dev);
                         status_change =3D 1;
                 }
         }
@@ -1418,6 +1420,8 @@ fec_stop(struct net_device *dev)
         if (fep->ptimer_present)
                 fec_ptp_stop(fep->ptp_priv);
         writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+
+       fep->link =3D 0;
  }

  static int __devinit


This commit was not merged to mainline kernel. So I tried again with 2.=
6.35.14 with=20
=46reescale's BSP and Uwe's patch and reverted commit bac5b435 for veri=
fication. The=20
problem was reproducible so the above patch solves it.
Do you see any caveat with this commit? If not maybe it should make its=
 way to mainline.

Regards
--=20
H=E9ctor Palacios
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
