Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159FC31E5E
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3342080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfFRKjr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfFRKjr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:47 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWi-0005SS-ET; Tue, 18 Jun 2019 12:39:44 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 4/6] rt-tests: cyclicdeadline: Add options to usage
Date:   Tue, 18 Jun 2019 12:38:39 +0200
Message-Id: <20190618103841.27249-5-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The current usage doesn't show the available options:

 $ sudo ./cyclicdeadline -h
 usage: cyclicdeadline

So, add the options to the help text to see what can be configured.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 17786db45612..7cffe826b944 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -631,8 +631,16 @@ static void usage(char **argv)
 		p--;
 	p++;
 
-	printf("usage: %s\n"
-	       "\n",p);
+	printf("usage: %s [options]\n"
+	       " -h - Show this help menu\n"
+	       " -a - Use all CPUs\n"
+	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
+	       " -i interval(us) - The shortest deadline for the tasks (default 1000us)\n"
+	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
+	       " -t threads - The number of threads to run as deadline (default 1)\n"
+	       " -D time - Specify a length for the test run\n"
+	       "           Append 'm', 'h', or 'd' to specify minutes, hours or days\n"
+	       "\n", p);
 	exit(-1);
 }
 
-- 
2.11.0

