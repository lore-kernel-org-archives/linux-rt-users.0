Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B796EC0650F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFDB21874
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294088;
	bh=8F6M1GP9no83fV+Wdt/H+/TIMF2roLW3ZPntbR/Okzs=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=NMu03PWyywbAIMFvP2IWiJrZMcNekhePNdoSyhvkdfHr2yYqb99nCUveX1QorEcrm
	 GTNixo+RiD+Pyj2Id+xFTluVdTX1QalU6YHsVzqLxjROQzxclum3kZbN4usctQpwvV
	 B4xouPs7tOzwvFHL8OugT++Asn0e4ql6XMz3gySk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404276AbfHHTxL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404163AbfHHTxL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:11 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DC721882;
        Thu,  8 Aug 2019 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293990;
        bh=8F6M1GP9no83fV+Wdt/H+/TIMF2roLW3ZPntbR/Okzs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=tH4hfQcYzB9kQS5zgwnMvoZ+IlaRrDxtDbJciH1UIyh2gr/+O9c6qRzYXQZCOFuuI
         oK8ZPh4mVO6Qh9NC6WE1ue/shZSxbe3wwmz3Fq7yK8u2oShzzSGXliE+FQCswN+NRy
         cKqeHBYFDQ652d+3ex13oKSTXhYpAj0NcEffyFy8=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 01/19] kthread: Use __RAW_SPIN_LOCK_UNLOCK to initialize kthread_worker lock
Date:   Thu,  8 Aug 2019 14:52:29 -0500
Message-Id: <f4cc7265bb83a3266e8a5c4eac9000f5c3aaa810.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


commit 2a9060beefcf (kthread: convert worker lock to raw spinlock)
forgot to update KTHREAD_WORKER_INIT() to use
__RAW_SPIN_LOCK_UNLOCKED() instead of just __SPIN_LOCK_UNLOCKED() when
it converted the lock to raw.

Change it so that e.g. DEFINE_KTHREAD_WORKER() users don't error out.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/kthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4e0449df82c3..4e663f407bd7 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -105,7 +105,7 @@ struct kthread_delayed_work {
 };
 
 #define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __SPIN_LOCK_UNLOCKED((worker).lock),			\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
 	}
-- 
2.14.1

