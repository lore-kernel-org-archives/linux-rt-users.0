Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E90C28CC5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851F2206C3
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfFEQGg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:36 -0400
Received: from mail.monom.org ([188.138.9.77]:35598 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfFEQGc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:32 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 28F3E5006C0;
        Wed,  5 Jun 2019 18:06:30 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id E54EA5004BB;
        Wed,  5 Jun 2019 18:06:29 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 02/12] queuelat: Use clock syscall for ARM 32 bit
Date:   Wed,  5 Jun 2019 18:06:07 +0200
Message-Id: <20190605160617.22987-3-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

CPUs such as Cortex-M8 don't have a rdtsc instruction. Fallback using
a syscall.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 src/queuelat/queuelat.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 3b291f168768..a5525e41776a 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
+#include <time.h>
 
 #define NSEC_PER_SEC 1000000000
 
@@ -249,6 +250,8 @@ typedef unsigned long long cycles_t;
 typedef unsigned long long usecs_t;
 typedef unsigned long long u64;
 
+#if defined __x86_64__ || defined __i386__
+
 #ifdef __x86_64__
 #define DECLARE_ARGS(val, low, high)    unsigned low, high
 #define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
@@ -270,7 +273,25 @@ static inline unsigned long long __rdtscll(void)
         return EAX_EDX_VAL(val, low, high);
 }
 
-#define rdtscll(val) do { (val) = __rdtscll(); } while (0)
+#define gettick(val) do { (val) = __rdtscll(); } while (0)
+
+#elif defined __arm__
+
+static inline unsigned long long __clock_gettime(void)
+{
+	struct timespec now;
+	int ret;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &now);
+	if (ret < 0)
+		return 0;
+
+	return now.tv_nsec;
+}
+
+#define gettick(val) do { (val) = __clock_gettime(); } while (0)
+
+#endif
 
 static void init_buckets(void)
 {
@@ -348,9 +369,9 @@ static void run_n(int n)
 
 	memmove(dest, src, n);
 	for (i = 0; i < loops; i++) {
-		rdtscll(b);
+		gettick(b);
 		memmove(dest, src, n);
-		rdtscll(a);
+		gettick(a);
 		delta = (a - b) * cycles_to_ns;
 		account(delta);
 	}
@@ -446,9 +467,9 @@ void main_loop(void)
 		int ret;
 		int nr_packets_fill;
 
-		rdtscll(b);
+		gettick(b);
 		memmove(dest, src, default_n);
-		rdtscll(a);
+		gettick(a);
 		delta = (a - b) * cycles_to_ns;
 		account(delta);
 
-- 
2.20.1
