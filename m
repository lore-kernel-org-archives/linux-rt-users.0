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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483EC433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DE61A2A
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhCYUSq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCYUSm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 16:18:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF9C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bx7so3824372edb.12
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zu0qqO0/ILxxQQ4i0lvvhPkLzvj+iTEtEJ7oK5YQ75s=;
        b=Cg+sEbEhDZOTld/TCNbCmoi+YqD1wqXERJ381CRKGvRRzVf4acsE01OIx8OfB3lNKo
         cIH2ktBdYSU4syUfUBdQ2qTIjXk+Y8UeicDSoyS4hYce8rkSuDjNxjabeIERxdx5uo3T
         CZvvsjUZxlvQKU6Rb2XUVmfJ0XYfEsa/GMNG2PTyb+wM6i3CoMrlG+mYodmrRaCDSqBB
         c1msFQmLLzjhBntYVre16wkWyuQaByEN2+Cu3yqq4EOskyuAC5YZvAfuWyWGc+FLj7z/
         w8ckuFBCNocpxoKnhgHQct6X925Dz5XWA5psc7WRHtB+EL4GEL5MN6caq1ApNoR60I+/
         fgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zu0qqO0/ILxxQQ4i0lvvhPkLzvj+iTEtEJ7oK5YQ75s=;
        b=WX0i24W8SYBZ3hM8Bw5hYgBWxKX3s8E+GJfpHpOFrVohQ3JhUtCQ/ydIGJhbTzX/gP
         gX2A5mHSNhjI1po+HisiKO1THfFGNAy/rKB20al8XTyj1YbZLU2iU/3VOQgytPti0Gzd
         w0lg9ewqN251kybUObnRxHWS5tLV0/T6thfeU9L3aX1zzp/f5WwJ2xKGZNiJmxU9zl4d
         hpmTU8czPB5lixF1/K2LEaUhtP7lzc/WV53DfjDM4CNOkJV5oA87JEGm/7efNXVpG2vf
         01TGtIcFHEzRXo9qP0EX/2dNeXQzv4/I9Nw9gBTF/z3sCJqJq/SfIw07AS6Z2P66CK5W
         TjSQ==
X-Gm-Message-State: AOAM533ky9VUo+FVQc4uo1hlzUx0bLbADsImUYf7lpZJy8XGLMAnbiAs
        hXz4aFkDU9/OJlYx2AJxS4b8pc9YieRQZA==
X-Google-Smtp-Source: ABdhPJxqHXZ6qkw6Y3IrqgZR0jK+pSYnn/9gBMB9U+7iTC0ESSTnxaGme5Oxh2apwY5u328arCjiWQ==
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr11389888edb.282.1616703520457;
        Thu, 25 Mar 2021 13:18:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c47-0000-17ef-d1e1-78a0-d19c.c23.pool.telefonica.de. [2a01:c23:6c47:0:17ef:d1e1:78a0:d19c])
        by smtp.gmail.com with ESMTPSA id a22sm3135406edu.14.2021.03.25.13.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 13:18:40 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v3 1/2] cyclictest: Move main pid setaffinity handling into a function
Date:   Thu, 25 Mar 2021 21:18:36 +0100
Message-Id: <7204424803922d15bb11bba65bb5672cd76aa20c.1616702706.git.schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616702706.git.schwenderjonathan@gmail.com>
References: <cover.1616702706.git.schwenderjonathan@gmail.com>
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
index dca9610..460f6ae 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1791,13 +1791,7 @@ int main(int argc, char **argv)
 
 	/* Restrict the main pid to the affinity specified by the user */
 	if (affinity_mask != NULL) {
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
index babcc63..9a81cfb 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -138,3 +138,14 @@ int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
 
 	return 0;
 }
+
+void try_numa_sched_setaffinity(pid_t pid, struct bitmask *cpumask)
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
2.30.2

