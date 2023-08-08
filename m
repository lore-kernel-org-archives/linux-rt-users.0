Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7473CC001B0
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjHHSoN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjHHSnu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C1535C48
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btESGQyGW30+CD7ijK4M2ODblSfINMK+UOhPhciC9Cc=;
        b=AKMjNfsRF8HVaWer31jtIBUm7mw0w2ete8J/+2NCOhrxsuRQKAJs9iKPVwcrGnMGdeSJbO
        LpAdqX20ohx9EWYUvKqbXS03PJwRlPKfIDzV2FxkVmXP14wer1cfq2c8/qO2DI/0hIDJZt
        7Kyt74yxQyy4GvL5EP05/8O58rXo34o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-E79WW3jyP3eGy5P-r_Uf3w-1; Tue, 08 Aug 2023 12:35:23 -0400
X-MC-Unique: E79WW3jyP3eGy5P-r_Uf3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 039DB101A528;
        Tue,  8 Aug 2023 16:35:23 +0000 (UTC)
Received: from localhost (unknown [10.22.32.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98B1240C6E8A;
        Tue,  8 Aug 2023 16:35:22 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Pribil?= <Andre.Pribil@hms-networks.com>
Subject: [PATCH RT 1/3] rt: timers: use CONFIG_PREEMPT_RT_FULL instead of CONFIG_PREEMPT_RT
Date:   Tue,  8 Aug 2023 13:35:18 -0300
Message-ID: <20230808163520.305842-2-lgoncalv@redhat.com>
In-Reply-To: <20230808163520.305842-1-lgoncalv@redhat.com>
References: <20230808163520.305842-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.14.320-rt152-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Commit 095ff4885a17 ("timers: Prepare support for PREEMPT_RT") had references
to CONFIG_PREEMPT_RT, that does not exist in v4.14-rt.

André Pribil reported that a tcdrain() call from userspace was spinning
forever due to an endless loop in del_timer_sync(). He was able to fix the
problem by Replacing CONFIG_PREEMPT_RT with CONFIG_PREEMPT_RT_FULL in that
code.

Reported-by: André Pribil <Andre.Pribil@hms-networks.com>
Fixes: 095ff4885a17 ("timers: Prepare support for PREEMPT_RT")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a3f229dc75ec..e1b5dfa260a4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
-#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_RT_FULL
 	spinlock_t		expiry_lock;
 	atomic_t		timer_waiters;
 #endif
@@ -1207,7 +1207,7 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_PREEMPT_RT
+#ifdef CONFIG_PREEMPT_RT_FULL
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
 	spin_lock_init(&base->expiry_lock);
-- 
2.41.0

