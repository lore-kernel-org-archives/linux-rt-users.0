Return-Path: <SRS0=Lhp7=XX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC006C4360C
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Sep 2019 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCF20863
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Sep 2019 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft3YuyPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfI1PRT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 28 Sep 2019 11:17:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45374 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfI1PRT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 28 Sep 2019 11:17:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so5227589ljb.12;
        Sat, 28 Sep 2019 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/Or9xbf99ONTFrxrvdxy7eGI39fKNbNjEFAv8oGWRc=;
        b=ft3YuyPn6wSzd1Hjia4ybybfrm9e4wypn42kke4SRlMXgCHkdWmpJmUvENrGSyC3Do
         RCoa6grXdDN90Pyjec3hs2V3gZqw3MmITK96L/RqkbI9E0fk5Mz1MiGlkgguGahqFeCE
         qvHHfOeRmx45fzqJ3ejbGROICTzO6HpdKdudgdUTPWQHXvXD8Vf1jQjPa5KssLA7B9bo
         m6ozZ5AbHDACk16705uiLWb0ex1gKl2NxGFiQ7mQ0/cO+goUInza4PAckA1/LGiXMHGG
         64oEGE9iLVbzAvg9nqgr1/8abhD25ZQzMbnGFNn73bGwTYztDW72Q0tXN+VZmH17KJOK
         ipFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/Or9xbf99ONTFrxrvdxy7eGI39fKNbNjEFAv8oGWRc=;
        b=k+H226XvRYSgVbOXthSdL5ikTOaU8Hf0t4O2ZuAsO3phdqsQQHb4oJSWYx9kR/ibPL
         5xLqcNfYquskJsgFRqXLbIoIZ1hTh/7ARJzf9nOrfICt3ZQK6pqKlQBH3QVbey9ATeLV
         ZqdaAnHNzKKNwahv3cJQf+1Yh+KmyCVd9ECp7Pmmc/YHdB9nOfoTt3+YORJg0uuYNdWi
         yFiY4ooos5+C7qfoyRB1X/0ksBEPrwrInE76JQNSpE3L6NB7MMmp5hJyMclBceyixVE6
         wk7svaVBuX7FU7PrI7B4wVdTyQtq2c44XujDqZZ6k7z80gWFhAQqiym0NyoXUbKAn3x4
         oh/g==
X-Gm-Message-State: APjAAAWAHUtE09pYveHlbkfBRnclboEI5lYlm7Fwj3Shb1Z8UxaczA+K
        JwQcBQxbpfYSSdPW2HG5InL/M0mv
X-Google-Smtp-Source: APXvYqyJUQGVTcM0ZHdWLzrkbGtlMCDAkEeQk3hOHh4Y5zfpE9jdlAB/di2OQ8YBklKHQma1xGPlKw==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr6370485ljc.210.1569683836509;
        Sat, 28 Sep 2019 08:17:16 -0700 (PDT)
Received: from alpha (92-100-210-152.dynamic.avangarddsl.ru. [92.100.210.152])
        by smtp.gmail.com with ESMTPSA id q14sm1352314ljc.7.2019.09.28.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 08:17:15 -0700 (PDT)
Received: (nullmailer pid 1719 invoked by uid 1000);
        Sat, 28 Sep 2019 15:19:44 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] genirq: replace notify with old_notify in irq_set_affinity_notifier()
Date:   Sat, 28 Sep 2019 18:19:20 +0300
Message-Id: <20190928151921.29268-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch is for Linux 4.19 with a RT patch.

The second 'if' block does not check notify for NULL,
this leads to a system crash.

Most likely, there is a typo here.

With old_notify system works as expected.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 290cd520dba1..79a7072dfb3c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -412,7 +412,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 
 	if (old_notify) {
 #ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
+		kthread_cancel_work_sync(&old_notify->work);
 #else
 		cancel_work_sync(&old_notify->work);
 #endif
-- 
2.21.0

