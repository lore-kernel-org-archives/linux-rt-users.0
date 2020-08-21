Return-Path: <SRS0=gFqs=B7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D71C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F86420FC3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Aug 2020 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598039259;
	bh=S6dcRAdeTpUdhqBralYNBKRs92bvR5wAJJq1s5WcS70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=rdHtpogvWkV24QbQoJ23y82nt7xUAjfdZpMkP4IyvIyn83PGvXJn5MFYE2LxTOJOd
	 838qHToRgRAy4XQh0RNQtL7qDxjv/X3RTV+gvklUXU4CZtUXPkcpflcaL/yrabEQFA
	 PiFmvN1L0dgcIgkiBlIIbQ/G/lgdgo7U95ffgAlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHUTre (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgHUTrK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:10 -0400
Received: from localhost.localdomain (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4399207BB;
        Fri, 21 Aug 2020 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598039229;
        bh=S6dcRAdeTpUdhqBralYNBKRs92bvR5wAJJq1s5WcS70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=umhRCS1Kl07lT3+NNeROkgKekyNrIwxAmSo1a7/CnyH7pkY7OHda+JObTUT4VYvXu
         DF7aTbG6NpKJm0wpZJ4sUoI0AuVXcPtCvFxxRpj76Ac37Q3YUoCjtgwWrQQNlx1BA1
         eCvZb8l11X9Kq9tD7D4pgzR4wkh7+YhjKNcPHYTo=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH RT 3/5] net: phy: fixed_phy: Remove unused seqcount
Date:   Fri, 21 Aug 2020 14:47:02 -0500
Message-Id: <31cc35dc4938fe8f94631327ab9e9966de09dd50.1598039186.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
In-Reply-To: <cover.1598039186.git.zanussi@kernel.org>
References: <cover.1598039186.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

v4.19.135-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 6554eac9ef2bd1c968886b31cc7266b49258a463 ]

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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 drivers/net/phy/fixed_phy.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 59820164502e..953ff54dd5df 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/gpio.h>
-#include <linux/seqlock.h>
 #include <linux/idr.h>
 
 #include "swphy.h"
@@ -36,7 +35,6 @@ struct fixed_mdio_bus {
 struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
-	seqcount_t seqcount;
 	struct fixed_phy_status status;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
 	struct list_head node;
@@ -62,18 +60,15 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
 			struct fixed_phy_status state;
-			int s;
-
-			do {
-				s = read_seqcount_begin(&fp->seqcount);
-				/* Issue callback if user registered it. */
-				if (fp->link_update)
-					fp->link_update(fp->phydev->attached_dev,
-							&fp->status);
-				/* Check the GPIO for change in status */
-				fixed_phy_update(fp);
-				state = fp->status;
-			} while (read_seqcount_retry(&fp->seqcount, s));
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
@@ -131,8 +126,6 @@ int fixed_phy_add(unsigned int irq, int phy_addr,
 	if (!fp)
 		return -ENOMEM;
 
-	seqcount_init(&fp->seqcount);
-
 	if (irq != PHY_POLL)
 		fmb->mii_bus->irq[phy_addr] = irq;
 
-- 
2.17.1

