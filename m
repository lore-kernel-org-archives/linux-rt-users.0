Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB0C04A6A
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Aug 2023 13:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjHGNe3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjHGNe1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Aug 2023 09:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683FA1FC8
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Aug 2023 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691415151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q/ywKBj14gXMbV9Fy0njDbYw+n6DE7brf08Wr3yxE/Y=;
        b=hDXfUaWh/IDnn0KherdT4V69ouVaYAK2ELe5Mz3FNQoYHTaZB5vOQT664cnpGrv66eocbW
        n+JrUalvgBeV6A7ldFi4DScdILnJz0YmgB0jw1tVOLOrQkB8hSoZFf6R0PNzql9YAxa5Js
        skWYqkdnf7jTcbMVNQdErFs2/3z7QjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-JE6B7Hd-P22FaUaEz92HyA-1; Mon, 07 Aug 2023 09:32:29 -0400
X-MC-Unique: JE6B7Hd-P22FaUaEz92HyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3188DC670
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Aug 2023 13:32:29 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.9.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45111140E950;
        Mon,  7 Aug 2023 13:32:29 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] cyclicdeadline: removed extra pthread_barrier_wait() calls
Date:   Mon,  7 Aug 2023 09:32:28 -0400
Message-Id: <20230807133228.29873-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Before this change, cyclicdeadline was giving abnormally high latencies,
uncharacteristic of an RT system. After removing the extra calls, the
latencies were more in line with what we expected.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 48b82e7efb01..39aeeb5d0785 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -807,8 +807,6 @@ void *run_deadline(void *data)
 		return NULL;
 	}
 
-	pthread_barrier_wait(&barrier);
-
 	attr.sched_policy = SCHED_DEADLINE;
 	attr.sched_runtime = sd->runtime_us * 1000;
 	attr.sched_deadline = sd->deadline_us * 1000;
@@ -816,8 +814,6 @@ void *run_deadline(void *data)
 	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
 	      gettid(), sd->runtime_us, sd->deadline_us);
 
-	pthread_barrier_wait(&barrier);
-
 	ret = sched_setattr(0, &attr, 0);
 	if (ret < 0) {
 		err_msg_n(errno, "[%ld]", tid);
@@ -1281,8 +1277,6 @@ int main(int argc, char **argv)
 
 	atexit(teardown);
 
-	pthread_barrier_wait(&barrier);
-
 	if (shutdown)
 		fatal("failed to setup child threads at step 1\n");
 
@@ -1312,8 +1306,6 @@ int main(int argc, char **argv)
 
 	printf("main thread %d\n", gettid());
 
-	pthread_barrier_wait(&barrier);
-
 	if (shutdown)
 		fatal("failed to setup child threads at step 2");
 
-- 
2.39.3

