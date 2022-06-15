Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF5C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 11:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbiFOLix (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347478AbiFOLiu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 07:38:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507783A5EE
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 04:38:49 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:38:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655293127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=S/n78tGv1vSo8yCEwFzSvr1/9M/zyYKYQotAGOP9Q5k=;
        b=RA+I0OQL5HnQWvsHgHhLXQtsyFXUY1b7oqT437Zc7kCgom0+sOw9LdW3FCaOwBykihjwma
        juiSZ7VQSueq8qCwefeR0Z3LbU2vouiXPE3LurMtJvpEU2sIFfO3bA2sb+BSsPOryZ66qh
        ooUuUqgp5LIz8nrMlfoOAE4TG6dunjfJdunMBhFd+KLEaCYC/UIDVW/VCsV4ybGm3pAk+g
        AyshY/sBaR6IMjVEyHPBf2sytUqWKpU6jqtRWjvfn2+pjxV4itjtmRmDd3FLHqI/qyImiP
        QOIvHwpa+64w3NIdqRsIxiHFZDstoieuKbZryoDAAqV8oZvz8KZV3br43sU+zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655293127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=S/n78tGv1vSo8yCEwFzSvr1/9M/zyYKYQotAGOP9Q5k=;
        b=660Loo72758aAwAy3TyjFKUfGdBD1A2eNlMc97QIPGxfwbJouin5HuM5D/mZpVqXEf0tHe
        DLve3wQ9oy7ujFBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
Message-ID: <YqnExv0GkIKTSwoI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Assuming the current affinity mask of the task is 0x31 (CPUs 0, 4, 5).
Starting cyclictest with '-S' option will fork the following threads:
- monitor, mask 0x31
- measure thread 1, mask 0x01
- measure thread 2, mask 0x10
- measure thread 3, mask 0x20

works as expected. Using the options '-S --mainaffinity=0' leads to:
- monitor, mask 0x01
- measure thread 1, mask 0x01
- measure thread 2, mask 0x01
- measure thread 3, mask 0x01

because the mask of the main thread has been reset early to 0x01 and
does not allow a CPU mask outside of this mask while setting the
affinity for the new threads.

Delay setting the affinity of the main/ monitor thread after the
measuring threads have been deployed. This leads to the following
state:
- monitor, mask 0x01
- measure thread 1, mask 0x01
- measure thread 2, mask 0x10
- measure thread 3, mask 0x20

Signed-off-by: Sebastian Andrzej Savior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be8285a072b4e..cbf8d00293ec6 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1816,10 +1816,7 @@ int main(int argc, char **argv)
 		printf("Online CPUs = %d\n", online_cpus);
 	}
 
-	/* Restrict the main pid to the affinity specified by the user */
-	if (main_affinity_mask != NULL) {
-		set_main_thread_affinity(main_affinity_mask);
-	} else if (affinity_mask != NULL) {
+	if (affinity_mask != NULL) {
 		set_main_thread_affinity(affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
@@ -2094,6 +2091,10 @@ int main(int argc, char **argv)
 			fatal("failed to create thread %d: %s\n", i, strerror(status));
 
 	}
+	/* Restrict the main pid to the affinity specified by the user */
+	if (main_affinity_mask != NULL)
+		set_main_thread_affinity(main_affinity_mask);
+
 	if (use_fifo) {
 		status = pthread_create(&fifo_threadid, NULL, fifothread, NULL);
 		if (status)
-- 
2.36.1

