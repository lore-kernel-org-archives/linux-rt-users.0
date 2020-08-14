Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F629C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 22:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F0C208E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 22:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHNWyZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNWyZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 18:54:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DCC20838;
        Fri, 14 Aug 2020 22:54:23 +0000 (UTC)
Date:   Fri, 14 Aug 2020 18:54:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Question on 5.4.55 merge into 5.4-rt
Message-ID: <20200814185421.74b1ddc8@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


When merging 5.4.55 into 5.4-rt I hit the following conflict:

static void flush_backlog(struct work_struct *work)
{
	struct sk_buff *skb, *tmp;
	struct softnet_data *sd;

	local_bh_disable();
	sd = this_cpu_ptr(&softnet_data);

	local_irq_disable();
	rps_lock(sd);
	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
			__skb_unlink(skb, &sd->input_pkt_queue);
<<<<<<< HEAD
			__skb_queue_tail(&sd->tofree_queue, skb);
=======
			dev_kfree_skb_irq(skb);
>>>>>>> v5.4.55
			input_queue_head_incr(sd);
		}
	}

The diff of 5.4.54 -> 5.4.55 of this code is:

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5229,7 +5229,7 @@ static void flush_backlog(struct work_struct *work)
        skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
                if (skb->dev->reg_state == NETREG_UNREGISTERING) {
                        __skb_unlink(skb, &sd->input_pkt_queue);
-                       kfree_skb(skb);
+                       dev_kfree_skb_irq(skb);
                        input_queue_head_incr(sd);
                }
        }


From upstream commit:

7df5cb75cfb8a ("dev: Defer free of skbs in flush_backlog")

According to that commit, it looks like kfree_skb() shouldn't be called
with irqs disabled (yeah for RT!). It now calls dev_kfree_skb_irq()
which puts the skb on the softnet_data.completion_queue, and raises the
NET_TX_SOFTIRQ to do the freeing.


This is similar to what v5.4-rt does, which a diff of 5.4.54 -> v5.4-rt:

@@ -5229,7 +5234,7 @@ static void flush_backlog(struct work_struct *work)
        skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
                if (skb->dev->reg_state == NETREG_UNREGISTERING) {
                        __skb_unlink(skb, &sd->input_pkt_queue);
-                       kfree_skb(skb);
+                       __skb_queue_tail(&sd->tofree_queue, skb);
                        input_queue_head_incr(sd);
                }
        }
@@ -5239,11 +5244,14 @@ static void flush_backlog(struct work_struct *work)
        skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
                if (skb->dev->reg_state == NETREG_UNREGISTERING) {
                        __skb_unlink(skb, &sd->process_queue);
-                       kfree_skb(skb);
+                       __skb_queue_tail(&sd->tofree_queue, skb);
                        input_queue_head_incr(sd);
                }
        }
+       if (!skb_queue_empty(&sd->tofree_queue))
+               raise_softirq_irqoff(NET_RX_SOFTIRQ);
        local_bh_enable();
+
 }


Where we are doing something slightly different. Placing the skb on the
sd->tofree_queue and raising NET_RX_SOFTIQ instead.

Now that the vanilla stable 5.4 kernel doesn't call kfree_skb() from
irqs_disabled, can I safely revert this entire change?

Is it safe to call kfree_skb() from local_bh_disable()?

I'm assuming it is, but just want to clarify. I'll be continuing
merging latest stable (with this revert), but please yell if you think
it will break?

Thanks!

-- Steve
