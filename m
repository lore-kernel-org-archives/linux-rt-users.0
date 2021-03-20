Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B9C43446
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF761946
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Mar 2021 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCTSjM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:39:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhCTSik (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 20 Mar 2021 14:38:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BABEAD6D;
        Sat, 20 Mar 2021 18:38:39 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v3 26/33] pip_stress: Move test result output to main
Date:   Sat, 20 Mar 2021 19:38:22 +0100
Message-Id: <20210320183829.1318-27-dwagner@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320183829.1318-1-dwagner@suse.de>
References: <20210320183829.1318-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Instead printing the result high() close directly move it to main()
function to simplify the return code if the test fails.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/pi_tests/pip_stress.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 8b91578f9ab8..2c3288984202 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -146,6 +146,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	} else if (pid1 != 0) {		/* parent code */
 		low(pid1);
+		exit(0);
 	} else {			/* child code */
 		pid2 = fork();		/* parent code */
 		if (pid2 == -1) {
@@ -155,9 +156,15 @@ int main(int argc, char *argv[])
 			high(pid2);
 		} else {			/* child code */
 			medium();
+			exit(0);
 		}
 	}
 
+	if (statep->inversion)
+		printf("Successfully used priority inheritance to handle an inversion\n");
+	else
+		printf("No inversion incurred\n");
+
 	exit(0);
 }
 
@@ -222,14 +229,6 @@ void high(pid_t pid)
 	Pthread_mutex_unlock(resource);
 	kill(pid, SIGKILL);	/* kill the medium thread */
 	waitpid(pid, &status, 0);
-
-	Pthread_mutex_lock(statep->mutex);
-
-	if (statep->inversion)
-		printf("Successfully used priority inheritance to handle an inversion\n");
-	else
-		printf("No inversion incurred\n");
-	Pthread_mutex_unlock(statep->mutex);
 }
 
 /* mmap a page of anonymous shared memory */
-- 
2.30.2

