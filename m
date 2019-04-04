Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B69C4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DC02171F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfDDNsn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:48:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfDDNsm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 09:48:42 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hC2jQ-00031f-8H; Thu, 04 Apr 2019 15:48:40 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/4] rt-tests: cyclicdeadline: fix segmentation fault on close
Date:   Thu,  4 Apr 2019 15:48:11 +0200
Message-Id: <20190404134814.13376-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190404134814.13376-1-kurt@linutronix.de>
References: <20190404134814.13376-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The current code generates a segmentation fault in the last free() call.

  $ sudo ./cyclicdeadline
  Using all CPUS
  /sys/kernel/debug/sched_features: Success
  interval: 600:1000
    Tested at 5us of 600us
  deadline thread 2963
  thread[2963] runtime=600us deadline=1000us
  main thread 2962
  fail 2 0
  T: 0 ( 2963) I:1000 C:   1268 Min:      7 Act:   55 Avg:   56 Max:     256
  [1]    2961 segmentation fault  sudo ./cyclicdeadline

This is caused by a buffer overflow in setup_ftrace_marker(). The appended
string is 21 not 14 characters wide. Fix it by using strlen() like the other
function do.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 08460107c464..303b5e96647a 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -283,7 +283,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + 14];
+	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
 	int ret;
 
 	if (strlen(debugfs) == 0)
-- 
2.11.0

