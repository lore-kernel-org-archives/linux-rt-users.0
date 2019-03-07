Return-Path: <SRS0=0bBW=RK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F95C43381
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE67620675
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 12:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCGMJj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:09:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGMJj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Mar 2019 07:09:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so9012412wmi.1
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Mar 2019 04:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fmxRHEhfqe4KOpOLNzkfUAlcDzf0ZKEImK2Tad1sR2Q=;
        b=j3EvckTSp6Kp1GORAMwbcxWw4bKm4xlTRMTJyKGkOvCIl7OUDKh7D8zFRtq4TBpH89
         dijmge8GaBLUKSINGH1jlRt+POxj+k44egajlsU6cgsXzGb789fWnsuVYQtzXYMUdBgN
         5WJgcOB5A1X0H4FYX0Ke0STv4or7yhWTkbkORnIh60eCl9MAJPNK39sBrWGkEl+8pD5E
         kIRweBl4A0Mt8seI7oDCMzxK/vyZ7piF2FhmkE84GjTXRbRsBE/hCfZnvMHnZe9yswQg
         z98FburE/d3hzaA6JkUxF9PuEZLFD2k9k1VfO5fOWX2XIFhV/2Y61tlf2W9HJMdaxhZI
         Mokw==
X-Gm-Message-State: APjAAAXctiaaDJwhHNH9KDdNHkuSN4/ms4IlKH5MT7wYK/cc3OBCqWvh
        sbzhfs59G3Yg/fQuBzfL7+QfjGee3nM=
X-Google-Smtp-Source: APXvYqyzLzFVbS+eWoxcDeXtGiB33RKmdt3rzfdxHYtRr5mgB5jr3vkg/WwhnVCg5GRHUMaDYl4syg==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr5902285wmf.80.1551960577218;
        Thu, 07 Mar 2019 04:09:37 -0800 (PST)
Received: from localhost.localdomain.com ([151.15.252.68])
        by smtp.gmail.com with ESMTPSA id u17sm10967703wrg.71.2019.03.07.04.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 04:09:36 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT] x86/tsc: Add option to disable tsc clocksource watchdog
Date:   Thu,  7 Mar 2019 13:09:13 +0100
Message-Id: <20190307120913.13168-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Clocksource watchdog has been found responsible for generating latency
spikes (in the 10-20 us range) when woken up to check for TSC stability.

Add an option to disable it at boot.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Sending this out as an RFC after yesterday discussion with Thomas on IRC.

AFAICT, CLOCK_SOURCE_MUST_VERIFY only controls enqueue\dequeue of the
watchdog. TSC sync checks are still done if tsc_clocksource_reliable is
set (booting w/o tsc=reliable).

Thomas, is this anywhere close to what you had in mind?
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 arch/x86/kernel/tsc.c                           | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5acf35c712f..ea7c4967aa80 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4619,6 +4619,10 @@
 			[x86] unstable: mark the TSC clocksource as unstable, this
 			marks the TSC unconditionally unstable at bootup and
 			avoids any further wobbles once the TSC watchdog notices.
+			[x86] nowatchdog: disable clocksource watchdog. Used
+			in situations with strict latency requirements (where
+			interruptions from clocksource watchdog are not
+			acceptable).
 
 	turbografx.map[2|3]=	[HW,JOY]
 			TurboGraFX parallel port interface
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6d5dc5dabfd7..4b753d057aee 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,7 @@ int __init notsc_setup(char *str)
 __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
+static int no_tsc_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -292,6 +293,8 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
+	if (!strcmp(str, "nowatchdog"))
+		no_tsc_watchdog = 1;
 	return 1;
 }
 
@@ -1347,7 +1350,7 @@ static int __init init_tsc_clocksource(void)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (tsc_clocksource_reliable)
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
-- 
2.17.2

