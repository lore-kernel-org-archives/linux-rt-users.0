Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03654C07E95
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC496100C
	for <linux-rt-users@archiver.kernel.org>; Sun,  4 Jul 2021 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhGDUkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 16:40:47 -0400
Received: from mail.monom.org ([188.138.9.77]:39764 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhGDUjH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jul 2021 16:39:07 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C458B500609;
        Sun,  4 Jul 2021 22:36:29 +0200 (CEST)
Received: from localhost (unknown [94.31.98.41])
        by mail.monom.org (Postfix) with ESMTPSA id 7E0DA5006B4;
        Sun,  4 Jul 2021 22:36:29 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 3/3] cyclicdeadline: Fix buffer allocation
Date:   Sun,  4 Jul 2021 22:36:21 +0200
Message-Id: <20210704203621.5612-4-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704203621.5612-1-wagi@monom.org>
References: <20210704203621.5612-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <dwagner@suse.de>

gcc complains with "‘sprintf’ output between 2 and 12 bytes" but
the buffer is only 10 bytes long. Update the buffer size to hold
the complete range of [-2147483648, 2147483646].

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ffefa9e6fecb..8447424273ee 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1092,7 +1092,7 @@ int main(int argc, char **argv)
 
 	/* Default cpu to use is the last one */
 	if (!all_cpus && !setcpu) {
-		setcpu_buf = malloc(10);
+		setcpu_buf = malloc(12);
 		if (!setcpu_buf)
 			fatal("malloc");
 		sprintf(setcpu_buf, "%d", cpu_count - 1);
-- 
2.32.0
