Return-Path: <SRS0=BQEv=4G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB6C34026
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E6A21D56
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi31mfsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBRTzk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:55:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34440 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTzj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Feb 2020 14:55:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id c20so20782290qkm.1
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Feb 2020 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXjBSb71oox5uwsoI3Sz1ph2dont8APNGuNtB6qNvkA=;
        b=Wi31mfsLw6fGaQAybrKwvcdzw1u1L0kMqpqF98fJWpOJruR3OyY5mfYJz1tTK6dEcr
         cZ7jGALpb6oAi3bJUyCWSDDnbHWi2QQDQDgFRgxWxGjWbmPaalw01OUT4MNfUGUSrwC7
         n+C8z6aMIWUM5Yrh3KKg8zeds5dYD6ZXKpbxKnRWhdY2eCCBbjbUSVPvv9qUVuLfkH9k
         FCPxMcCUfpuf1t2r1xmO0pr/xRV8qr9Uf6gNt59wk4TojyMUEVI0yceSA6kv9xzhb4cD
         Vspy7iIWxTZ4GT/xwEp1geTMz2S2RKiSdV3Ul/a9EZonl+7rbpQxBxiWJ1LYUyFT5PmV
         EP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CXjBSb71oox5uwsoI3Sz1ph2dont8APNGuNtB6qNvkA=;
        b=YkgucaEZnDdCiX6NiF7ZRKVX2wYodM0PbuKFe9lJipnnoaPKh2yeoDWRdRv+j7K48H
         zst71RdUJB4V0IGLT5yZR6ElCZ3nd0bbwsLXapxi/T0QlzVnTKr2aG5/qPh6ImDxdSJ0
         TJ6YFN6wORBjGm28u0AjWQft58BTdan7wyHZ/l2T67O9sgJUTsywtj8U2YvSelYHkb8o
         1J5t/Us1mZBp9MxRYxz3cr5HzjaBWNG6A7umoha1sj6zuFfgAmFBFmjCRnS2CzTF9Lqq
         xjfmflwymMfoomF5jomRK7SYkKue+okd/kkXTzb6bOinZd048xm0rdg7/6UZUZRMepoe
         21tA==
X-Gm-Message-State: APjAAAW/N46RwdDOpKt/jTPM99yfsFzWlog+OckoCHRkJD+LLZ3jbvm9
        Ja9JZCl7SlfGSXTn/ugLywz3WQPF
X-Google-Smtp-Source: APXvYqy48cdTggneR9EgzS5aM21sklRPYJNFUuoTXESwpPEgUJ+mkWMlklBWTV2jT8VtdCcMlIfvXA==
X-Received: by 2002:a05:620a:22e:: with SMTP id u14mr4314413qkm.278.1582055738594;
        Tue, 18 Feb 2020 11:55:38 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id z5sm2486453qta.7.2020.02.18.11.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:55:38 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: cyclictest: truncate shm files to zero when USR2 received
Date:   Tue, 18 Feb 2020 14:55:27 -0500
Message-Id: <20200218195528.8142-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If SIGUSR2 is sent more than once to cyclictest, truncate the shared
memory file for writing the latest snapshot.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2f07426389b3..01ae72f8cdf1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -234,6 +234,7 @@ static void rstat_setup(void);
 static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
+static int rstat_ftruncate(int fd, off_t len);
 static int rstat_fd = -1;
 /* strlen("/cyclictest") + digits in max pid len + '\0' */
 #define SHM_BUF_SIZE 19
@@ -1487,6 +1488,7 @@ static void sighand(int sig)
 			fprintf(stderr, "ERROR: rstat_fd not valid\n");
 			return;
 		}
+		rstat_ftruncate(rstat_fd, 0);
 		quiet = 0;
 		dprintf(rstat_fd, "#---------------------------\n");
 		dprintf(rstat_fd, "# cyclictest current status:\n");
@@ -1835,12 +1837,12 @@ static int rstat_shm_open(void)
 	return fd;
 }
 
-static int rstat_ftruncate(int fd)
+static int rstat_ftruncate(int fd, off_t len)
 {
 	int err;
 
 	errno = 0;
-	err = ftruncate(fd, _SC_PAGE_SIZE);
+	err = ftruncate(fd, len);
 	if (err) {
 		fprintf(stderr, "ftruncate error %s\n", strerror(errno));
 	}
@@ -1885,7 +1887,7 @@ static void rstat_setup(void)
 	if (sfd < 0)
 		goto rstat_err;
 
-	res = rstat_ftruncate(sfd);
+	res = rstat_ftruncate(sfd, _SC_PAGE_SIZE);
 	if (res)
 		goto rstat_err1;
 
-- 
2.20.1

