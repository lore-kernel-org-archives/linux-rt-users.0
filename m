Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE67C31E51
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB9F2080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfFRKjq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKjq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:46 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWh-0005SS-EM; Tue, 18 Jun 2019 12:39:43 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 2/6] rt-tests: cyclicdeadline: Remove unused getcpu code
Date:   Tue, 18 Jun 2019 12:38:37 +0200
Message-Id: <20190618103841.27249-3-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The getcpu() system call isn't used in the program. Therefore, it can be
removed.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 754670c4e7d4..2b83665cab66 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -24,16 +24,6 @@
 #include <rt-utils.h>
 #include <rt-sched.h>
 
-#ifdef __i386__
-#ifndef __NR_getcpu
-#define __NR_getcpu			309
-#endif
-#else /* x86_64 */
-#ifndef __NR_getcpu
-#define __NR_getcpu			309
-#endif
-#endif /* i386 or x86_64 */
-
 #define _STR(x) #x
 #define STR(x) _STR(x)
 #ifndef MAXPATH
@@ -44,7 +34,6 @@
 #define CPUSET_LOCAL	"my_cpuset"
 
 #define gettid() syscall(__NR_gettid)
-#define getcpu(cpup, nodep, unused) syscall(__NR_getcpu, cpup, nodep, unused)
 
 typedef unsigned long long u64;
 typedef unsigned int u32;
-- 
2.11.0

