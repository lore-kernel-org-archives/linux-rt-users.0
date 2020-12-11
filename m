Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F83BC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB47823C83
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392823AbgLKVmq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Dec 2020 16:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391246AbgLKVmM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Dec 2020 16:42:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B5E233A2;
        Fri, 11 Dec 2020 21:41:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1knqAM-000JZS-BY; Fri, 11 Dec 2020 16:41:30 -0500
Message-ID: <20201211214130.210869665@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Dec 2020 16:41:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 1/4] Revert "net: Properly annotate the try-lock for the seqlock"
References: <20201211214103.954245915@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.82-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

This reverts commit 3971227b5af04e6c34ef7b47b2ebe941727563a0.

Link: https://lore.kernel.org/r/20201116171958.2opbksmgbznrjxu2@linutronix.de

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seqlock.h   |  9 +++++++++
 include/net/sch_generic.h | 10 +---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f390293974ea..e5207897c33e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -489,6 +489,15 @@ static inline void write_seqlock(seqlock_t *sl)
 	__raw_write_seqcount_begin(&sl->seqcount);
 }
 
+static inline int try_write_seqlock(seqlock_t *sl)
+{
+	if (spin_trylock(&sl->lock)) {
+		__raw_write_seqcount_begin(&sl->seqcount);
+		return 1;
+	}
+	return 0;
+}
+
 static inline void write_sequnlock(seqlock_t *sl)
 {
 	__raw_write_seqcount_end(&sl->seqcount);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 112d2dca8b08..e6afb4b9cede 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,16 +168,8 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (spin_trylock(&qdisc->running.lock)) {
-		seqcount_t *s = &qdisc->running.seqcount;
-		/*
-		 * Variant of write_seqcount_t_begin() telling lockdep that a
-		 * trylock was attempted.
-		 */
-		__raw_write_seqcount_begin(s);
-		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
+	if (try_write_seqlock(&qdisc->running))
 		return true;
-	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
-- 
2.29.2


