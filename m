Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A12C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350307AbhKXSGo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350237AbhKXSGh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7497961039;
        Wed, 24 Nov 2021 18:03:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcA-0027rZ-JX;
        Wed, 24 Nov 2021 13:03:26 -0500
Message-ID: <20211124180326.453043583@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RT 02/13] sched: Fix get_push_task() vs migrate_disable()
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

push_rt_task() attempts to move the currently running task away if the
next runnable task has migration disabled and therefore is pinned on the
current CPU.

The current task is retrieved via get_push_task() which only checks for
nr_cpus_allowed == 1, but does not check whether the task has migration
disabled and therefore cannot be moved either. The consequence is a
pointless invocation of the migration thread which correctly observes
that the task cannot be moved.

Return NULL if the task has migration disabled and cannot be moved to
another CPU.

Cc: stable-rt@vger.kernel.org
Fixes: a7c81556ec4d3 ("sched: Fix migrate_disable() vs rt/dl balancing")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210826133738.yiotqbtdaxzjsnfj@linutronix.de
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/sched.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 826ea17e144d..c2c9c386456d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1949,6 +1949,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return NULL;
 
+	if (p->migration_disabled)
+		return NULL;
+
 	rq->push_busy = true;
 	return get_task_struct(p);
 }
-- 
2.33.0
