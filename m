Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23742C001B0
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Aug 2023 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjHNMDq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjHNMDi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Aug 2023 08:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E532130
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Aug 2023 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692014553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rvSA7VjZz5S6/2Lpy5nXHvHROj0r5Cwz/f8gPlgNXuE=;
        b=JlELh4jqqlAUtBoYkGJ4mq0rJGKEgqhL08oSsRggYSEmA/PZ3UgP9V8w/Hi6DaabCgx/Ja
        nZObHGiKIxvGOVBSPEiGWAPRBjWLpBK4f0MRDnDt2MAFY3wSGNRM0inG5l0suhxiu43Qva
        N/vP8fSWzTF5k63O2DSwhAfjSjRv8jU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-R9A93QfZMWuKREy_yCMFQg-1; Mon, 14 Aug 2023 08:02:32 -0400
X-MC-Unique: R9A93QfZMWuKREy_yCMFQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 994A884B07F
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Aug 2023 12:02:22 +0000 (UTC)
Received: from ezulian.remote.csb (unknown [10.39.193.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D4441638A;
        Mon, 14 Aug 2023 12:02:21 +0000 (UTC)
From:   Eder Zulian <ezulian@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, williams@redhat.com
Subject: [PATCH v2] rt-tests: cyclictest: Suppress compiler warnings for unused variables
Date:   Mon, 14 Aug 2023 14:01:57 +0200
Message-Id: <20230814120157.34783-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using an attribute to inform the compiler that variables are expect to
be unused so it will not issue a warning.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
V1 -> V2: Cleaned up style and addressed review comments

 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4a7108e..a28057c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1614,7 +1614,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
  */
-static void *fifothread(void *param)
+static void *fifothread(__attribute__((__unused__)) void *param)
 {
 	int ret;
 	int fd;
@@ -1795,7 +1795,7 @@ rstat_err:
 	return;
 }
 
-static void write_stats(FILE *f, void *data)
+static void write_stats(FILE *f, __attribute__((__unused__)) void *data)
 {
 	struct thread_param **par = parameters;
 	unsigned int i, j, comma;
-- 
2.39.3

