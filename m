Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FAC10F25
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4951524679
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783312;
	bh=j9EFBRUeGEgaJou7VzJyPRqtYH74YJhWOcl/Fg2SBEc=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ZbRMFS9x5WY/hniQ0y05lOLA2gLwfcYJ00X0uKLLbIqinJMsCL33sQznnDiQqUiHH
	 hWnMLt+YMwhF6axLGqHik5SG6Ou8x7D2mil6NfI4BwxTnFdctySqhq+4ueFUgdBR3f
	 zKgChQ3xaxmQsMWKw+08pgRnOgh267ShBgx0AhEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCITsb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCITsV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:21 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2891024677;
        Mon,  9 Mar 2020 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783300;
        bh=j9EFBRUeGEgaJou7VzJyPRqtYH74YJhWOcl/Fg2SBEc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=N76Iv7B7LuNwOci4o5wYZZxDF9JgCRR1cIZi+Ds659KD/vHryPrcf/0tAyu8nu0Ze
         BVfnOmuEmjzAPzAHUmYaL3qUSdkILHqs5YFKpYS9oc3qZI/qGm28fDzveS68lvR8vv
         xnBiTSLAFYOrCt9VIUZ+h2Q+8/StGW05GKFnkuis=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 6/8] drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
Date:   Mon,  9 Mar 2020 14:47:51 -0500
Message-Id: <7b50a4187b38dd305b91907c235c2382cc87bca1.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
index a1c68e6a689e3..713f202fca2cd 100644
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
2.14.1

