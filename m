Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D94C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439E72184D
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMBqC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgHMBp5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164BA2177B;
        Thu, 13 Aug 2020 01:45:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JY-00751e-3P; Wed, 12 Aug 2020 21:45:56 -0400
Message-ID: <20200813014555.980104906@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 5/6] rwsem: Provide down_read_non_owner() and up_read_non_owner() for -RT
References: <20200813014534.833107526@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.54-rt33-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The rwsem implementation on -RT allows multiple reader and there is no
owner tracking anymore.
We can provide down_read_non_owner() and up_read_non_owner() by skipping
the owner check bits which are only available in the !RT implementation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rwsem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 0d11ba11a32a..0325c721f9b3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1616,15 +1616,15 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 }
 EXPORT_SYMBOL(_down_write_nest_lock);
 
-#ifndef CONFIG_PREEMPT_RT
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
 	__down_read(sem);
+#ifndef CONFIG_PREEMPT_RT
 	__rwsem_set_reader_owned(sem, NULL);
+#endif
 }
 EXPORT_SYMBOL(down_read_non_owner);
-#endif
 
 void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
@@ -1649,13 +1649,13 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_write_killable_nested);
 
-#ifndef CONFIG_PREEMPT_RT
 void up_read_non_owner(struct rw_semaphore *sem)
 {
+#ifndef CONFIG_PREEMPT_RT
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+#endif
 	__up_read(sem);
 }
 EXPORT_SYMBOL(up_read_non_owner);
-#endif
 
 #endif
-- 
2.28.0


