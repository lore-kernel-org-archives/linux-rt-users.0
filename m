Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF7C433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C7621775
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHMBqC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgHMBp5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E191521744;
        Thu, 13 Aug 2020 01:45:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JX-00751A-Uo; Wed, 12 Aug 2020 21:45:55 -0400
Message-ID: <20200813014555.844225670@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH RT 4/6] net: phy: fixed_phy: Remove unused seqcount
References: <20200813014534.833107526@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.54-rt33-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

Commit bf7afb29d545 ("phy: improve safety of fixed-phy MII register
reading") protected the fixed PHY status with a sequence counter.

Two years later, commit d2b977939b18 ("net: phy: fixed-phy: remove
fixed_phy_update_state()") removed the sequence counter's write side
critical section -- neutralizing its read side retry loop.

Remove the unused seqcount.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from v5.8-rc1 commit 79cbb6bc3332da7162c2581e151659ab8ebaa528)
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/net/phy/fixed_phy.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 4190f9ed5313..9ed715e9be40 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
-#include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
 #include <linux/linkmode.h>
@@ -34,7 +33,6 @@ struct fixed_mdio_bus {
 struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
-	seqcount_t seqcount;
 	struct fixed_phy_status status;
 	bool no_carrier;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
@@ -80,19 +78,17 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
 			struct fixed_phy_status state;
-			int s;
-
-			do {
-				s = read_seqcount_begin(&fp->seqcount);
-				fp->status.link = !fp->no_carrier;
-				/* Issue callback if user registered it. */
-				if (fp->link_update)
-					fp->link_update(fp->phydev->attached_dev,
-							&fp->status);
-				/* Check the GPIO for change in status */
-				fixed_phy_update(fp);
-				state = fp->status;
-			} while (read_seqcount_retry(&fp->seqcount, s));
+
+			fp->status.link = !fp->no_carrier;
+
+			/* Issue callback if user registered it. */
+			if (fp->link_update)
+				fp->link_update(fp->phydev->attached_dev,
+						&fp->status);
+
+			/* Check the GPIO for change in status */
+			fixed_phy_update(fp);
+			state = fp->status;
 
 			return swphy_read_reg(reg_num, &state);
 		}
@@ -150,8 +146,6 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
 	if (!fp)
 		return -ENOMEM;
 
-	seqcount_init(&fp->seqcount);
-
 	if (irq != PHY_POLL)
 		fmb->mii_bus->irq[phy_addr] = irq;
 
-- 
2.28.0


