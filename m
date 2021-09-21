Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941DC433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FF9610A1
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhIUQPM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhIUQPJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Skz+wSCIMyvocC+cWmr1kqnk80+x9gFo8RgnyvxY9jI=;
        b=bI34Fs+7ApiP0wT6ko01niS4Be+t2jkB7WoVnoHUlD24nJKjYgRHaxB+OVHlHq1qolrTBf
        YJKzgBFIUg25J8GW30WqK3Yf5oK7Ko2DScyl0gJWzUR6uKKjGKeBIaLUxx0fQ2F/B2aCwF
        GVx8t8qYEAJPJg7kx6Inqm9Cf7KtUOk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-IYWUkKogMYOuZUOORBO3mA-1; Tue, 21 Sep 2021 12:13:38 -0400
X-MC-Unique: IYWUkKogMYOuZUOORBO3mA-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adff80e000000b001601b124f50so2435722wrp.5
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Sep 2021 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Skz+wSCIMyvocC+cWmr1kqnk80+x9gFo8RgnyvxY9jI=;
        b=BR/Sy5HjXT47PYYMDbqkakMQPqXbTZcisUDXLlOj3YAQq2x6krzDQSwKCILPfP1teZ
         qyJN7SkSBfuFu3q2vI/DCqg4CsDiHwHyxeF+6hZHJ+fY/nUYjVhgR067S0gTM9Df7P46
         cqfO/QBzW/s4G9kZ4gWGiAXSbEkKKn+Pd36VAYzvoe9oOBzPR4dE6oS/jq8v/JlfNedb
         H6CRPARxIW+Wm9/gBuLaXudM2sD/Uvv85jfGR1DTwwpmeunsrjczpSIsFgkAA0BEAAi7
         IMVD1qwEr9ltOjG//IOOrUUVbJvWrL5kmm0gnfiX9GVoVYF0ub6dm18RBmv8csaQe5hE
         95cA==
X-Gm-Message-State: AOAM532ZtbBmWjfYfrebN6VfFxO4D9KpG8pkSbDXVBEuWGpVZY8YGJFL
        C6u17A40vF6M3lgVvpPgZUe9ADmHHdUeHGHWdh2dCiK7vTxnrmPzaIZwXOHr/+yW3QAOwJ5KrR2
        XCilyCEC605u16Gfh9q+ewCpPQPU=
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr35713552wrx.361.1632240817399;
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc8lfAIXvvAGBd2lf3kHl9jl9Ma+SH7iopQjrQOmNgpGD7Dcwtktf6tIufdAsdVPxyyoBuiQ==
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr35713524wrx.361.1632240817263;
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 3/6] mm/swap: Allow remote LRU cache draining
Date:   Tue, 21 Sep 2021 18:13:21 +0200
Message-Id: <20210921161323.607817-4-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
drain work queued by __lru_add_drain_all(). So introduce new a mechanism
to remotely drain the per-cpu lists. It is made possible by using a more
constraining locking scheme, which is disabled by default and can be
enabled through the 'remote_pcpu_cache_access' static key. Regular users
shouldn't see any functional or performance change. Upcoming patches
will make use of the key.

Based on previous work by Thomas Gleixner, Anna-Maria Gleixner, and
Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/cover/20190424111208.24459-1-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/swap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bcf73bd563a6..59e96a2520d5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -915,19 +915,29 @@ inline void __lru_add_drain_all(bool force_all_cpus)
 	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
 	smp_mb();
 
-	cpumask_clear(&has_work);
-	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
-
-		if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, work);
-			__cpumask_set_cpu(cpu, &has_work);
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		for_each_online_cpu(cpu) {
+			if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
+				lru_cache_lock_cpu(&lru_pvecs.locks, cpu);
+				lru_add_drain_cpu(cpu);
+				lru_cache_unlock_cpu(&lru_pvecs.locks, cpu);
+			}
+		}
+	} else {
+		cpumask_clear(&has_work);
+		for_each_online_cpu(cpu) {
+			struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+
+			if (force_all_cpus || lru_cpu_needs_drain(cpu)) {
+				INIT_WORK(work, lru_add_drain_per_cpu);
+				queue_work_on(cpu, mm_percpu_wq, work);
+				__cpumask_set_cpu(cpu, &has_work);
+			}
 		}
-	}
 
-	for_each_cpu(cpu, &has_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		for_each_cpu(cpu, &has_work)
+			flush_work(&per_cpu(lru_add_drain_work, cpu));
+	}
 
 done:
 	mutex_unlock(&lock);
-- 
2.31.1

