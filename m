Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B7C4741F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2705020797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Du+mQLMN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Br3jbIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKJSAp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D328C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 10:00:44 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/fQb+ykwhef1KC0z66+U6JeeeH8cCDSn86a6GXlJ4o=;
        b=Du+mQLMNmKzj+YsnKs6R27csEH9PTXFTt+1xBmXl+YrE6T4I262QgsgrqG/c0MGLFPIu9K
        FOlcYIMdn6bv1dYHuRRL+4J1TCW/6NQBRbbyJzdkWsBVfkCK3WwWqCmWY0Werq8WY0kGhT
        gmu16e3/UVqedDiiTG8Qw/O+MDfizk3wp5Ktmdpx6OjJCZbWGy7cc2qtZAuxBlTvpudRZ4
        hgc1z32fsfsIkQg9vQGXPWHFZcauavR4EqOwJg4/6pjUwrfL0HS03ZBdxrF3ceTgkQY0Y3
        JNnbc0La4fZt4Qd39IIiYqC6v0Y6GFJeTff3ibr+y9nsNdMkH8oEZCfIb/p2nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/fQb+ykwhef1KC0z66+U6JeeeH8cCDSn86a6GXlJ4o=;
        b=4Br3jbIA/4RCYoLS3LMGX3k0OM5UceUdjn5c8OEuc9Gc1Z6JTsWslKcmTHb18JjHqDFCfd
        wl2XZUO/1FVfyRAQ==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] signaltest: Fix break value argument
Date:   Tue, 10 Nov 2020 19:00:35 +0100
Message-Id: <20201110180036.859080-5-bigeasy@linutronix.de>
In-Reply-To: <20201110180036.859080-1-bigeasy@linutronix.de>
References: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The break value '-b' is not working properly:
- Every thread may hit the break value. This is expected for thread
  number > 0 because thread number 0 sleeps every 16 iterations to give
  the system time to breath. This delay may wrongly trigger as the break
  value.

- If a thread hits the break value then it returns signaling "shutdown".
  The main thread will then SIGTERM to each of the remaining threads.
  This is a nop because this signal is blocked.
  Send SIGUSR1 instead which is waited for.

While doing all of this, report the actual `max' value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/signaltest/signaltest.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 84eb8827faa5e..dacaa63673c48 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -58,6 +58,7 @@ struct thread_stat {
 	pthread_t tothread;
 	int threadstarted;
 	int tid;
+	int interrupted;
 };
=20
 static int shutdown;
@@ -123,13 +124,16 @@ void *signalthread(void *param)
=20
 		diff =3D calcdiff(after, before);
 		before =3D now;
+
 		if (diff < stat->min)
 			stat->min =3D diff;
 		if (diff > stat->max)
 			stat->max =3D diff;
 		stat->avg +=3D (double) diff;
=20
-		if (!stopped && tracelimit && (diff > tracelimit)) {
+		if (!stopped && tracelimit && !par->id  && (diff > tracelimit)) {
+			stat->act =3D diff;
+			stat->interrupted =3D 1;
 			stopped++;
 			shutdown++;
 		}
@@ -376,11 +380,12 @@ int main(int argc, char **argv)
 		quiet =3D 2;
 	for (i =3D 0; i < num_threads; i++) {
 		if (stat[i].threadstarted > 0)
-			pthread_kill(stat[i].thread, SIGTERM);
+			pthread_kill(stat[i].thread, SIGUSR1);
+		if (stat[i].interrupted)
+			printf("Thread %d exceeded trace limit.\n", i);
 		if (stat[i].threadstarted) {
 			pthread_join(stat[i].thread, NULL);
-			if (quiet && (i =3D=3D 0))
-				print_stat(&par[i], i, 0);
+			print_stat(&par[i], i, 0);
 		}
 		if (stat[i].values)
 			free(stat[i].values);
--=20
2.29.2

