Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACEFC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AE16109E
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbhIBU1e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346288AbhIBU1d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Sep 2021 16:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396AB60FC0;
        Thu,  2 Sep 2021 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630614395;
        bh=X4Mka5AcwZPbW6lUjbBwstma++xkUw/YNn+ixtg3Mho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=rI4GcK8UBY+J/MG4ZRXG2CQqhwkvxxqlcxqBAxuCT1PhMcjIonW1FUQu3uurQnTcV
         b3M599haVZ6Gqb+cKiUmDVKtiNplYapRKEZ6Px1Kg4wswIkGr6HKg0O/E4yMirCmQk
         ggbD+Eensdk3OHpDLvT1qU6Srt1veZ0qG4esPScTdLJksyDbmL2lIrzj3cD9QH7cUM
         010rLmJJyIgJCBJCITvS1pNoJfa9GFzWEkjGcwjTUkiaPlgpJ0ySE+/y1q9uqlfXRr
         zbWyVgrZlNxGu8vPFTWljyBfU6pQZHpka5I4xel/b5ez5VCAgJEFDffQSR5LvCBXZy
         AUFhC3VGh0vcw==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RT 1/2] locking/rwsem-rt: Remove might_sleep() in __up_read()
Date:   Thu,  2 Sep 2021 15:26:30 -0500
Message-Id: <215c9e668bc1b637529e877fedfc7dc6c54c4ca0.1630614380.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1630614380.git.zanussi@kernel.org>
References: <cover.1630614380.git.zanussi@kernel.org>
In-Reply-To: <cover.1630614380.git.zanussi@kernel.org>
References: <cover.1630614380.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

v5.4.143-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit b2ed0a4302faf2bb09e97529dd274233c082689b ]

There's no chance of sleeping here, the reader is giving up the
lock and possibly waking up the writer who is waiting on it.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/locking/rwsem-rt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 19ea20be3fd7..966946454ced 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -200,7 +200,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
-- 
2.17.1

