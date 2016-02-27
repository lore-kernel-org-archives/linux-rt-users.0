From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] locking/lglocks: use preempt_enable/disable_nort() in
 lg_double_lock/lg_double_unlock
Date: Sat, 27 Feb 2016 08:34:43 +0100
Message-ID: <1456558483.3759.18.camel@gmail.com>
References: <1456556755.3759.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32958 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcB0Her (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 02:34:47 -0500
Received: by mail-wm0-f42.google.com with SMTP id g62so97453534wme.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2016 23:34:47 -0800 (PST)
In-Reply-To: <1456556755.3759.4.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Let's not do that when snagging an rtmutex.

Signed-off-by: Mike Galbraith <umgwanakilbuti@gmail.com>
---
 kernel/locking/lglock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/locking/lglock.c
+++ b/kernel/locking/lglock.c
@@ -86,7 +86,7 @@ void lg_double_lock(struct lglock *lg, i
 	if (cpu2 < cpu1)
 		swap(cpu1, cpu2);
 
-	preempt_disable();
+	preempt_disable_nort();
 	lock_acquire_shared(&lg->lock_dep_map, 0, 0, NULL, _RET_IP_);
 	lg_do_lock(per_cpu_ptr(lg->lock, cpu1));
 	lg_do_lock(per_cpu_ptr(lg->lock, cpu2));
@@ -97,7 +97,7 @@ void lg_double_unlock(struct lglock *lg,
 	lock_release(&lg->lock_dep_map, 1, _RET_IP_);
 	lg_do_unlock(per_cpu_ptr(lg->lock, cpu1));
 	lg_do_unlock(per_cpu_ptr(lg->lock, cpu2));
-	preempt_enable();
+	preempt_enable_nort();
 }
 
 void lg_global_lock(struct lglock *lg)
