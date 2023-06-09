Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58461C7EE25
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jun 2023 01:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjFIBMC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 21:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjFIBMA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2023 21:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7D271D
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jun 2023 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686273073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAPrzE0wKW/BWdQ1bdJelqKYq/KbYmGOiNXVRllbmt0=;
        b=KUpS0qqK8wSlUDrkpv4e40ficBsSZGylA8CnivgiLHLGs1SrmO9GXP52KSlzM30inZu2Xo
        6S3fqDBfIYHU2XXN7fUvc0EO5TPBctAuh1WCuJyRUZITOdpexRF0EQZtSExmGarpVnpn0k
        uzrzoLJLebnQC9/WsrHbEHXoV2/gEvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223--L8cKAO1MGiPLAHUqYs1aw-1; Thu, 08 Jun 2023 21:11:08 -0400
X-MC-Unique: -L8cKAO1MGiPLAHUqYs1aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D38D803DBE;
        Fri,  9 Jun 2023 01:11:07 +0000 (UTC)
Received: from localhost (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 152341121315;
        Fri,  9 Jun 2023 01:11:06 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 1/3] Revert "printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h"
Date:   Thu,  8 Jun 2023 22:11:02 -0300
Message-Id: <20230609011104.967128-2-lgoncalv@redhat.com>
In-Reply-To: <20230609011104.967128-1-lgoncalv@redhat.com>
References: <20230609011104.967128-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v5.10.180-rt89-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts commit 32232bcd4e5300e678718d5c29da4dfa07ade01e.

The support for deferred printing was removed in v5.10-rc1-rt1 by commit
9153e3c5cb0c9 ("printk: remove deferred printing") because:

    Since printing occurs either atomically or from the printing
    kthread, there is no need for any deferring or tracking possible
    recursion paths. Remove all printk context tracking.

Fixes: 32232bcd4e530 ("printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h")
Fixes: 083183f8bea0f ("rt: printk: remove new references to deferred printing")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 include/linux/printk.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 92e0656841128..7e4352467d831 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -609,23 +609,4 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
 
-#if defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT)
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
-/*
- * The printk_deferred_enter/exit macros are available only as a hack for
- * some code paths that need to defer all printk console printing. Interrupts
- * must be disabled for the deferred duration.
- */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
-#else /* defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT) */
-static inline void printk_deferred_enter(void)
-{
-}
-static inline void printk_deferred_exit(void)
-{
-}
-#endif
-
 #endif
-- 
2.40.1

