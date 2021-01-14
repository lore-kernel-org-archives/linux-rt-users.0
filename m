Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE4C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 11:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF7D23A40
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 11:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhANLva (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbhANLva (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Jan 2021 06:51:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8867C061573
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jan 2021 03:50:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so7690471ejf.11
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jan 2021 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4Xb+bb8ti/sc2nE7cURZvHqHLU3TbypPUuEyIL2/T0=;
        b=nu6b8/6OoZbnR6DV2UddIIkP94e9R0kbITWPZjqVZeYXw2z/jJyNrR2d6Sqc8T+EyH
         qFDKK3VnsbJEKhJjyLLCa6h2HRgaZbqZ4P/8wPmRLBIFzpDEAczgMdH4YYGyfA+3Z8qm
         tUEmP3hDaA2TSykxdQdnzjg6XFTJXS1Jq4seDtS8vSNE5unMx+tej+Mr8tfEX8VU8D6e
         7q/zFLcJ8w86kWriBORpF12ppeflD/4yefFKYrl9p8enLlM9Od5vfdeotGzc8ctDcRLt
         fkxzrYCKcvRh5VrE0BTuoOgX1NFjxQ8bokxY2V+Th6JVUt89PeTzCmom4YA6PseA+mMk
         jSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4Xb+bb8ti/sc2nE7cURZvHqHLU3TbypPUuEyIL2/T0=;
        b=FVtT//4dL7odGgqhdKKlWBatpw9nLLx+yTjeCcRVHE9Fo+tThvkbWQuL2jLGo3zGk9
         GLoBnt7+HRP3V+3JGhF8xYJ9uJmPGpd1jrkIsOX/FuQaMZ6BrLJVs3NHU5q7R8pC1Vow
         GcyHc+ukNE8FRkKBTL7h5hDNbmJAM43wJRqhtPYp+BFSTvyN2Ns8FoRK0JqeGSq5DCuU
         GtGUdMiI/UeI8+EPELjcMa70/apSYb6Jb02jxEmxDdSGPkFQdTDweD30RRkb7xz3+6PX
         6FegZqfJ6pi2ExSXkntQ9Qi5V4AhZx/jsDL1qmuSXr+pHO82ZvL0HC2E+q2I2/IoSscF
         ZF5w==
X-Gm-Message-State: AOAM5336NfaDjTXrYzrEP9/cazOx1NYMHWWBwRmcMReYyrQ56EGgnLsD
        tOMTt6SXke+wnlyW7lUBXkwRDghtPYObfWQO
X-Google-Smtp-Source: ABdhPJyPwWkwWludeVki84v8G1Tr6XuOzdj3kREKCbq351pf4DWQNVI0xndXVC5NQOLeMGduxpdECg==
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr4911528ejn.236.1610625048338;
        Thu, 14 Jan 2021 03:50:48 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-b848-b100-294a-e84e-69b8-cbf6.c22.pool.telefonica.de. [2a01:c22:b848:b100:294a:e84e:69b8:cbf6])
        by smtp.gmail.com with ESMTPSA id h23sm1873469ejg.37.2021.01.14.03.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:50:47 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] cyclictest: Fix --affinity when intermediate CPUs are offline
Date:   Thu, 14 Jan 2021 12:50:30 +0100
Message-Id: <20210114115030.92296-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use max_cpus = sysconf(_SC_NPROCESSORS_CONF) to determine the number of
the maximum CPU (+1).
The cpu_for_thread_*() functions check the first max_cpus bits
in the cpuset / cpumask.
This fixes failing to set the affinity to CPUs >= num_online_cpus,
if some intermediate CPU is offline, e.g. on an AMD system
with nosmt.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f38c453..b104e4c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1741,7 +1741,8 @@ int main(int argc, char **argv)
 	int signum = SIGALRM;
 	int mode;
 	int cpu;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
 
@@ -1750,8 +1751,10 @@ int main(int argc, char **argv)
 	if (check_privs())
 		exit(EXIT_FAILURE);
 
-	if (verbose)
+	if (verbose) {
 		printf("Max CPUs = %d\n", max_cpus);
+		printf("Online CPUs = %d\n", online_cpus);
+	}
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask != NULL) {
-- 
2.29.2

