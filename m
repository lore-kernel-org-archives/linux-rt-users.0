Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E4C4320A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DFB61076
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhHJIs7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbhHJIsx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 04:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWWfZfczx65IParlduf54SQJn/f7jfyxJXfN8MyeRwI=;
        b=csBk94EAfIvBMDh3QQcJF+1cwN4SNRcvP82LWqH67CxWEqTC4njJ+3+IZPPpzy9vZzpmwp
        upbwfHiw28OGKfv0vpYRREMlKnzgwHQoUeQjraoUwiLRKcPkmphKkl44K/3upmXChnTiJt
        tGsr4FQ2HtcnDQxywwXO4tcNCKJqKMs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-yE_V2RM8P3mhdQdf_WB2dw-1; Tue, 10 Aug 2021 04:48:30 -0400
X-MC-Unique: yE_V2RM8P3mhdQdf_WB2dw-1
Received: by mail-ed1-f69.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso10251650edp.4
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWWfZfczx65IParlduf54SQJn/f7jfyxJXfN8MyeRwI=;
        b=LzK1d1s5ZFhG1EDHVoXHRYGTzWM4WC1Qt8ErG16u73s0Wksp9p6hJi/ZgA1pJPa8OE
         ztfn/ZzND8+nnmckha7msW59paLjALVWADlYcPszqjpTvi0FLD2RIiJb+O7yHahlPw0k
         AtJbfQEoGymP0ho2by64gE2GL8/AvPgYNH6J2BTxyH2BxzHdoKh8/Xb47QRufXBvuE0B
         ZgRozVBAGZponJCvredq0iLmDb5qPBOMEGXNbIu1H1/K+rca2R9RWIqFkDlNPQ1paOcU
         UachvBWYbYTKeENFQScAOCcMta9uECJO9onIH6C/fO+HMqBTqczjyIOxVke3vvd/kpaj
         pniQ==
X-Gm-Message-State: AOAM533vz1OuYuU31DCGfeZNKDunHJpRV/VTRvvVVeEJshrwiYDXOhY6
        Nv3nXEQmhNwXIV3ECfrPe7Kb4YLj+5fsFMBQQlGJNBQMiqSsUdqw8ESJT0+xBQjRt06tFdsP8HH
        fioE7zz8LTN1A5veoVUKp2vyfefA=
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr26786003ejz.510.1628585308628;
        Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn80ECnujwqU7hjqyUptCj/nIeG0tDzxXAB3iqy+3raekA06q/d65FphjKgOD6D/7OJW+HXg==
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr26785981ejz.510.1628585308409;
        Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:27 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 1/2] rcu: Make rcu_normal_after_boot writable again
Date:   Tue, 10 Aug 2021 10:48:15 +0200
Message-Id: <20210810084816.155203-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
References: <20210810084816.155203-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Certain configurations (e.g., systems that make heavy use of netns)
need to use synchronize_rcu_expedited() to service RCU grace periods
even after boot.

Even though synchronize_rcu_expedited() has been traditionally
considered harmful for RT for the heavy use of IPIs, it is perfectly
usable under certain conditions (e.g. nohz_full).

Make rcupdate.rcu_normal_after_boot= again writeable on RT (if NO_HZ_
FULL is defined), but keep its default value to 1 (enabled) to avoid
regressions. Users who need synchronize_rcu_expedited() will boot with
rcupdate.rcu_normal_after_ boot=0 in the kernel cmdline.

Reflect the change in synchronize_rcu_expedited_wait() by removing the
WARN related to CONFIG_PREEMPT_RT.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/tree_exp.h | 1 -
 kernel/rcu/update.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 2796084ef85a..d9e4f8eb9ae2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -512,7 +512,6 @@ static void synchronize_rcu_expedited_wait(void)
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
 			return;
-		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
 	}
 
 	for (;;) {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..bd551134e2f4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -57,7 +57,7 @@
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
-#ifndef CONFIG_PREEMPT_RT
+#if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
 module_param(rcu_normal_after_boot, int, 0);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
-- 
2.31.1

