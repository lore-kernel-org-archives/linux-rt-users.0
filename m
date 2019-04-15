Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BBFC10F12
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABBB20880
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfDOUQD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfDOUQD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 16:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40ECC59454;
        Mon, 15 Apr 2019 20:16:03 +0000 (UTC)
Received: from amt.cnet (ovpn-112-12.gru2.redhat.com [10.97.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85426013A;
        Mon, 15 Apr 2019 20:15:58 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 55BB9105194;
        Mon, 15 Apr 2019 17:15:39 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x3FKFdTo013913;
        Mon, 15 Apr 2019 17:15:39 -0300
Message-Id: <20190415201429.499455390@amt.cnet>
User-Agent: quilt/0.60-1
Date:   Mon, 15 Apr 2019 17:12:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/3] timers: condense pending bitmap information
References: <20190415201213.600254019@amt.cnet>
Content-Disposition: inline; filename=03-optimize-pending-map-check
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Apr 2019 20:16:03 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Condense the pending bitmap information in a bool.

Improves cyclictest results by 4us.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 kernel/time/timer.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-rt-devel/kernel/time/timer.c
===================================================================
--- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 14:22:56.000000000 -0300
+++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:24:24.803312280 -0300
@@ -206,6 +206,7 @@
 	unsigned int		cpu;
 	bool			is_idle;
 	bool			must_forward_clk;
+	bool			pending_map_clear;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -538,6 +539,7 @@
 {
 	hlist_add_head(&timer->entry, base->vectors + idx);
 	__set_bit(idx, base->pending_map);
+	base->pending_map_clear = false;
 	timer_set_idx(timer, idx);
 }
 
@@ -1741,6 +1743,9 @@
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER) &&
+	    bitmap_empty(base->pending_map, WHEEL_SIZE))
+		base->pending_map_clear = true;
 	raw_spin_unlock_irq(&base->lock);
 	wakeup_timer_waiters(base);
 }
@@ -1784,10 +1789,10 @@
 #endif
 	base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER)) {
-		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
+		if (!base->pending_map_clear)
 			goto raise;
 		base++;
-		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
+		if (!base->pending_map_clear)
 			goto raise;
 
 		return;


