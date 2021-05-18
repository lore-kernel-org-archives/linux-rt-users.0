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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429FC43460
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CFD610CB
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbhERIif (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 May 2021 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhERIif (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 May 2021 04:38:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942DFC061573
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n2so9300437wrm.0
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LEdLVj/NvOs1QihkGhuyC3eEp9YSINNvjzmCLxVtMQ=;
        b=kHG/4C4LJNjFuai5rCQcz/kTGJeoYVLtb3IJESbARWfXkS0n8luHfZi5QJauo+2oi0
         V/J/S1dI7KYIhUy3v+jgwOxi/XXFahjFRzQIY5zOhOwmsRVjDARxRCoBGnGS76ciBswB
         5jaROSWogJiKz4RgzIlYbnBlzljm0pgBCf+ny3DAkBlWk4uEnhDj3kgC2q4X0dCteJcG
         6IakztYT2oBCwNkVQtTXhIG/pqylQpVto5vcEAbdnjUk3Ek6fuFZR9QKJeRC3BxSTdlb
         Ml0WxW++VwHANZ1FG3wJjITuCG4xQGMOHMOL6XBurfrc4A7j7AmK7xHaDhwXcHhSDPEr
         9tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LEdLVj/NvOs1QihkGhuyC3eEp9YSINNvjzmCLxVtMQ=;
        b=EARYK80i9AizikJhmN/RtV/rwsGF0Fab8Ft3SXKvr9PfybxSynGnuHBfp/BBVMHOMe
         w/FBqtP28ACZ21NFsmuTX22ucgRSyhwnk2cmfZaxsQpkOieBiCKj3IxmT7sM8hkDrX9v
         2ZR3MrKGkBqwbI1/p/4DAcs1uNzdvMubsSfHlT0x0TaUTGHNPusAQoaqxkorlvWPWym2
         JfJ/YUWOV25rmqcHe9vyjqc+cYXrJ4kO0oPIsG1qITtqvFOXaJv39p1mgGOe3pdnfplF
         oOgpv1xC9uwdDjHLBR/MXADEH797vH9xWRw9Or/yTiHq4u6RJ66HoxUey3l/8PCkxfmE
         A3FA==
X-Gm-Message-State: AOAM5323FEvoOsgHHBu7rk4OlFSEsK97auCACTepHrBXhI5ygC5FtEoR
        dsJ9RkFJYm9HZX2NGt0TZaE4gYlcnpv34w==
X-Google-Smtp-Source: ABdhPJxqqh8yaKeawI/nnf0JFd4wBQvqCgdyFSxCDC+AWr6WlM7RY5QkCnQbz/CT3fdgBt8qPgh2Yw==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr5317878wrn.255.1621327036332;
        Tue, 18 May 2021 01:37:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c56-8d00-e863-f49d-2f62-8043.c23.pool.telefonica.de. [2a01:c23:6c56:8d00:e863:f49d:2f62:8043])
        by smtp.gmail.com with ESMTPSA id c14sm20439407wrt.77.2021.05.18.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 01:37:15 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v4 1/2] cyclictest: Move main pid setaffinity handling into a function
Date:   Tue, 18 May 2021 10:37:11 +0200
Message-Id: <20210518083712.8237-2-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518083712.8237-1-schwenderjonathan@gmail.com>
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Move error handling for setting the affinity of the main thread
into a separate function.
This prevents duplicating the code in the next commit,
where the main thread pid can be restricted to one of
two bitmasks depending on the passed parameters.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 59dda19..3bab3b2 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1768,6 +1768,17 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
+static void set_main_thread_affinity(struct bitmask *cpumask)
+{
+	int res;
+
+	errno = 0;
+	res = numa_sched_setaffinity(getpid(), cpumask);
+	if (res != 0)
+		warn("Couldn't setaffinity in main thread: %s\n",
+		     strerror(errno));
+}
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1792,13 +1803,7 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask != NULL) {
-		int res;
-
-		errno = 0;
-		res = numa_sched_setaffinity(getpid(), affinity_mask);
-		if (res != 0)
-			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
-
+		set_main_thread_affinity(affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
 				numa_bitmask_weight(affinity_mask));
-- 
2.31.1

