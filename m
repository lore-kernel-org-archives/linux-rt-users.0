Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D273C3A59D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A1421848
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHVGvd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfHVGvd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 02:51:33 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19BBC85365
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Aug 2019 06:51:33 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z2so2730571wrt.6
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Aug 2019 23:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SehunmZrLzZwSCNjetD7+l48gXfnJ0OoV09H8aMfBQ0=;
        b=tm/z/ySEw7SSIx3sIuNGHxbBabaZCzxqkOhPh9H0db9Xu6872RGZax3E2xjTEaPcdw
         5HekvA/4cFLxEpZqqiz1G3ACxqkCOTKC+PsY0wPyXUO2eEsX8lyWsOnr9eSq5/3FwTar
         ih0LFaZqb60K2j2WRSYuT4s8cjn5RYPGJDuLCvUz87HydnP641I/nNstcSal0t2g4b/B
         4SnNnbHuzD6HLdZ0uFFFj2HzWsd8qmwZjdAbHnL57GsaxPT+4U2XpUkX/ZaXiSMJgV1x
         XBQdzXN9CJeAVCCt3/y+KqwcNw5T6prVsNnncnMni8FHwm3Q1sPJT1UmLi+LThMDg7uR
         87ZQ==
X-Gm-Message-State: APjAAAW9SCTeiomOhuyR2sUz3qw1nCeNAF0AST+3H5Uc0BSeEFt56jL4
        QGy90L0btepqp8mtg+M8O63q6j53Jf9GAS7lbF9NG3Hw5VboJl+ug3iGCBfJxZ1PmUSoIjlZFTG
        7VOcLTm6n9xMP+JGPTrxZLZ5GdMk=
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr4180652wmj.17.1566456691753;
        Wed, 21 Aug 2019 23:51:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEf9FwXNfHtATnwaDhRIXXiYY4CT62XP8VqpM7xKDUrCJNC6Y16rIn5ri9PMSFgHmmbg9tug==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr4180621wmj.17.1566456691450;
        Wed, 21 Aug 2019 23:51:31 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id a23sm3553448wma.24.2019.08.21.23.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 23:51:30 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RT PATCH] kernel/irq: make irq_set_affinity_notifier() work on old_notify consistently
Date:   Thu, 22 Aug 2019 08:51:17 +0200
Message-Id: <20190822065117.16467-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The second half of irq_set_affinity_notifier() flushes an old notifier,
but (for RT) it is currently working on 'notify', which is the new one
(or can be NULL - in fact a NULL pointer dereference has been observed).

Fix this by making the second half of irq_set_affinity_notifier() use
old_notify consistently.

Fixes: d4200ab75cdd ("genirq: Handle missing work_struct in irq_set_affinity_notifier()")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

This applies to v4.19.59-rt24 (and to all the other branches that have
the patch that introduced the issue). v5.2-rtx doesn't have this problem
(thanks to the workqueue rework).

Best,

Juri
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b2736d7d863b..4586967a1b32 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -386,7 +386,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 
 	if (old_notify) {
 #ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
+		kthread_cancel_work_sync(&old_notify->work);
 #else
 		cancel_work_sync(&old_notify->work);
 #endif
-- 
2.17.2

