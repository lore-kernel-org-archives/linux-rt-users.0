Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C3FC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D805460724
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbhIHKD1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244785AbhIHKD0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 06:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631095338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQO9iSkszaVOlA3tgO9wf1YTbQ1fetYfEhpRUvtLp7Q=;
        b=HqfQk4dr+rOQF17z8zhAF3LvgrxfD+V0SLYd9uPQSiURQT79G9ZMS4J8v52871DQxBZ2QV
        db1SFfzGuqAFWC33+GGpmWYKyfGfaWCn2m6y9sTEHXrUCFrzKEShQZbGvqnE2vKb+asxji
        NZbLiYLDVJB9chCufdORVSmVa5boK/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Weda-fanOQ2Uqpd5bKKREQ-1; Wed, 08 Sep 2021 06:02:17 -0400
X-MC-Unique: Weda-fanOQ2Uqpd5bKKREQ-1
Received: by mail-wr1-f72.google.com with SMTP id 102-20020adf82ef000000b001576e345169so353883wrc.7
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 03:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQO9iSkszaVOlA3tgO9wf1YTbQ1fetYfEhpRUvtLp7Q=;
        b=j4+in1qPZdGX8aqmtsHfmoAHg6OvNHsY8V59Bd9WJRNeNKRMW+N8Ah+oS266pEE54E
         Zl2aelKwMv8R386+rrkC3cPZnrrVnhYjhFzmAK6+39e1t9QloUE4lyT7wWoWcw03crmR
         nc/2AzZ3SgOIdxIKkgQzPjqadfedQlDYORbnHsk+N9fDTeqjsFiwdQuAHUq3I5E52ucd
         IbfLsJ9op1Lxo3i2uAVC7KC2AmnvWwOhnMXu+3D5eYVDWuT7ZfZm1tEfGX1zYmBWQ8Ls
         +Yq5MAo8nUEuzjNKkhF5E1wEV/5cKlhdmaCx500hGe+Rk9c7uijLZvVdVGvFvivmjSx9
         cSbA==
X-Gm-Message-State: AOAM533pGDEM6y15Mr8dJoWcliRuTGbM3HnQaCuSs2Vp5eDUR6FNnO0N
        lJF5ZWQTfuM1uilSBm5dYPh5++jj4mdkrqSssewQwrLrtLSRL5ivTr0VuEzt/+S1n4Y+cb88JFb
        XixSD303amTT+5BOMussebRrvf8xHLVWXBsPl0dkeK9CR0KSa0ui0TbX/C9TNw4uHdWQBhcV2MS
        kb21A=
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr2634687wmc.49.1631095336201;
        Wed, 08 Sep 2021 03:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXxWXofU70T0tEjlC+/FnIg4EOQp3LkMw9btrj2CpmGDYYKf4jTXNdGC7lTuxdyesd3qLXRQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr2634660wmc.49.1631095335941;
        Wed, 08 Sep 2021 03:02:15 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id k16sm1679963wrx.87.2021.09.08.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:02:15 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 3/3] oslat: Allow for arch specific timer frequency measurements
Date:   Wed,  8 Sep 2021 12:02:09 +0200
Message-Id: <20210908100209.118609-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908100209.118609-1-nsaenzju@redhat.com>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Some architectures have special purpose registers to query the system
timer's frequency. Let's use that when available.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index bd155a6..23ca9b6 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -51,6 +51,9 @@
 # define atomic_inc(ptr)   __sync_add_and_fetch((ptr), 1)
 # if defined(__x86_64__)
 #  define relax()          __asm__ __volatile__("pause" ::: "memory")
+
+#define measure_timer_mhz generic_measure_timer_mhz
+
 static inline void frc(uint64_t *pval)
 {
 	uint32_t low, high;
@@ -61,12 +64,18 @@ static inline void frc(uint64_t *pval)
 }
 # elif defined(__i386__)
 #  define relax()          __asm__ __volatile__("pause" ::: "memory")
+
+#define measure_timer_mhz generic_measure_timer_mhz
+
 static inline void frc(uint64_t *pval)
 {
 	__asm__ __volatile__("rdtsc" : "=A" (*pval));
 }
 # elif defined(__PPC64__)
 #  define relax()          do { } while (0)
+
+#define measure_timer_mhz generic_measure_timer_mhz
+
 static inline void frc(uint64_t *pval)
 {
 	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
@@ -74,6 +83,15 @@ static inline void frc(uint64_t *pval)
 # elif defined(__aarch64__)
 #  define relax()          __asm__ __volatile("yield" : : : "memory")
 
+static inline unsigned int measure_timer_mhz(void)
+{
+	unsigned int val;
+
+	__asm__ __volatile__("mrs %0, cntfrq_el0" : "=r" (val));
+
+	return val / 1e6;
+}
+
 static inline void frc(uint64_t *pval)
 {
 
@@ -257,7 +275,7 @@ static cycles_t __measure_timer_hz(void)
 	return (cycles_t) ((e - s) / sec);
 }
 
-static unsigned int measure_timer_mhz(void)
+static unsigned int __attribute__((unused)) generic_measure_timer_mhz(void)
 {
 	cycles_t m, mprev, d;
 
-- 
2.31.1

