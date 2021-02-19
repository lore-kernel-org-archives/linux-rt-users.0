Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC1CC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E697164E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBSSs7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBSSs6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 13:48:58 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F0C061786
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w19so6470318qki.13
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9oaEFLK9ItedpdRdsl1/lWXoR4qNWVepHhW4k1saQ8=;
        b=s/BY5t/rWiC3/sDAu/5iJBDK+8FY6E/6JxLtxOlSOxwB9J1WzYdb+KEaDwaexMdDwo
         W/E4poB5UuYbMbJGGHf459Dxe/0GeObVxIkeiAlonvp8knXJQLj6TYdKe4w7HKvcS6a0
         MOWOuPxC44fGnWZ3dLjVsT8mxxnFbjlNoSrcp8QBsB2GUq05XngT1duwVLoluX6m+XqN
         GjVHkTF4lwsVgRzl6yGMXkDF/8SL1vozle7ymb/nQJDxj0m/bvPi//6hnQKuytJ2bv/g
         JUUenXY0GGDxXNoAgQsgtp97FMwHdI2CCYy3f5+OfpTd+gS4BPVcLboVrzFKkME/nPn0
         hpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=I9oaEFLK9ItedpdRdsl1/lWXoR4qNWVepHhW4k1saQ8=;
        b=aWQ1vTU5YL2tIdDncSV8e5aLLwniTe4Hdlarl6g/suG5c0iNbW8FPPO4rgFUh/Kq33
         05O6xe/0GfHSP3xnutqLhwPrjcT/f7qW59QaXq/WIbqusUJMVmYiWRCVq1e3m6FiF9u0
         DZLIR+sImhxWvUZz+JFoVVD/lY3YpPHM4WCWHIesoLkHi/IvUO3ci2uJLkdw0/cj0I7U
         t2COKTenHLVX67ZNgVKXrFZ7gOQ7nULaVUk8mNjI9kqHX4jYb9+l4LhHWbC2nlDowUiE
         lTloueXx7JrKj+hDw3prr+pjYedlI8qvcrivWJ8sYCTwv3IMUhiqJvLtRK2NIh4iEGsR
         CpKg==
X-Gm-Message-State: AOAM530xwFmNQ7dqLJ2R6MIpDvDIpf2hm2vQNqeKyc0aLZ5hriwwr+31
        rTc7gaV7cXI/aO9GilskJbvWHxKMENIL2fKK
X-Google-Smtp-Source: ABdhPJwTvZGTqUPEQlPnasfUKJMpJ4KzKuqnQjsTav1fZDNxglp+hmzFmRPxFeFeyvJ8sKbIjKXrQQ==
X-Received: by 2002:a37:9c48:: with SMTP id f69mr11132134qke.114.1613760497138;
        Fri, 19 Feb 2021 10:48:17 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s136sm6831647qka.106.2021.02.19.10.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:48:16 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Christian Eggers <ceggers@arri.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] Revert "cyclictest: Always use libnuma"
Date:   Fri, 19 Feb 2021 13:48:00 -0500
Message-Id: <20210219184801.13905-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210219184801.13905-1-jkacur@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This reverts commit 512d2b74561d5bdab15cacb7b1931cd0aa01d6b5.

libnuma is a buildtime requirement but not a runtime environment

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 63 ++++++++++++++++++++-----------------
 src/cyclictest/rt_numa.h    |  2 ++
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e2753db39c02..3e31937f7088 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1018,6 +1018,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
+			if (numa_initialize())
+				fatal("Couldn't initialize libnuma");
+			numa = 1;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1126,6 +1129,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
 		case OPT_SMP: /* SMP testing */
+			if (numa)
+				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
 			num_threads = -1; /* update after parsing */
 			setaffinity = AFFINITY_USEALL;
@@ -1199,17 +1204,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
+		if (numa_initialize())
+			fatal("Couldn't initialize libnuma");
+		numa = 1;
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
 
-	if (option_affinity && smp) {
-		warn("-a ignored due to smp mode\n");
-		if (affinity_mask) {
-			numa_bitmask_free(affinity_mask);
-			affinity_mask = NULL;
-		}
-		setaffinity = AFFINITY_USEALL;
+	if (option_affinity) {
+		if (smp)
+			warn("-a ignored due to smp mode\n");
 	}
 
 	if (smi) {
@@ -1778,12 +1782,6 @@ int main(int argc, char **argv)
 	int online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
-	void *stack;
-	void *currstk;
-	size_t stksize;
-
-	if (numa_initialize())
-		fatal("Couldn't initialize libnuma");
 
 	process_options(argc, argv, max_cpus);
 
@@ -1972,27 +1970,34 @@ int main(int argc, char **argv)
 		default: cpu = -1;
 		}
 
-		/* find the memory node associated with the cpu i */
-		node = rt_numa_numa_node_of_cpu(cpu);
+		node = -1;
+		if (numa) {
+			void *stack;
+			void *currstk;
+			size_t stksize;
 
-		/* get the stack size set for this thread */
-		if (pthread_attr_getstack(&attr, &currstk, &stksize))
-			fatal("failed to get stack size for thread %d\n", i);
+			/* find the memory node associated with the cpu i */
+			node = rt_numa_numa_node_of_cpu(cpu);
 
-		/* if the stack size is zero, set a default */
-		if (stksize == 0)
-			stksize = PTHREAD_STACK_MIN * 2;
+			/* get the stack size set for this thread */
+			if (pthread_attr_getstack(&attr, &currstk, &stksize))
+				fatal("failed to get stack size for thread %d\n", i);
 
-		/*  allocate memory for a stack on appropriate node */
-		stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
+			/* if the stack size is zero, set a default */
+			if (stksize == 0)
+				stksize = PTHREAD_STACK_MIN * 2;
 
-		/* touch the stack pages to pre-fault them in */
-		memset(stack, 0, stksize);
+			/*  allocate memory for a stack on appropriate node */
+			stack = rt_numa_numa_alloc_onnode(stksize, node, cpu);
 
-		/* set the thread's stack */
-		if (pthread_attr_setstack(&attr, stack, stksize))
-			fatal("failed to set stack addr for thread %d to 0x%x\n",
-				i, stack+stksize);
+			/* touch the stack pages to pre-fault them in */
+			memset(stack, 0, stksize);
+
+			/* set the thread's stack */
+			if (pthread_attr_setstack(&attr, stack, stksize))
+				fatal("failed to set stack addr for thread %d to 0x%x\n",
+				      i, stack+stksize);
+		}
 
 		/* allocate the thread's parameter block  */
 		parameters[i] = par = threadalloc(sizeof(struct thread_param), node);
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 87f5d3b66458..4cbd979c21e8 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -13,6 +13,8 @@
 #include "rt-utils.h"
 #include "rt-error.h"
 
+static int numa = 0;
+
 #include <numa.h>
 
 static void *
-- 
2.26.2

