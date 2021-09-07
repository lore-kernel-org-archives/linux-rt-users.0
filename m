Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC7C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C255B6113B
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbhIGPQj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345061AbhIGPQi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CB8C6112E;
        Tue,  7 Sep 2021 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027732;
        bh=KvtCf6stqLiEbq7sySSQ86RmRGkW8yQj4rPuQwmzu+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dL/ThkFhUhJ3Zsr4RbgRl+utBczBn/aXJK2OUdKeyehk05tb5tNl36zcWz2g41c7Q
         eX/OdvsACvZKzZkDzLR+axdyiIJZg3ekm5gC1O04d1sZWlnNalNxCHnDQo4pfg6pJF
         u42eqPlxTvW6QNMyJ1vaeLmz106BTjy0QOUdB/cUmM/Da4dpoN93PO/XEio4kCZC3B
         Z4oYD6N3K9dDzDAXYKFOACpWxb2sk1WFt4C+qUh4S6LVQTtMsPIsAOC/hPRQpumkS4
         88Su9ZXGaXysp/tH0uLKad1IFaqGdp2uKOLcEkaYeIUJ5bGtngsGo6aHZgVmrFMd6r
         zuIDRu978cuvQ==
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
Subject: [PATCH RT 1/3] locking/rwsem-rt: Remove might_sleep() in __up_read()
Date:   Tue,  7 Sep 2021 10:15:27 -0500
Message-Id: <863d8c29a4b1b1500f7a90557af8b7fa442afcb7.1631027711.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Andrew Halaney <ahalaney@redhat.com>

v5.4.143-rt64-rc2 stable review patch.
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

