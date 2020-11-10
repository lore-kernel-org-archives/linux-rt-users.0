Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCCC55ABD
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A63C20797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NdA7HbvX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSOmQzQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgKJSAq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4746CC0613CF
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 10:00:44 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvAVc5LLE4/mm7Hhyy1l6FbZMXRceTx8Yg0CKnhlGEM=;
        b=NdA7HbvXCwhdYC+NFZ9qYBOowSiCTyfz3UWzvpI3m6Fdbq+u74XewfFi4QQqlh/zkBy1Bc
        6bxdpz8p+sB2lZm8Vwl8/+1nb2Pi7YbIUDSyUbbw/mrzoau21tE4OnAHlDbWliBu8PzgZJ
        V9ReGqu8FDaZWZeuCb7OJYUSNp3Z/p7Vs1Aan4INKZCMXvJC6agirVBu0w5SUTrXmLaVkk
        KKLO5nxp93DbiGSxaPPH2Wsp5gBkYZ2iT6h7kgebti1EsdkR0sdGuMGhq2fa/5LUmaIgtd
        0xyfH8PVgg4Th9d2Fzq5Johoq8ThlQ9IjMawBNsS7t2yjaNLPUkx1Jud4Va+9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvAVc5LLE4/mm7Hhyy1l6FbZMXRceTx8Yg0CKnhlGEM=;
        b=pSOmQzQbfnsdBYTSZLjW2KHjN4COyUzywp9dJmtR6uBC6LX1q+Gd/aUGxNplrqeKbGmg0E
        9u6YtHKVgU9xf4AA==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] signaltest: Don't expect trace interface at /proc
Date:   Tue, 10 Nov 2020 19:00:34 +0100
Message-Id: <20201110180036.859080-4-bigeasy@linutronix.de>
In-Reply-To: <20201110180036.859080-1-bigeasy@linutronix.de>
References: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This was never merged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/signaltest/signaltest.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index aceb714d3e9d3..84eb8827faa5e 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -79,19 +79,6 @@ void *signalthread(void *param)
 	int stopped =3D 0;
 	int first =3D 1;
=20
-	if (tracelimit) {
-		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
-		system("echo 1 > /proc/sys/kernel/trace_enabled");
-		system("echo 1 > /proc/sys/kernel/trace_freerunning");
-		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
-		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
-		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
-		system("echo 0 > /proc/sys/kernel/trace_verbose");
-		system("echo 0 > /proc/sys/kernel/preempt_thresh");
-		system("echo 0 > /proc/sys/kernel/wakeup_timing");
-		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
-	}
-
 	stat->tid =3D gettid();
=20
 	sigemptyset(&sigset);
--=20
2.29.2

