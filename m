From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Mon, 2 Apr 2007 21:04:45 +0200
Message-ID: <20070402190445.GB2081@elte.hu>
References: <040220071750.11488.461142790008679B00002CE02206424413979D9D0A9F9C0E0B@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Sperry <dave_sperry@ieee.org>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "dave_sperry@ieee.org" <dasperry@comcast.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51091 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965692AbXDBTE5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Apr 2007 15:04:57 -0400
Content-Disposition: inline
In-Reply-To: <040220071750.11488.461142790008679B00002CE02206424413979D9D0A9F9C0E0B@comcast.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* dave_sperry@ieee.org <dasperry@comcast.net> wrote:

> The Intel NIC seems to behave better under RT

yeah.

> I think there is some kind of bad behavior happening in the Nvidia 
> driver with respect to softirq-net-tx and IRQ-8406.

yes. Part of the problem is that the forcedeth.c driver does not fully 
support NAPI - today i've implemented those bits (see them below), based 
on your testcase. The other part is that the Intel NIC uses MSI, while 
foredeth uses fasteoi, correct? [you can see this in /proc/interrupts]

there are a few other things i'm working on to improve this. I've 
uploaded -rt9 which is the current state of affairs. Note that using 
-rt9 you'll likely only see IRQ-8406 overhead in the system, because 
i've added an optimization to do process the softirq-net-tx workload in 
the hardirq thread if the priority of the two is the same (which is the 
default behavior). But -rt9 is still work in progress that is not fully 
finished yet: in some cases i'm seeing 'fluctuating performance' 
problems on forcedeth that werent there before.

	Ingo

--------------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] forcedeth.c: improve NAPI handler

another forcedeth.c thing: i noticed that its NAPI handler does not do 
tx-ring processing. The patch below implements this - tested on 
DESC_VER_2 hardware, with CONFIG_FORCEDETH_NAPI=y.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/net/forcedeth.c
===================================================================
--- linux.orig/drivers/net/forcedeth.c
+++ linux/drivers/net/forcedeth.c
@@ -3118,9 +3118,17 @@ static int nv_napi_poll(struct net_devic
 	int retcode;
 
 	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		spin_lock_irqsave(&np->lock, flags);
+		nv_tx_done(dev);
+		spin_unlock_irqrestore(&np->lock, flags);
+
 		pkts = nv_rx_process(dev, limit);
 		retcode = nv_alloc_rx(dev);
 	} else {
+		spin_lock_irqsave(&np->lock, flags);
+		nv_tx_done_optimized(dev, np->tx_ring_size);
+		spin_unlock_irqrestore(&np->lock, flags);
+
 		pkts = nv_rx_process_optimized(dev, limit);
 		retcode = nv_alloc_rx_optimized(dev);
 	}
