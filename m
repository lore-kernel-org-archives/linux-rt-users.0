Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A8BC55ABD
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF120797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFl6JGNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gPqNuDA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC38C0613CF
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 10:00:43 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZosRcfKzhWlxFMuhMYj/TNNkHnF33G8aesLeKH7Aqjw=;
        b=MFl6JGNkRVsXjoloK2186KRPe4p5+kBIe3hrm/RgYAa4GFpRxxJwr0PtHogAnk791h89Pr
        SP0SAR9XqFfVLuOkoaFVgel1uH4gGRLv146lQQ2CZtZG9O4d7wO7cNpJCvX3zmK9wRY7d+
        LlLvP3jA4OvYHLCmC0XEevERiUP3vSGfswbaJEsUlK+tA3giyuOnOpbajTi46YM+8IfAH0
        5aUIp3QxZJBx7jekcJIKvCjJPlHEBgR1Y2ZUFkdLvyAk7mcEiLxqtgvFwphuu7FJc1MNCo
        el5mm6IMdOuo0zSuULWMMa8M7Nh13xjJf2eohbtzESgGPJfhJIRvyT17wwK8jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZosRcfKzhWlxFMuhMYj/TNNkHnF33G8aesLeKH7Aqjw=;
        b=gPqNuDA76TB+ZqSLL54lHL7Jq94ZT0sz/C89kEPB6kHawNV06YHoffsyU8K05bOdNxNCW8
        A3W91tWYBkrn9dDA==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] cyclictest: Only report the first incident
Date:   Tue, 10 Nov 2020 19:00:32 +0100
Message-Id: <20201110180036.859080-2-bigeasy@linutronix.de>
In-Reply-To: <20201110180036.859080-1-bigeasy@linutronix.de>
References: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Record only the first inciding inlcuding tid, value and trace event.
If multiple threads exceed the limit then the reported `tid' might not
match the reported value.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 34aa9be583f85..777da26d7bdc3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -718,13 +718,14 @@ static void *timerthread(void *param)
=20
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
-			tracemark("hit latency threshold (%llu > %d)",
-				  (unsigned long long) diff, tracelimit);
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
-			if (break_thread_id =3D=3D 0)
+			if (break_thread_id =3D=3D 0) {
 				break_thread_id =3D stat->tid;
-			break_thread_value =3D diff;
+				tracemark("hit latency threshold (%llu > %d)",
+					  (unsigned long long) diff, tracelimit);
+				break_thread_value =3D diff;
+			}
 			pthread_mutex_unlock(&break_thread_id_lock);
 		}
 		stat->act =3D diff;
--=20
2.29.2

