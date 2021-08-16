Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ADAC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1078360F36
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhHPPb6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhHPPb5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Aug 2021 11:31:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0E560EFF;
        Mon, 16 Aug 2021 15:31:25 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:31:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.10.56-rt49
Message-ID: <20210816113123.36817ecd@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.56-rt49 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: f01b4758ad61a01d23ccaa96a65ce774cdcc09ae


Or to build 5.10.56-rt49 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.56.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.56-rt49.patch.xz



You can also build from 5.10.56-rt48 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.56-rt48-rt49.patch.xz



Enjoy,

-- Steve


Changes from v5.10.56-rt48:

---

Chao Qin (1):
      printk: Enhance the condition check of msleep in pr_flush()

Steven Rostedt (VMware) (1):
      Linux 5.10.56-rt49

----
 kernel/printk/printk.c | 4 +++-
 localversion-rt        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f56fd2e34cc7..53d90278494b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3545,7 +3545,9 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 	u64 diff;
 	u64 seq;
 
-	may_sleep = (preemptible() && !in_softirq());
+	may_sleep = (preemptible() &&
+		     !in_softirq() &&
+		     system_state >= SYSTEM_RUNNING);
 
 	seq = prb_next_seq(prb);
 
diff --git a/localversion-rt b/localversion-rt
index 24707986c321..4b7dca68a5b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt48
+-rt49
