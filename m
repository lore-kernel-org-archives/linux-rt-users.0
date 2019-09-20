Return-Path: <SRS0=GKw7=XP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517AAC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254A9218AE
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Sep 2019 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfITV4X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfITV4X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6004B208C0;
        Fri, 20 Sep 2019 21:56:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt3-0005HN-IT; Fri, 20 Sep 2019 17:56:21 -0400
Message-Id: <20190920215621.437066593@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [RFC][PATCH RT 1/7] revert-aio
References: <20190920215311.165260719@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

revert: fs/aio: simple simple work

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/aio.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 16dcf8521c2c..911e23087dfb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,7 +42,6 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
-#include <linux/swork.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -122,7 +121,6 @@ struct kioctx {
 	long			nr_pages;
 
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
-	struct swork_event	free_swork;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -267,7 +265,6 @@ static int __init aio_setup(void)
 		.mount		= aio_mount,
 		.kill_sb	= kill_anon_super,
 	};
-	BUG_ON(swork_get());
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -609,9 +606,9 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
  * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
  * now it's safe to cancel any that need to be.
  */
-static void free_ioctx_users_work(struct swork_event *sev)
+static void free_ioctx_users(struct percpu_ref *ref)
 {
-	struct kioctx *ctx = container_of(sev, struct kioctx, free_swork);
+	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
 
 	spin_lock_irq(&ctx->ctx_lock);
@@ -629,14 +626,6 @@ static void free_ioctx_users_work(struct swork_event *sev)
 	percpu_ref_put(&ctx->reqs);
 }
 
-static void free_ioctx_users(struct percpu_ref *ref)
-{
-	struct kioctx *ctx = container_of(ref, struct kioctx, users);
-
-	INIT_SWORK(&ctx->free_swork, free_ioctx_users_work);
-	swork_queue(&ctx->free_swork);
-}
-
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
 	unsigned i, new_nr;
-- 
2.20.1


