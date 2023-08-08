Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB2C001B0
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Aug 2023 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHHWj6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHHWj5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Aug 2023 18:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFFFE
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691534349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rJ1rlDZsOG0ej0yFtuxHflX+6lCMu2cEi8Fsz3cNI20=;
        b=bK0loS03KHfTCD8HfymLUY/Okpi4f5I9UL/pOjfP7jitTchqQ/eUrH3ixjOW5eQNdfDxh9
        pP7IXeWlaqG4V7XVnIomXEz/FedyI1OcPbmNf6AmHXXcVsrqb5XxpC/4hFmrGJCuuTb48b
        Uy7nQ/e9n0mT48q6nj2CgMWYKWQLfCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-nKQo4G_SNcKSn63l-wkArQ-1; Tue, 08 Aug 2023 18:39:07 -0400
X-MC-Unique: nKQo4G_SNcKSn63l-wkArQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA4E385C70F
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Aug 2023 22:39:07 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.194.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032BD492C13;
        Tue,  8 Aug 2023 22:39:06 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com, ezulian@redhat.com
Subject: [PATCH] rt-tests: cyclictest: Suppress compiler warnings for unused variables
Date:   Wed,  9 Aug 2023 00:39:04 +0200
Message-Id: <20230808223904.290605-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using an attribute to inform the compiler that variables are expect to be unused so it will not issue a warning.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 src/cyclictest/cyclictest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 7b0f80f..86cec0e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1610,11 +1610,13 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 }
 
 
+#define UNUSED __attribute__((__unused__))
+
 /*
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
  */
-static void *fifothread(void *param)
+static void *fifothread(UNUSED void *param)
 {
 	int ret;
 	int fd;
@@ -1795,7 +1797,7 @@ rstat_err:
 	return;
 }
 
-static void write_stats(FILE *f, void *data)
+static void write_stats(FILE *f, UNUSED void *data)
 {
 	struct thread_param **par = parameters;
 	unsigned int i, j, comma;
-- 
2.39.3

