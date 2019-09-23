Return-Path: <SRS0=aYAi=XS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE05C4CEC4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0526205F4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbfIWQBo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:01:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfIWQBo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Sep 2019 12:01:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCQmT-0000UU-6u; Mon, 23 Sep 2019 18:01:41 +0200
Date:   Mon, 23 Sep 2019 18:01:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] posix-timers: Unlock expiry lock in the early return
Message-ID: <20190923160141.oqsv7vwhw5pof6f2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Patch ("posix-timers: Add expiry lock") acquired a lock in
run_posix_cpu_timers() but didn't drop the lock in the early return.

Unlock the lock in the early return path.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-cpu-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 20cd92a8b9785..a045813c37021 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1167,8 +1167,10 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
 	spin_lock(expiry_lock);
 
-	if (!lock_task_sighand(tsk, &flags))
+	if (!lock_task_sighand(tsk, &flags)) {
+		spin_unlock(expiry_lock);
 		return;
+	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
-- 
2.23.0
