From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 02 Feb 2012 13:10:45 -0500
Message-ID: <1328206245.5882.113.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
	 <201202021338.44950.tim.sander@hbm.com> <4F2A8850.4080201@digi.com>
	 <201202021525.05606.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:35084 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503Ab2BBSKr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 13:10:47 -0500
In-Reply-To: <201202021525.05606.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-02-02 at 15:25 +0100, Tim Sander wrote:
> > 
> > I'm working on an i.MX51 and using the fec.c driver as well. Interesting
> > that it is not happening on x86.
> Well, at least no one else spoke out on this problem before
> 

I'm thinking that fec.c is not available for x86, as it seems that the
dependencies don't allow it to be enabled.

That said, as I think I know the problem, can you try this patch to see
if it fixes things. This patch is a TOTAL HACK! Not for inclusion. It's
racy and buggy. I didn't even compile it because I couldn't get the
configs to enable FEC, and I was too lazy to set up my cross compiler to
test it. ;-)

-- Steve

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 885d8ba..9368dc2 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -231,6 +231,9 @@ static void *swap_buffer(void *bufaddr, int len)
 	return bufaddr;
 }
 
+static DECLARE_COMPLETION(kick_ksoftirq);
+static int comp_set;
+
 static netdev_tx_t
 fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -243,6 +246,9 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	unsigned long flags;
 
 	if (!fep->link) {
+		if (comp_set)
+			wait_for_completion(&kick_ksoftirq);
+
 		/* Link is down or autonegotiation is in progress. */
 		return NETDEV_TX_BUSY;
 	}
@@ -794,6 +800,8 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 	/* Link on or off change */
 	if (phy_dev->link != fep->link) {
 		fep->link = phy_dev->link;
+		complete(&kick_ksoftirq);
+		comp_set = 0;
 		if (phy_dev->link)
 			fec_restart(ndev, phy_dev->duplex);
 		else
@@ -914,6 +922,9 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	fep->link = 0;
 	fep->full_duplex = 0;
 
+	init_completion(&kick_ksoftirq);
+	comp_set = 1;
+
 	printk(KERN_INFO "%s: Freescale FEC PHY driver [%s] "
 		"(mii_bus:phy_addr=%s, irq=%d)\n", ndev->name,
 		fep->phy_dev->drv->name, dev_name(&fep->phy_dev->dev),


