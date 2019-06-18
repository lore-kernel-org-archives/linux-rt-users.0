Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8216C31E5D
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0DE2080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfFRKjs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47079 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKjr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:47 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWj-0005SS-1Y; Tue, 18 Jun 2019 12:39:45 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 5/6] rt-tests: cyclicdeadline: Print fail only if something failed
Date:   Tue, 18 Jun 2019 12:38:40 +0200
Message-Id: <20190618103841.27249-6-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It is interesting to see what went wrong in case something did. However, the
fail statement is printed always. That is confusing.

Furthermore, the fail value is always 1 when a failure happened. There is no
need to print it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 7cffe826b944..16d986a02244 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1204,10 +1204,11 @@ int main (int argc, char **argv)
 	printf("main thread %d\n", gettid());
 
 	pthread_barrier_wait(&barrier);
-	printf("fail 2 %d\n", fail);
 
-	if (fail)
+	if (fail) {
+		printf("fail 2\n");
 		exit(-1);
+	}
 
 	pthread_barrier_wait(&barrier);
 
-- 
2.11.0

