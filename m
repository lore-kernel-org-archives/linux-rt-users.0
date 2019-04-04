Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F9C10F0C
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126CE20882
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDDNso (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:48:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfDDNso (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 09:48:44 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hC2jR-00031f-HY; Thu, 04 Apr 2019 15:48:41 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 3/4] rt-tests: deadline_tests: fix stack buffer flow
Date:   Thu,  4 Apr 2019 15:48:13 +0200
Message-Id: <20190404134814.13376-4-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190404134814.13376-1-kurt@linutronix.de>
References: <20190404134814.13376-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The appended string is actually longer than 14 characters. Use strlen() to
compute the correct length like the other functions do.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/deadline_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index b213c206559c..4826557d0624 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -435,7 +435,7 @@ static void setup_ftrace_marker(void)
 {
 	struct stat st;
 	const char *debugfs = find_debugfs();
-	char files[strlen(debugfs) + 14];
+	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
 	int ret;
 
 	if (strlen(debugfs) == 0)
-- 
2.11.0

