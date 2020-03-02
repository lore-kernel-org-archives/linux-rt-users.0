Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533FC3F2D1
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E905F22B48
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNEuNOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCBVos (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40543 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCBVos (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id o10so1243258qtr.7
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1n6pw/8iPjNaOQsjF7JGDkoGDmdi5XsnqPrMHVoS9w=;
        b=NFNEuNOmbO6MbGyZ07Wk7A+7HmheiLo84kLHRB0HYVgdfcREnGjoZt2SqaUt/pwBzS
         2GPX/ZswwwzAsYjN/Ac9mNRAckMbU6oPvqG5b0YE5KhyYdk8fk75qt4u/h2toaBFLWqL
         SglP2TCRCD/at8gDa3F1ocFRrq0aupnztCbVC/4oZxl6vrumUOHPUqL9ByoaBKvxmSPy
         DMRbB/JMa7HNEvWYppeWjVpzalTfBquO05BalJhxv0iROj/k7SlwbVaDLVrNT4gswcDc
         ilOcSsvdYEjJfCmagky5Ile0J45zojEYrlKt2s2OvBowuSbK+X07ASG/2REcOE3qv4WR
         vMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=R1n6pw/8iPjNaOQsjF7JGDkoGDmdi5XsnqPrMHVoS9w=;
        b=YgcuGg0t9ghdi05TE1Rs75b6MNT8WwTJkR8jiFH2BnZQzO9qZVlqZLGqNLj7xexhGD
         ZJaBHKq81sxs0yD4PQfm3eFSuyiX4LF0bMnzWCeM2u2yDPOkBJ8AIVy8MRnVwYNeE10R
         Gb9VZMG5AKClBHscYAO8L0VD2iqcWGVhhxjBSDFV9RNGEJyWq1sltjmbq4Qiu33wTeeR
         lSOEdTMdK+EqRD4vB9TTZ58rfCLacx9HrjqXsippxF2ImmFfMFHcNb7IO/1UpULRLwh2
         2lonxPbFX6TtxVDZpEeGqTpbUWoFKdD7sERTDoeULe3TSjXl76gmD3MbjYMSFz6la0fX
         7b/Q==
X-Gm-Message-State: ANhLgQ174RfJM08b+dtpHiqGCx3QOvT4Sdbz/g6xOS3nXIw3sc2jOwLb
        AMh38hEnIFwvE6PCvTg6M7WBEsXf11Q=
X-Google-Smtp-Source: ADFU+vtWS6YVrrlKCN37L7gCve1GL01HAxpjMxOBiEuIyh42NJ281EGV2DSl7eHeully14wtFBLstQ==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr1644088qtg.314.1583185486827;
        Mon, 02 Mar 2020 13:44:46 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:46 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/6] rt-tests: cyclictest: Only run on runtime affinity and user supplied affinity
Date:   Mon,  2 Mar 2020 16:44:30 -0500
Message-Id: <20200302214430.15825-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Currently if the user passes the affinity to cyclictest, threads are run
there even if they should be excluded according to the affinity of the
runtime environment.

For example

taskset -c 4-7 cyclictest -t -a 1-6

Should run on the interesection of this, that is on cpus 4,5,6

Fix this so it works as expected

Note, one caveat, this apply to the threads that cyclictest creates, but
only the initial taskset applies to the main cyclictest thread, so the
main thread can run on cpus 4,5,6 and 7

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ce93ad0643cd..13d2b1722890 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1044,8 +1044,13 @@ static unsigned int is_cpumask_zero(const struct bitmask *mask)
 static int cpu_for_thread_sp(int thread_num, int max_cpus)
 {
 	unsigned int m, cpu, i, num_cpus;
+
 	num_cpus = rt_numa_bitmask_count(affinity_mask);
 
+	if (num_cpus == 0) {
+		fatal("No allowable cpus to run on\n");
+	}
+
 	m = thread_num % num_cpus;
 
 	/* there are num_cpus bits set, we want position of m'th one */
@@ -1091,6 +1096,30 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 }
 
 
+/* After this function is called, affinity_mask is the intersection of the user
+ * supplied affinity mask and the affinity mask from the run time environment */
+static void use_current_cpuset(const int max_cpus)
+{
+	int i;
+	pid_t pid;
+	struct bitmask *curmask;
+
+	pid = getpid();
+
+	curmask = numa_bitmask_alloc(sizeof(struct bitmask));
+	numa_sched_getaffinity(pid, curmask);
+
+	/* Clear bits that are not set in both the cpuset from the environment,
+	 * and in the user specified affinity for cyclictest */
+	for (i=0; i < max_cpus; i++) {
+		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i))) {
+			numa_bitmask_clearbit(affinity_mask, i);
+		}
+	}
+
+	numa_bitmask_free(curmask);
+}
+
 static void parse_cpumask(const char *option, const int max_cpus)
 {
 	affinity_mask = rt_numa_parse_cpustring(option, max_cpus);
@@ -1098,7 +1127,10 @@ static void parse_cpumask(const char *option, const int max_cpus)
 		if (is_cpumask_zero(affinity_mask)) {
 			rt_bitmask_free(affinity_mask);
 			affinity_mask = NULL;
+		} else {
+			use_current_cpuset(max_cpus);
 		}
+
 	}
 	if (!affinity_mask)
 		display_help(1);
-- 
2.20.1

