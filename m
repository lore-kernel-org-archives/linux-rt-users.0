Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46557C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B360F25
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhHJItC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237520AbhHJIsy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 04:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=LSRN8HbWQ9gyE7lFu5uFwKZbtFWXIcDagC7LpcfHSzqN0ytZcCO68/lanTWBiek/yxUdaZ
        L+OEeURoLJ1lTQ7uQblnbOfXGbFDSa4OAZEqARcGBo3bIx8u/O2U8EWjHkn3/2EjlZD5jP
        v8SoNLGBm9xizJNc4q//o8AWdU6T9yQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-E5PeWuIoM82iFn5hRb9F3g-1; Tue, 10 Aug 2021 04:48:31 -0400
X-MC-Unique: E5PeWuIoM82iFn5hRb9F3g-1
Received: by mail-ed1-f71.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so10449270edq.17
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=uKUJ1T5Zv1kdcv/w1og/XGSg1M5wSS8V/0/wxHYUcLxKKws1pUx0F6fpIF3p5gL2qI
         54VP4Cm33nbUG+pafSTkPBvACuy363KdXqcg9A2tcQtEVL2eT8fXA8HgVp9lBZhvD4Og
         Ek3FAoeP2dPwye8W9uxwqmBTtim7J1gVfP1INPBj42AXqM/rJrIgSpeuQ32rixn/YvWb
         lgFSqDPp4jwm65YtAcmgFv3yR6Y6u19sCdovcHK7/wZIaqsAFSHlNUQ9tONarbO/RfFi
         dU+WLrikIYvxWmr7jCI0Sf9WJGSOSsXLZ+59uwArHRZ21QHOrSobC0hkKM5u/rn9N+/E
         ZDWQ==
X-Gm-Message-State: AOAM530YMqD25X+KYW7nmAhNCG3xIUT+GzrC/GtfY9MTFJMOTptZWOhM
        /YVtXuNPur5xl8E+DwDdGBiXcByD2ZI6Zre6ttl6PPMsJwHsoMKqgUEg31rftg62XcUCZITAViI
        8EA/ZI3jQNiOoClNvUiXvIiWAQHk=
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430802eja.189.1628585310190;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz22EQal9Exqyj7ThilEjaTvbLq4Q2a5syoFgJGe/g8lj7NmDmRexbLX8nYJHLpkiLxzCdkUg==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430786eja.189.1628585310038;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:29 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 2/2] rcu: Make rcu update module parameters world-readable
Date:   Tue, 10 Aug 2021 10:48:16 +0200
Message-Id: <20210810084816.155203-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
References: <20210810084816.155203-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rcu update module parameters currently don't appear in sysfs and this is
a serviceability issue as it might be needed to access their default
values at runtime.

Fix this issue by changing rcu update module parameters permissions to
world-readable.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index bd551134e2f4..94282dc12bab 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -54,11 +54,11 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-module_param(rcu_expedited, int, 0);
-module_param(rcu_normal, int, 0);
+module_param(rcu_expedited, int, 0444);
+module_param(rcu_normal, int, 0444);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
 #if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
-module_param(rcu_normal_after_boot, int, 0);
+module_param(rcu_normal_after_boot, int, 0444);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.31.1

