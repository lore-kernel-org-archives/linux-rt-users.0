Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522AC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhKVUmU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhKVUmP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Nov 2021 15:42:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC4B60FE3;
        Mon, 22 Nov 2021 20:39:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpG5g-001r32-7A;
        Mon, 22 Nov 2021 15:39:04 -0500
Message-ID: <20211122203904.053593391@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 15:38:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 04/10] preempt: Move preempt_enable_no_resched() to the RT block
References: <20211122203847.390551309@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

preempt_enable_no_resched() should point to preempt_enable() on
PREEMPT_RT so nobody is playing any preempt tricks and enables
preemption without checking for the need-resched flag.

This was misplaced in v3.14.0-rt1 und remained unnoticed until now.

Point preempt_enable_no_resched() and preempt_enable() on RT.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/preempt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index af39859f02ee..7b5b2ed55531 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -208,12 +208,12 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 # define preempt_enable_no_resched() sched_preempt_enable_no_resched()
-# define preempt_check_resched_rt() preempt_check_resched()
+# define preempt_check_resched_rt() barrier();
 #else
 # define preempt_enable_no_resched() preempt_enable()
-# define preempt_check_resched_rt() barrier();
+# define preempt_check_resched_rt() preempt_check_resched()
 #endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
-- 
2.33.0
