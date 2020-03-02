Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C1C3F2CD
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE6420732
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCSmjhDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCBVos (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:48 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39262 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCBVor (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id fc12so698624qvb.6
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WO2XtG6b/230cSVTe7YJVQjHYZYhWERxQ0/pwxGz9z0=;
        b=iCSmjhDQFpM9GZ1So+cHg9QDYu7wjAEJZ8EMd6l/9U8RXc6WF3jf5WNhvQ+GfU0Gey
         Sn047irO+tvvuTDbk493W2Rqnc1avMPQRlDc7rly68HYu9LISFosW5dJ2B4+4atVSaAG
         p4EM9wc4mcXcHfwnMWFDqaKFJP5KHzSsfUW3W3DjSH6DyFZLCaNEVlrS6tmqL/AjBB19
         EX1hiEEXxmQZDzZ8ewUPx/XNyxp1tv/nG98scU6rQi17hEnNVHt0RQ+lekFRoOH1o30T
         lKn/GbejpBFyJXupNcFmC9oTR54JFzS6MLa4QFIuJS+IYAiowEZwG/xmLqWaUrhSUBms
         LyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WO2XtG6b/230cSVTe7YJVQjHYZYhWERxQ0/pwxGz9z0=;
        b=sBR5x1RODSJTP274BIutjOURSAhxuoFLswFlqamYYCjzNdQXQ+Eii5lATlFPb7vBTQ
         GUfOxCs0aii7L1B4/g8CDT4kpYmMv1aH6MphtxJXFYOc/mFccGkSRRBdcLQfbN4jlzaF
         vox+SFXhkMNAa/UNYsgDMp08L2p5YwemILq1iPsp25tl/RfRfayWaFl2+SysR9ryRReK
         WTMWTVNOAwFQOWItGktHj7k+MyUn2VOTdxmWUcigMRKnk8BCpKq9Q5EloCGfAZBanqET
         nX395/HHunINkgNDWf0Na3NblwkhI0Bl4vpAerFXCFCfJ0+dA+iXezcYOOlUrDjaLgFP
         vDsQ==
X-Gm-Message-State: ANhLgQ0Gje6OMO/Lo9qIow08ApT7sWzK032GXBkEfLEP8KlcjzKorbew
        kSoNK4aUd8RdxTAS11Bn86U8Olc5pJ4=
X-Google-Smtp-Source: ADFU+vtr5RcC9AJoKHjoxxpRIlVGkbB50Aol6eCd4oG8NzmipQ/88aEtWdQzUKcTZKmgL53Xt9IFrQ==
X-Received: by 2002:a0c:cb05:: with SMTP id o5mr1342823qvk.141.1583185486092;
        Mon, 02 Mar 2020 13:44:46 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:45 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/6] rt-tests: cyclictest: Only run on available cpus according to the affinity
Date:   Mon,  2 Mar 2020 16:44:29 -0500
Message-Id: <20200302214430.15825-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Right now cyclictest acts as if it owns the machine. If you don't
specify the affinity with -a [CPUSET] it will run threads on all cpus.

Change this to only run on cpus according to the affinity.

For example.

taskset -c 0-3 ./cyclictest -t
will only affect the main thread and limit it that to cpus 0-3 but the
threads that are spun off can run anywhere, with this change all threads
will be limited to cpus 0-3

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 39 ++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 18c383689dc2..ce93ad0643cd 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1040,7 +1040,8 @@ static unsigned int is_cpumask_zero(const struct bitmask *mask)
 	return (rt_numa_bitmask_count(mask) == 0);
 }
 
-static int cpu_for_thread(int thread_num, int max_cpus)
+/* cpu_for_thread AFFINITY_SPECIFIED */
+static int cpu_for_thread_sp(int thread_num, int max_cpus)
 {
 	unsigned int m, cpu, i, num_cpus;
 	num_cpus = rt_numa_bitmask_count(affinity_mask);
@@ -1059,6 +1060,36 @@ static int cpu_for_thread(int thread_num, int max_cpus)
 	return 0;
 }
 
+/* cpu_for_thread AFFINITY_USEALL */
+static int cpu_for_thread_ua(int thread_num, int max_cpus)
+{
+	int res, num_cpus, i, m, cpu;
+	pthread_t thread;
+	cpu_set_t cpuset;
+
+	thread = pthread_self();
+	CPU_ZERO(&cpuset);
+
+	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
+	if (res != 0) {
+		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
+	}
+
+	num_cpus = CPU_COUNT(&cpuset);
+	m = thread_num % num_cpus;
+
+	for (i = 0, cpu = 0; i < max_cpus; i++) {
+		if (CPU_ISSET(i, &cpuset)) {
+			if (cpu == m)
+				return i;
+			cpu++;
+		}
+	}
+
+	fprintf(stderr, "Bug in cpu mask handling code.\n");
+	return 0;
+}
+
 
 static void parse_cpumask(const char *option, const int max_cpus)
 {
@@ -2086,11 +2117,13 @@ int main(int argc, char **argv)
 		switch (setaffinity) {
 		case AFFINITY_UNSPECIFIED: cpu = -1; break;
 		case AFFINITY_SPECIFIED:
-			cpu = cpu_for_thread(i, max_cpus);
+			cpu = cpu_for_thread_sp(i, max_cpus);
 			if (verbose)
 				printf("Thread %d using cpu %d.\n", i, cpu);
 			break;
-		case AFFINITY_USEALL: cpu = i % max_cpus; break;
+		case AFFINITY_USEALL:
+			cpu = cpu_for_thread_ua(i, max_cpus);
+			break;
 		default: cpu = -1;
 		}
 
-- 
2.20.1

