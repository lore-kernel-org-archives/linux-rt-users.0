Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE5C001B0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 14:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjHIOuS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjHIOuS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 10:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB0EE
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691592568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h29f2/58Hm3qnvB/61uVcFYu8BGE5xj8lgEydPkrykQ=;
        b=O8TYmTMPogK8kkPYmrU1qe06JlkP277Ne8wTQSJfwn0Oxixh5APvlL0K1x/VGUm3kTWN3Q
        px2Synb4XcFbpoUs0IsoGSz+2lkgddm9uae0b0hzy4XBAoO9IviOqFFMwjWw0/BFLo5KGy
        QACQ5uEfgIbMrMzYjN5i8uWx1cGUd8I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-USO4JDlqPBaiQsXjY4_cCA-1; Wed, 09 Aug 2023 10:49:26 -0400
X-MC-Unique: USO4JDlqPBaiQsXjY4_cCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 066053C11A16
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 14:49:26 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.32.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C25A11121314;
        Wed,  9 Aug 2023 14:49:25 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        williams@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2] cyclicdeadline: removed extra pthread_barrier_wait() calls
Date:   Wed,  9 Aug 2023 10:48:56 -0400
Message-Id: <20230809144855.143778-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Before this change, cyclicdeadline was giving abnormally high latencies
and occasionally locking up on start, uncharacteristic of an RT system.
After removing the extra calls, the latencies were more in line with
what we expected and there were no lock-ups on run.

Test runs, courtesy of Clark Williams (aarch64 system running RT kernel):

Cmd Line: $ sudo ./cyclicdeadline -t8 -a8-15 -D 5m

The first three test runs were from the current main branch of realtime-tests:

First run

T: 0 ( 2074) I:1000 C: 300007 Min:      1 Act:   11 Avg:   10 Max:      34
T: 1 ( 2075) I:1500 C: 200005 Min:      1 Act:   12 Avg:   10 Max:      30
T: 2 ( 2076) I:2000 C: 150004 Min:      1 Act:   14 Avg:   11 Max:      36
T: 3 ( 2077) I:2500 C: 120003 Min:      1 Act:   11 Avg:   10 Max:      42
T: 4 ( 2078) I:3000 C: 100003 Min:      1 Act:   13 Avg:    6 Max:      35
T: 5 ( 2079) I:3500 C:  85717 Min:      1 Act:    3 Avg:    8 Max:      28
T: 6 ( 2080) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      43
T: 7 ( 2081) I:4500 C:  66669 Min:      1 Act:   13 Avg:   10 Max:      31

Second run

T: 0 ( 2074) I:1000 C: 300007 Min:      1 Act:   11 Avg:   10 Max:      34
T: 1 ( 2075) I:1500 C: 200005 Min:      1 Act:   12 Avg:   10 Max:      30
T: 2 ( 2076) I:2000 C: 150004 Min:      1 Act:   14 Avg:   11 Max:      36
T: 3 ( 2077) I:2500 C: 120003 Min:      1 Act:   11 Avg:   10 Max:      42
T: 4 ( 2078) I:3000 C: 100003 Min:      1 Act:   13 Avg:    6 Max:      35
T: 5 ( 2079) I:3500 C:  85717 Min:      1 Act:    3 Avg:    8 Max:      28
T: 6 ( 2080) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      43
T: 7 ( 2081) I:4500 C:  66669 Min:      1 Act:   13 Avg:   10 Max:      31

Third Run

T: 0 ( 2199) I:1000 C: 300007 Min:      1 Act:   12 Avg:   11 Max:      35
T: 1 ( 2200) I:1500 C: 200005 Min:      1 Act:   13 Avg:   12 Max:      36
T: 2 ( 2201) I:2000 C: 150004 Min:      1 Act:   14 Avg:   12 Max:      42
T: 3 ( 2202) I:2500 C: 120003 Min:      2 Act:   16 Avg:   13 Max:      36
T: 4 ( 2203) I:3000 C: 100003 Min:      1 Act:   10 Avg:    7 Max:      31
T: 5 ( 2204) I:3500 C:  85717 Min:      1 Act:   11 Avg:   10 Max:      35
T: 6 ( 2205) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      26
T: 7 ( 2206) I:4500 C:  66669 Min:      1 Act:   17 Avg:   12 Max:      35

The second three runs were on the same system but with code that has the pthread_barrier_wait() calls fixed

First run

T: 0 ( 4131) I:1000 C: 300004 Min:      1 Act:    3 Avg:    8 Max:      38
T: 1 ( 4132) I:1500 C: 200003 Min:      1 Act:   13 Avg:    6 Max:      32
T: 2 ( 4133) I:2000 C: 150002 Min:      1 Act:   12 Avg:    8 Max:      31
T: 3 ( 4134) I:2500 C: 120002 Min:      1 Act:   11 Avg:   10 Max:      32
T: 4 ( 4135) I:3000 C: 100002 Min:      1 Act:   11 Avg:   10 Max:      30
T: 5 ( 4136) I:3500 C:  85716 Min:      1 Act:   12 Avg:   10 Max:      35
T: 6 ( 4137) I:4000 C:  75001 Min:      1 Act:   11 Avg:   10 Max:      33
T: 7 ( 4138) I:4500 C:  66668 Min:      1 Act:   10 Avg:    9 Max:      28

Second run
T: 0 ( 4353) I:1000 C: 300006 Min:      1 Act:   13 Avg:   10 Max:      34
T: 1 ( 4354) I:1500 C: 200004 Min:      1 Act:   13 Avg:   11 Max:      28
T: 2 ( 4355) I:2000 C: 150003 Min:      1 Act:   13 Avg:   11 Max:      32
T: 3 ( 4356) I:2500 C: 120003 Min:      1 Act:   13 Avg:   11 Max:      38
T: 4 ( 4357) I:3000 C: 100002 Min:      1 Act:   12 Avg:   11 Max:      29
T: 5 ( 4358) I:3500 C:  85716 Min:      1 Act:   11 Avg:   11 Max:      31
T: 6 ( 4359) I:4000 C:  75002 Min:      1 Act:   11 Avg:   10 Max:      32
T: 7 ( 4360) I:4500 C:  66668 Min:      1 Act:    3 Avg:    2 Max:      19

Third run
T: 0 ( 4426) I:1000 C: 300006 Min:      1 Act:   13 Avg:    8 Max:      43
T: 1 ( 4427) I:1500 C: 200004 Min:      1 Act:    2 Avg:    6 Max:      25
T: 2 ( 4428) I:2000 C: 150003 Min:      1 Act:   11 Avg:    9 Max:      30
T: 3 ( 4429) I:2500 C: 120003 Min:      2 Act:   12 Avg:   11 Max:      31
T: 4 ( 4430) I:3000 C: 100002 Min:      1 Act:   12 Avg:   11 Max:      33
T: 5 ( 4431) I:3500 C:  85716 Min:      1 Act:   12 Avg:   10 Max:      31
T: 6 ( 4432) I:4000 C:  75002 Min:      2 Act:   13 Avg:   12 Max:      36
T: 7 ( 4433) I:4500 C:  66668 Min:      1 Act:   12 Avg:   10 Max:      30

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

