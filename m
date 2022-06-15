Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC152C43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbiFOUgt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiFOUgr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 16:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC07D54F9D
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655325405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RB6TQNLl0itlFPHhjRDfMRu2PM1eAH0nIvIMTuza6x8=;
        b=E7WZ4NAzkHLv2s8z3iBi4xe9vCNDRU7/4+sjpgI1U0Jq/hDF41f9n3k/Xqkd+Bspn2POpO
        G1I2yquy4qCpFtddpN7qknTEZtC3iPStXANHH/xvBmXx17lc6e26UDN5GOTC6jSAS8Km2o
        deV4iEfl+32qE6S16rJ/cAV3+aEhDQk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-n2-tEEPcOUG1rASrZhaZ4A-1; Wed, 15 Jun 2022 16:36:44 -0400
X-MC-Unique: n2-tEEPcOUG1rASrZhaZ4A-1
Received: by mail-qv1-f70.google.com with SMTP id 4-20020a05621420e400b0046e37432292so7232532qvk.7
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 13:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RB6TQNLl0itlFPHhjRDfMRu2PM1eAH0nIvIMTuza6x8=;
        b=OVYP95IyMB+//e6SmVGDinK9xczmvFdb3DWRFZRuNM2VvnNEcUuMQYy4jf5G3x47LM
         ZGsz7RYpTLAkzrkeOfNwmHPT9aTiTVf0KqfLXg0i4kBuWsvpG8UznwzrDdPX82Yad58y
         fJyAOWjO2JCfpZVlpzQUAfeONJ97k4dH5OoQIMJL3Rd5dNBPZ/Dkyv2r0kevytdYLyqY
         8uSGJXf7b9ER21cngOFcB2BFWhCa3hIiSLLtQvsB0KRz9oR2ov7p3OAuuP+l5IqV2j8z
         lnhWawgX6kQaoOvoDhXPQv9lr1ilVDD3tSJ5kJlm7oeoTY9uzL1CI2EayAAu6+IKmnCd
         qcAg==
X-Gm-Message-State: AJIora+cRS9B0bOGUh7coKzMGYBLaDgfm1utDhr5j5jX/8iOoN/m5HaX
        0YLIAPo1R6mNn30RAFTF4EYdF3cJdJVr8k7yN4aAmEKGD4xbncG1gke+4iAZugE17nEpmVXrpfI
        45pm0JZ6YMVG6qQGfwTrzY26ZPIInKzyVWLUeudHb0QojgDpZMeTCFXfZACqRkwkF3z9E0BOOqe
        LAwvY=
X-Received: by 2002:a05:6214:c4b:b0:46a:66a2:d72a with SMTP id r11-20020a0562140c4b00b0046a66a2d72amr1326575qvj.21.1655325404234;
        Wed, 15 Jun 2022 13:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTm9O3WNkdaEAfX+yCS/EJ8hWAYUskqsJ9zF93svhFsfEPw/9Wc73ANgm7cNp3iujo0noG0A==
X-Received: by 2002:a05:6214:c4b:b0:46a:66a2:d72a with SMTP id r11-20020a0562140c4b00b0046a66a2d72amr1326550qvj.21.1655325404016;
        Wed, 15 Jun 2022 13:36:44 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id v16-20020a05622a145000b00304f55e56e4sm178541qtx.40.2022.06.15.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:36:43 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Adrien Thierry <athierry@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH RFC] base: power: replace generic_pm_domain spinlock by raw spinlock
Date:   Wed, 15 Jun 2022 16:36:05 -0400
Message-Id: <20220615203605.1068453-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We've been encountering a BUG: scheduling while atomic while running the
5.18.0-rt11 kernel on a Qualcomm SoC (see stacktrace below).

It seems to occur because a spinlock is taken in the PSCI idle code path
in the idle loop. With the RT patchset applied and CONFIG_PREEMPT_RT
enabled, spinlocks can sleep, thus triggering the bug.

In order to prevent this, replace the generic_pm_domain spinlock by a
raw spinlock.

