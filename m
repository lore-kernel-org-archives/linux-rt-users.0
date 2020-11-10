Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98BC5517A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991F021D40
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgKJPka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgKJPk1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 10:40:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B067D20795;
        Tue, 10 Nov 2020 15:40:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kcVkv-008eDG-4P; Tue, 10 Nov 2020 10:40:25 -0500
Message-ID: <20201110154024.958923729@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 10 Nov 2020 10:38:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
Subject: [PATCH RT 1/5] net: Properly annotate the try-lock for the seqlock
References: <20201110153853.463368981@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.74-rt42-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In patch
   ("net/Qdisc: use a seqlock instead seqcount")

the seqcount has been replaced with a seqlock to allow to reader to
boost the preempted writer.
The try_write_seqlock() acquired the lock with a try-lock but the
seqcount annotation was "lock".

Opencode write_seqcount_t_begin() and use the try-lock annotation for
lockdep.

Reported-by: Mike Galbraith <efault@gmx.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seqlock.h   |  9 ---------
 include/net/sch_generic.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e5207897c33e..f390293974ea 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -489,15 +489,6 @@ static inline void write_seqlock(seqlock_t *sl)
 	__raw_write_seqcount_begin(&sl->seqcount);
 }
 
-static inline int try_write_seqlock(seqlock_t *sl)
-{
-	if (spin_trylock(&sl->lock)) {
-		__raw_write_seqcount_begin(&sl->seqcount);
-		return 1;
-	}
-	return 0;
-}
-
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	__raw_write_seqcount_end(&sl->seqcount);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index e6afb4b9cede..112d2dca8b08 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (try_write_seqlock(&qdisc->running))
+	if (spin_trylock(&qdisc->running.lock)) {
+		seqcount_t *s = &qdisc->running.seqcount;
+		/*
+		 * Variant of write_seqcount_t_begin() telling lockdep that a
+		 * trylock was attempted.
+		 */
+		__raw_write_seqcount_begin(s);
+		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
 		return true;
+	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
-- 
2.28.0


