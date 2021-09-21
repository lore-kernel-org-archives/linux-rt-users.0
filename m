Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5413BC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A73761242
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhIUQPU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhIUQPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqnAk8CEPT4G20qz1UpPoVf1omLqowS17E+dGhKhwuM=;
        b=SnfSuRXgNGTyqVjnsgUSNlHAJCc/Lkoi5nV79FrqR7bDrwBBLRK+GCmeNCeY5OaXCn2MaH
        Nt7P8hZBcSXgOXYkMVjXotbjEbPuR1iSZFgcjnbm1FcKu2a01QDy2VW8Gi8YntqwhVwVDg
        1Qxl7xZrRpEtAGiraWCuoGXVZ3d5CVc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-pX38XM9ENt2THMA7y6-PkQ-1; Tue, 21 Sep 2021 12:13:43 -0400
X-MC-Unique: pX38XM9ENt2THMA7y6-PkQ-1
Received: by mail-wr1-f72.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so9260311wrt.9
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Sep 2021 09:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqnAk8CEPT4G20qz1UpPoVf1omLqowS17E+dGhKhwuM=;
        b=dtCaxFUu97J9J+XznrisJaceFVDJ9vks7nfWJM6cvbGBlbhgUtF1FM78CCWLVS+fZx
         H3/yJoY/25eSgQBzE52wNYfkX2TfiaPidZjNcTSFxTHJ/rj0952p8cMyg74DOvPAV/AZ
         x8+odK9SGno34T6kHiEtjiHb9cdeyCT38lldcmvdDx1MSOh+10NGovS0TMBVQty455Qy
         N+4acR+3swxaBJSQJfb5zA3SLsmPQo6vBq1P8JSejT9H5xNWrqQZLIdokAQGrPEGCwr/
         HPjZ4Iw3b0l9NQAFbJqvcvoBs6Lrwc4ziJOkKqT9liJGBqXFi273rrGGl3EgGhjZ/Osw
         X/MA==
X-Gm-Message-State: AOAM533wGLTMT/4rlHZU3PXQvE/3ovgqg8WGeA80+igkuGStkYiZAmKX
        J9Ck3rKm2wclQFSa+ZAzNAU7dlOQhl1GkB1YMPSzXFgRssl8xN1Bjxn31cQzCA2TeRz1Mjd4jk+
        Dwk3TFf9rOa3bZ6s3ixEp7WPXOQU=
X-Received: by 2002:a5d:510b:: with SMTP id s11mr35121613wrt.79.1632240821968;
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JyQmA+xjBWA1pYPhaUZl3UgvqGOZtEA5D9vdOoOLPYTSVO682BJB72/4LybppWdkc2NU+A==
X-Received: by 2002:a5d:510b:: with SMTP id s11mr35121588wrt.79.1632240821777;
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:41 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 6/6] sched/isolation: Enable 'remote_pcpu_cache_access' on NOHZ_FULL systems
Date:   Tue, 21 Sep 2021 18:13:24 +0200
Message-Id: <20210921161323.607817-7-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When enabled, 'remote_pcpu_cache_access' allows for remote draining of
mm/swap.c's per-cpu LRU caches and mm/page_alloc.c's per-cpu page lists
instead of using per-cpu drain work. This comes at the cost of more
constraining locking, but NOHZ_FULL setups need this nonetheless:
processes running on isolated CPUs are sensitive to any sort of
interruption and preempting them in order to satisfy a housekeeping task
is bound to break their functional guarantees (i.e. latency, bandwidth,
etc...).

So enable 'remote_pcpu_cache_access' after having successfully
initialized NOHZ_FULL.

This is based on previous work by Thomas Gleixner, Anna-Maria Gleixner,
and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/sched/isolation.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..4fc4c76f27ab 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include "sched.h"
+#include "../../mm/internal.h"
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
@@ -137,11 +138,17 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned int flags;
+	int ret;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
 		HK_FLAG_MISC | HK_FLAG_KTHREAD;
 
-	return housekeeping_setup(str, flags);
+	ret = housekeeping_setup(str, flags);
+	if (ret)
+		/* Avoid LRU cache and mm/page_alloc.c's pcplists drain work */
+		static_branch_enable(&remote_pcpu_cache_access);
+
+	return ret;
 }
 __setup("nohz_full=", housekeeping_nohz_full_setup);
 
-- 
2.31.1

