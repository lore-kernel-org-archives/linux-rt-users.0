Return-Path: <SRS0=LZsy=AD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4BC433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Jun 2020 21:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8792075A
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Jun 2020 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592861488;
	bh=4sT7eZEB6XM8BOpQM25ecgxPmctC3tU6l4OI5GReTXs=;
	h=Subject:From:To:Date:List-ID:From;
	b=glQFW1eMKpTGAYO69miVjyWN6jvU8zf6wtnHl8FUFQbGrsUmGFLG6Er90Xd+DMTOM
	 8HOHCtHobZ4qwwOLu0aWRFowy4RMu13oVUI+oRc8qYdL9Na0veQ9fUpX5FoJ/b2HzG
	 FlV6CkCL2RQnoiMyT6rfwz6vYOzardCTERsWtJAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgFVVbY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFVVbY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Jun 2020 17:31:24 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA56120716;
        Mon, 22 Jun 2020 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592861483;
        bh=4sT7eZEB6XM8BOpQM25ecgxPmctC3tU6l4OI5GReTXs=;
        h=Subject:From:To:Date:From;
        b=MujtR9AVvL8ZNm3+g3Dr8lO80bOOEW+QYNOUJDQJKEJu3fkGjCRQq+5hz/SVOX57/
         9kLiFQRun2rZb6XSbYlIInrTQHa5/V1Yajyu/ru7UosqrdUmVHYIDOUAwGRqKLe5uF
         +c01TKGR9Be2ZO69TE/pRbBH1nNlGpz4dk9ijpAY=
Message-ID: <6ad783612f118bdec28260a2a3562f5a5fa596cf.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.127-rt55
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 22 Jun 2020 16:31:21 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.127-rt55 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: f297d3d16170bd3af56f7310963c727ce2cab5c7

Or to build 4.19.127-rt55 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.127.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.127-rt55.patch.xz


You can also build from 4.19.127-rt54 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.127-rt54-rt55.patch.xz

Enjoy!

   Tom

Changes from v4.19.127-rt54:
---

Kevin Hao (1):
      mm: slub: Always flush the delayed empty slubs in flush_all()

Sebastian Andrzej Siewior (1):
      fs/dcache: Include swait.h header

Tom Zanussi (2):
      tasklet: Fix UP case for tasklet CHAINED state
      Linux 4.19.127-rt55
---
fs/proc/base.c   | 1 +
 kernel/softirq.c | 6 ++++++
 localversion-rt  | 2 +-
 mm/slub.c        | 3 ---
 4 files changed, 8 insertions(+), 4 deletions(-)
---
diff --git a/fs/proc/base.c b/fs/proc/base.c
index a45d4d640f01..56b1c4f1e8c0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,6 +95,7 @@
 #include <linux/flex_array.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
+#include <linux/swait.h>
 #include "internal.h"
 #include "fd.h"
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 73dae64bfc9c..9bad7a16dc61 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
 	 * is locked before adding it to the list.
 	 */
 	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
 			tasklet_unlock(t);
 			return;
 		}
+#endif
 		t->next = NULL;
 		*head->tail = t;
 		head->tail = &(t->next);
@@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct softirq_action *a,
 again:
 		t->func(t->data);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
+#else
+		while (!tasklet_tryunlock(t)) {
+#endif
 			/*
 			 * If it got disabled meanwhile, bail out:
 			 */
diff --git a/localversion-rt b/localversion-rt
index 3165a8781ff5..51b05e9abe6f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt54
+-rt55
diff --git a/mm/slub.c b/mm/slub.c
index d243c6ef7fc9..a9473bbb1338 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2341,9 +2341,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);

