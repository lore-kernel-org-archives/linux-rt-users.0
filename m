Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC0BC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2430B64E61
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhBVPay (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhBVPaX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 10:30:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFDC06178A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p2so22441722edm.12
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkKrDd/pzIy0dOdP78FtLctosbwewsaSYszx0JCUI5I=;
        b=O4V2XyEKIw+qYTNCcMYYLCaoBVMT/5avbkgZ8Zp3s3+t3N7td4606VXNuzslG22Gs3
         ECL2M+Gzn3o9H/5QnJ/sE/qArQW7u1nqStkVyfAvO4ENb8Ut29omZrCGclx40jWutyOj
         Z/tbFKxllquY1vFxeagv6/xk9/p4jht7FUQGjk1S74OV5B3WIESHZzxx5uSpcaYqyEYo
         u+LcouZcyc/9O43gDzPYnk09MLvTCeNC8/O6fa/n7gwAbu8VdII69ER9ef9sEmDoDQcd
         bePrI06x6H3XQABGBoCpE6wSAuPNMZq1Nwv5i9jJRda6wAeQMVgH0YNmQqOLo966hKXv
         yBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkKrDd/pzIy0dOdP78FtLctosbwewsaSYszx0JCUI5I=;
        b=MRU0OxN+p/8/iubNjEMSt0Eb8z8NI1UX2KrN2/HKJJmBEtjrbuLlppr6nGumK0ns4D
         +GTRHvIxH45CPWEowUuM0u5rTwwsRWwe0BVqA70SgdnByuWx3GWRNZ5IpEfeUtmogVV9
         bK3iarloO6Lp+uIIPk1L2fpU2h0Hgn4toNC93PBvwPAIa7w0WNDB9F9ldtsn2H+3CHpo
         3QtXVNDiDg1saw5EpuYW+T7Iy8WobmiyPfiNWIDfVDWFkDBrampyEHYLX+Qc9g/+z5u7
         6IUaxmmeLbnmOPIkL9ccv+ginL7z7Z4qA8vP2FTkcRsS+NEvDgondFjGEJcWs7IyOf7m
         apGA==
X-Gm-Message-State: AOAM532kIT21fAFXsRLGTCHZDq8EWwZ1g2/WhMfPwn2HyWMKGVTTa8ku
        oJs9MH4Xd3eJFK7ja7iW8EQ=
X-Google-Smtp-Source: ABdhPJyakjCZrc1MYmN+F70HZW+cDZvQGgtkN5UW7TWcvGiXsIW5aFdkqj6YFRICXjhx0mDqxx0Vfw==
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr668093edc.314.1614007779658;
        Mon, 22 Feb 2021 07:29:39 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c04-5000-dab0-26a8-91ef-23f9.c23.pool.telefonica.de. [2a01:c23:6c04:5000:dab0:26a8:91ef:23f9])
        by smtp.gmail.com with ESMTPSA id bw22sm10657116ejb.78.2021.02.22.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:29:39 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] cyclictest: Move main pid setaffinity handling into a function
Date:   Mon, 22 Feb 2021 16:28:32 +0100
Message-Id: <20210222152833.8758-3-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222152833.8758-1-schwenderjonathan@gmail.com>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Move error handling for setting the affinity of the main pid
into a separate function.
This prevents duplicating the code in the next commit,
where the main thread pid can be restricted to one of
two bitmasks depending on the passed parameters.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c3d45f3..3cd592d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1749,6 +1749,16 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
+static void set_main_thread_affinity(struct bitmask* cpumask) {
+	int res;
+
+	errno = 0;
+	res = numa_sched_setaffinity(getpid(), cpumask);
+	if (res != 0)
+		warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
+}
+
+
 int main(int argc, char **argv)
 {
 	sigset_t sigset;
@@ -1778,13 +1788,7 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask) {
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
2.29.2