[    2.994433] BUG: scheduling while atomic: swapper/6/0/0x00000002
[    2.994439] Modules linked in:
[    2.994447] [<ffff80000810b0ec>] migrate_enable+0x3c/0x160
[    2.994461] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.18.0-rt11+ #1
[    2.994464] Hardware name: Qualcomm SA8295P ADP (DT)
[    2.994466] Call trace:
[    2.994467]  dump_backtrace+0xb0/0x120
[    2.994473]  show_stack+0x1c/0x6c
[    2.994477]  dump_stack_lvl+0x64/0x7c
[    2.994483]  dump_stack+0x14/0x2c
[    2.994487]  __schedule_bug+0xa8/0xc0
[    2.994489]  schedule_debug.constprop.0+0x154/0x170
[    2.994492]  __schedule+0x58/0x520
[    2.994496]  schedule_rtlock+0x20/0x44
[    2.994499]  rtlock_slowlock_locked+0x110/0x260
[    2.994503]  rt_spin_lock+0x74/0x94
[    2.994505]  genpd_lock_nested_spin+0x20/0x30
[    2.994509]  genpd_power_off.part.0.isra.0+0x248/0x2cc
[    2.994512]  genpd_runtime_suspend+0x1a0/0x300
[    2.994515]  __rpm_callback+0x4c/0x16c
[    2.994518]  rpm_callback+0x6c/0x80
[    2.994520]  rpm_suspend+0x10c/0x63c
[    2.994523]  __pm_runtime_suspend+0x54/0xa4
[    2.994526]  __psci_enter_domain_idle_state.constprop.0+0x64/0x10c
[    2.994532]  psci_enter_domain_idle_state+0x1c/0x24
[    2.994534]  cpuidle_enter_state+0x8c/0x3f0
[    2.994539]  cpuidle_enter+0x3c/0x50
[    2.994543]  cpuidle_idle_call+0x158/0x1d4
[    2.994548]  do_idle+0xa8/0xfc
[    2.994551]  cpu_startup_entry+0x28/0x30
[    2.994556]  secondary_start_kernel+0xe4/0x140
[    2.994563]  __secondary_switched+0x54/0x58

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---

This patch fixes the bug but I'm not sure if this is the proper way to do
so. Suggestions for other ways to fix this are very welcome. 

 drivers/base/power/domain.c | 10 +++++-----
 include/linux/pm_domain.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..9378decb58cf 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -82,7 +82,7 @@ static void genpd_lock_spin(struct generic_pm_domain *genpd)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&genpd->slock, flags);
+	raw_spin_lock_irqsave(&genpd->slock, flags);
 	genpd->lock_flags = flags;
 }
 
@@ -92,7 +92,7 @@ static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave_nested(&genpd->slock, flags, depth);
+	raw_spin_lock_irqsave_nested(&genpd->slock, flags, depth);
 	genpd->lock_flags = flags;
 }
 
@@ -101,7 +101,7 @@ static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&genpd->slock, flags);
+	raw_spin_lock_irqsave(&genpd->slock, flags);
 	genpd->lock_flags = flags;
 	return 0;
 }
@@ -109,7 +109,7 @@ static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
 static void genpd_unlock_spin(struct generic_pm_domain *genpd)
 	__releases(&genpd->slock)
 {
-	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
+	raw_spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
 }
 
 static const struct genpd_lock_ops genpd_spin_ops = {
@@ -2022,7 +2022,7 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
 	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
-		spin_lock_init(&genpd->slock);
+		raw_spin_lock_init(&genpd->slock);
 		genpd->lock_ops = &genpd_spin_ops;
 	} else {
 		mutex_init(&genpd->mlock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..80166a915b0d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -159,7 +159,7 @@ struct generic_pm_domain {
 	union {
 		struct mutex mlock;
 		struct {
-			spinlock_t slock;
+			raw_spinlock_t slock;
 			unsigned long lock_flags;
 		};
 	};

base-commit: 979086f5e0066b4eff66e1eee123da228489985c
-- 
2.35.3

