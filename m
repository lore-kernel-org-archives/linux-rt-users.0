Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2808CC10DCE
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001762084E
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCFSkz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgCFSky (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8F42072D;
        Fri,  6 Mar 2020 18:40:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jAHu0-002e0Y-Qy; Fri, 06 Mar 2020 13:40:52 -0500
Message-Id: <20200306184052.697292686@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 13:40:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 6/8] drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
References: <20200306184035.948924528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.106-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit b901491e7b9b7a676818d84e482b69be72fc142f ]

vmw_fifo_ping_host() disables preemption around a test and a register
write via vmw_write(). The write function acquires a spinlock_t typed
lock which is not allowed in a preempt_disable()ed section on
PREEMPT_RT. This has been reported in the bugzilla.

It has been explained by Thomas Hellstrom that this preempt_disable()ed
section is not required for correctness.

Remove the preempt_disable() section.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206591
Link: https://lkml.kernel.org/r/0b5e1c65d89951de993deab06d1d197b40fd67aa.camel@vmware.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
index d0fd147ef75f..fb5a3461bb8c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
@@ -167,10 +167,8 @@ void vmw_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
 {
 	u32 *fifo_mem = dev_priv->mmio_virt;
 
-	preempt_disable();
 	if (cmpxchg(fifo_mem + SVGA_FIFO_BUSY, 0, 1) == 0)
 		vmw_write(dev_priv, SVGA_REG_SYNC, reason);
-	preempt_enable();
 }
 
 void vmw_fifo_release(struct vmw_private *dev_priv, struct vmw_fifo_state *fifo)
-- 
2.25.0


