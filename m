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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164FC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BF264E4B
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBWNzq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhBWNzi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 08:55:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A181DC061574
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id n1so25996782edv.2
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gC9qbpc9HsjVGrCulcPNTEGYs7NJWyDGuJZPeAGtdhw=;
        b=h8JBVVaW7btt5O4nPBMHnuteeWfNA2Qz/71y8hcSFsBXcPAjacvC0QJ4DdbvnLf6qS
         nhFQyFtZn9iURppEBkulMUjlh4cooch6mByz7idp02vblyTNHKz0Qs/L5VpZGWNIIqm1
         GJUqyffC4s/d3jRlLgKq2qNld/z5xGbfSe1mu8K7iTrRbQgGk9BK6B2Ca4KZaDEjuDfI
         6bTWSHBYhwF56jq7/0DFD10lFF9IQuxnFuKIi9Yzr3qM8jK7GpxQZSUblNDXPZVpJyri
         mP1j0gs33sGST9HOEKnrhJ6syHcfC6P9Y/OoWzrSjaNIlUdkwHKcgg3KJ5iub1ejM7PY
         lALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gC9qbpc9HsjVGrCulcPNTEGYs7NJWyDGuJZPeAGtdhw=;
        b=QuPzvCkiTiDS1Bznu6VCOnGbBfEzv7KRqbtyFi+TnmlKLDXfD+5upkGSjqqyHz6x08
         z1wGnrbY6qMsYBvrTk3+IHQ1JiABjfOodzBWgJPZWuRuWAIyVaayG1/o8Dg6gLrk5M7A
         M3pVhToP9IvOCGr/uJYi7bCnBiDID+mT4xiZ0mcLH2GXc6GzLeKUYYxl7U4T2Qodi/pw
         GaBmDmWpobYwN2pOpIkiINWV+t4HfIlPxBvbDjzNf3oJRjm2OXNNtedDi8COpkDCl5xn
         +qkTblWQpCP9imgUWvIgISvQj5yCHQ7VDN1+TG4XY5+E2zQFpX1DeDax4jCgVVsPZcOW
         rEkw==
X-Gm-Message-State: AOAM531FWUJ9V7P6H9ynl55yHY8E6m2LyXZ5A9v4YVic875dxUF3pWW1
        Ft37tXLP/dHDnOQR25sejP0=
X-Google-Smtp-Source: ABdhPJwbHFJMKImDfJXncwKSBfX6rsHUUCeLr0x3v/UVkRAG46XtljcaAplBXS5jewM2SZRhIh2bKg==
X-Received: by 2002:aa7:cb49:: with SMTP id w9mr24634660edt.375.1614088496292;
        Tue, 23 Feb 2021 05:54:56 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6883-f900-4d8f-ff61-45e1-6480.c23.pool.telefonica.de. [2a01:c23:6883:f900:4d8f:ff61:45e1:6480])
        by smtp.gmail.com with ESMTPSA id z13sm14447509edc.73.2021.02.23.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:54:55 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v2 1/2] cyclictest: Move main pid setaffinity handling into a function
Date:   Tue, 23 Feb 2021 14:54:45 +0100
Message-Id: <20210223135446.7201-2-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223135446.7201-1-schwenderjonathan@gmail.com>
References: <20210223135446.7201-1-schwenderjonathan@gmail.com>
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

After feedback from John Kacur, the function is now
located in src/lib/rt-numa.c.
This allows other tests to reuse this, if they also
prefer to warn if numa_sched_setaffinity fails.

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c |  8 +-------
 src/include/rt-numa.h       |  2 ++
 src/lib/rt-numa.c           | 11 +++++++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c3d45f3..9d8eca8 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1778,13 +1778,7 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask) {
-		int res;
-
-		errno = 0;
-		res = numa_sched_setaffinity(getpid(), affinity_mask);
-		if (res != 0)
-			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
-
+		try_numa_sched_setaffinity(getpid(), affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
 				numa_bitmask_weight(affinity_mask));
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
index ca86a45..e9fa312 100644
--- a/src/include/rt-numa.h
+++ b/src/include/rt-numa.h
@@ -18,4 +18,6 @@ int cpu_for_thread_ua(int thread_num, int max_cpus);
 
 int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
 
+void try_numa_sched_setaffinity(__pid_t pid, struct bitmask *cpumask);
+
 #endif
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index dbeaef6..33c80a7 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -133,3 +133,14 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 
 	return 0;
 }
+
+void try_numa_sched_setaffinity(__pid_t pid, struct bitmask *cpumask)
+{
+	int res;
+
+	errno = 0;
+	res = numa_sched_setaffinity(pid, cpumask);
+	if (res != 0)
+		warn("Couldn't setaffinity for thread %d: %s\n", pid,
+		     strerror(errno));
+}
-- 
2.29.2

