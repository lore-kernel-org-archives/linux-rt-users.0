Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8BC433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiDSQr4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiDSQn5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601543134D
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:41:14 -0700 (PDT)
Date:   Tue, 19 Apr 2022 18:41:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650386471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PIXnoP6gxOvi4ohiwRlml6GOKs2jxoyVwD0AND9pFDo=;
        b=YKlCzBZ2BDy5daAf6mv7g5mN00OFjU57ruqkdnc6D109PoOAFw+UvWVq9uoDatQyrXDeT4
        5hFY+X+3i5TvUxftm+Br0CAjH/NvBxDIJ8JAwyfB9BTvQ/RuYggqjq5eJ7wCzSPSI8V1P/
        q0rkmIVllWE7mf//4iZB6XZIXZx5VTxE9TNBgp7GHa/u3W9t7NWXEEQkYdhO3RgKLOq9sM
        MpBCd7ntUNTAPTpShvrtqR0wix72aA/R7gtvR8rQZR3GenmK2fZkHhxKUVTPAn8/jhaT9k
        ZOG3DV8n3H8/wpChaSQe5KlZOY27cG/MtwWhmsa/8DnHoxS3jBQdelyY0mev3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650386471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PIXnoP6gxOvi4ohiwRlml6GOKs2jxoyVwD0AND9pFDo=;
        b=21sKMKW80VH8ibuFuaH8A9KEbMuznPZzScmfS9nlDen1ACUD+mClPrD5UUGzOA75m+Ft3X
        6GuuLUATAJdhkBBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT v4.19-RT] genirq: Add lost hunk to irq_forced_thread_fn().
Message-ID: <Yl7mJiGXABN+8UKa@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The irq_settings_no_softirq_call() related handling got lost in process,
here are the missing bits.

Reported-by: Martin Kaistra <martin.kaistra@linutronix.de>
Fixes: b0cf5c230e2a0 ("Merge tag 'v4.19.183' into linux-4.19.y-rt")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The irq_settings_no_softirq_call() related bits were removed in
v5.0.21-rt13. All previous kernel version should keep it.

 kernel/irq/manage.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c21bd00f0cc30..7e0c9006be171 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -998,7 +998,15 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	irq_finalize_oneshot(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
 		local_irq_enable();
-	local_bh_enable();
+	/*
+	 * Interrupts which have real time requirements can be set up
+	 * to avoid softirq processing in the thread handler. This is
+	 * safe as these interrupts do not raise soft interrupts.
+	 */
+	if (irq_settings_no_softirq_call(desc))
+		_local_bh_enable();
+	else
+		local_bh_enable();
 	return ret;
 }
 
-- 
2.35.2
