Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A5C001DB
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 20:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjHHUqu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHHUqT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 16:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1735C76
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LS2zS5fEeZyQMoa9x435JxujVLCIf5qEHRucYOerao=;
        b=glM1CLEY0HbQdKfJ6hBbq+aegSkTVWiu+Ea9FKxQ9kmjPN/ShJp1HQhb3J+MfAdU6+Y8h3
        mzhCT2j5UQWL1abAKfozj7qlCUINV0P6BSMopa5W6S6RkinnhAektzMCvbkmJGaJspR9tH
        RTNW2cvE7bOumYhYF2cpvhtIo5sQLWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-ELNwsg0cOR6VxhpT196nrw-1; Tue, 08 Aug 2023 12:35:24 -0400
X-MC-Unique: ELNwsg0cOR6VxhpT196nrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE45800159;
        Tue,  8 Aug 2023 16:35:24 +0000 (UTC)
Received: from localhost (unknown [10.22.32.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D85E4492C13;
        Tue,  8 Aug 2023 16:35:23 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Cc:     Clark Williams <clark.williams@gmail.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT 2/3] rt: PREEMPT_RT safety net for backported patches
Date:   Tue,  8 Aug 2023 13:35:19 -0300
Message-ID: <20230808163520.305842-3-lgoncalv@redhat.com>
In-Reply-To: <20230808163520.305842-1-lgoncalv@redhat.com>
References: <20230808163520.305842-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Clark Williams <clark.williams@gmail.com>

v4.14.320-rt152-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ commit 67821680a2b828aa405a2db5d7dbd812a3684fcf from v4.19-rt ]

While doing some 4.19-rt cleanup work, I stumbled across the fact that parts of
two backported patches were dependent on CONFIG_PREEMPT_RT, rather than
the CONFIG_PREEMPT_RT_FULL used in 4.19 and earlier RT series.  The commits
in the linux-stable-rt v4.19-rt branch are:

dad4c6a33bf4e mm: slub: Don't resize the location tracking cache on PREEMPT_RT
e626b6f873f2c net: Treat __napi_schedule_irqoff() as __napi_schedule() on PREEMPT_RT

Discussing this at the Stable RT maintainers meeting, Steven Rostedt suggested that
we automagically select CONFIG_PREEMPT_RT if CONFIG_PREEMPT_RT_FULL is on, giving
us a safety net for any subsequently backported patches. Here's my first cut at
that patch.

I suspect we'll need a similar patch for stable RT kernels < 4.19.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/Kconfig.preempt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 11dbe26a8279..97875b4eb569 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -6,6 +6,9 @@ config PREEMPT_RT_BASE
 	bool
 	select PREEMPT
 
+config PREEMPT_RT
+       bool
+
 config HAVE_PREEMPT_LAZY
 	bool
 
@@ -78,6 +81,7 @@ config PREEMPT_RT_FULL
 	depends on IRQ_FORCED_THREADING
 	select PREEMPT_RT_BASE
 	select PREEMPT_RCU
+	select PREEMPT_RT
 	help
 	  All and everything
 
-- 
2.41.0

