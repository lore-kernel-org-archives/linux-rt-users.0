Return-Path: <SRS0=BfXC=CG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D357C433E2
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347E3208D5
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Aug 2020 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598631336;
	bh=3u/LPNb0fGuW7vBTTs5VHyvcaV1t8KUbPhUALXc8e3A=;
	h=Subject:From:To:Date:List-ID:From;
	b=Cex2dMgw/AC33ktJudYvy5UmTG21UgG4zzrG6zaYBSl3pEN06EOG6YoDSMqrDK7k/
	 fm45qbh6qh4+2t4PNM1G1caC+w/pyORGaj2Tc0IanPtPBhcnS9sppeUm0tj/eny7/C
	 f9Xpzef3cGBPVZLdzg2GRer1/yN/x97YvxEPikF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgH1QP3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1QPY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Aug 2020 12:15:24 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B897208C9;
        Fri, 28 Aug 2020 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598631323;
        bh=3u/LPNb0fGuW7vBTTs5VHyvcaV1t8KUbPhUALXc8e3A=;
        h=Subject:From:To:Date:From;
        b=z7XR+qqDgFv6kiaduZRACjyssqnRHdiXbynU9kznA9RFxfdhNS7hE8cK45w8Xnr+o
         yuVvhecroVBZacR0B0zlbU+jhqBudOu3OxLV3SxFomDDY93C2JvtIxzfUs0TAgaaE+
         8uNVxMZ19VafX+S4OHZlymUk6W/WBlZlL+sn5z4o=
Message-ID: <e23cc4a1d0678083ed3304565e663c9ad9a6f1f8.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.135-rt61
From:   Tom Zanussi <zanussi@kernel.org>
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
Date:   Fri, 28 Aug 2020 11:15:21 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.135-rt61 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 237039436c788beac75762aafe7a377a8498342f

Or to build 4.19.135-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.135.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.135-rt61.patch.xz


You can also build from 4.19.135-rt60 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.135-rt60-rt61.patch.xz

Enjoy!

   Tom

Changes from v4.19.135-rt60:
---

Ahmed S. Darwish (1):
      net: phy: fixed_phy: Remove unused seqcount

Davidlohr Bueso (1):
      net: xfrm: fix compress vs decompress serialization

Matt Fleming (1):
      signal: Prevent double-free of user struct

Sebastian Andrzej Siewior (1):
      Bluetooth: Acquire sk_lock.slock without disabling interrupts

Tom Zanussi (1):
      Linux 4.19.135-rt61
---
drivers/net/phy/fixed_phy.c | 25 +++++++++----------------
 kernel/signal.c             |  4 ++--
 localversion-rt             |  2 +-
 net/bluetooth/rfcomm/sock.c |  7 ++-----
 net/xfrm/xfrm_ipcomp.c      | 21 +++++++++++++++------
 5 files changed, 29 insertions(+), 30 deletions(-)
---
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
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 45748993f777..05c9b5a6b3ae 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -488,8 +488,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
diff --git a/localversion-rt b/localversion-rt
index 66fa05e70f29..9b7de9345ef4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt60
+-rt61
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index c044ff2f73e6..75bc8102cdd7 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -64,15 +64,13 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk = d->owner, *parent;
-	unsigned long flags;
 
 	if (!sk)
 		return;
 
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
 
-	local_irq_save(flags);
-	bh_lock_sock(sk);
+	spin_lock_bh(&sk->sk_lock.slock);
 
 	if (err)
 		sk->sk_err = err;
@@ -93,8 +91,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		sk->sk_state_change(sk);
 	}
 
-	bh_unlock_sock(sk);
-	local_irq_restore(flags);
+	spin_unlock_bh(&sk->sk_lock.slock);
 
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a00ec715aa46..a97997385423 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/locallock.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -36,6 +37,7 @@ struct ipcomp_tfms {
 
 static DEFINE_MUTEX(ipcomp_resource_mutex);
 static void * __percpu *ipcomp_scratches;
+static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
 static int ipcomp_scratch_users;
 static LIST_HEAD(ipcomp_tfms_list);
 
@@ -45,12 +47,15 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	const int plen = skb->len;
 	int dlen = IPCOMP_SCRATCH_SIZE;
 	const u8 *start = skb->data;
-	const int cpu = get_cpu();
-	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);
-	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
-	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
-	int len;
+	u8 *scratch;
+	struct crypto_comp *tfm;
+	int err, len;
+
+	local_lock(ipcomp_scratches_lock);
 
+	scratch = *this_cpu_ptr(ipcomp_scratches);
+	tfm = *this_cpu_ptr(ipcd->tfms);
+	err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
 	if (err)
 		goto out;
 
@@ -103,7 +108,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	err = 0;
 
 out:
-	put_cpu();
+	local_unlock(ipcomp_scratches_lock);
 	return err;
 }
 
@@ -146,6 +151,8 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
+	local_lock(ipcomp_scratches_lock);
+
 	scratch = *this_cpu_ptr(ipcomp_scratches);
 	tfm = *this_cpu_ptr(ipcd->tfms);
 	err = crypto_comp_compress(tfm, start, plen, scratch, &dlen);
@@ -158,12 +165,14 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 
 	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
 	return 0;
 
 out:
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 	return err;
 }

