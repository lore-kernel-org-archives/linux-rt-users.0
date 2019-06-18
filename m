Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E830C31E51
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ABD2080C
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfFRKjt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbfFRKjs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:48 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWj-0005SS-Ir; Tue, 18 Jun 2019 12:39:45 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 6/6] rt-tests: cyclicdeadline: Fix cgroup setup
Date:   Tue, 18 Jun 2019 12:38:41 +0200
Message-Id: <20190618103841.27249-7-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Deadline tasks cannot be pinned to specific CPUs by using affinities. Cgroups
have to be used instead. Cylicdeadline has code to do so. However, that code is
never executed, because the all_cpus variable is reassigned after argument
parsing. Remove it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 16d986a02244..7b5e8b36c4ea 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1165,7 +1165,6 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	all_cpus = 1;
 	if (!all_cpus) {
 		int *pids;
 
-- 
2.11.0

