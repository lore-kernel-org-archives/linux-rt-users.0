From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock functions
Date: Tue, 20 Jan 2015 18:02:29 -0200
Message-ID: <20150120200229.GA17473@gbitten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54308 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbATUCh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Jan 2015 15:02:37 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so29949934qaq.12
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Jan 2015 12:02:36 -0800 (PST)
Received: from gbitten ([201.53.181.238])
        by mx.google.com with ESMTPSA id y95sm16203431qgy.14.2015.01.20.12.02.34
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 12:02:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The functions ww_mutex_lock_interruptible and ww_mutex_lock should return -EDEADLK when faced with
a deadlock. To do so, the paramenter detect_deadlock in rt_mutex_slowlock must be TRUE.
This patch corrects potential deadlocks when running PREEMPT_RT with nouveau driver.

Kernel version: 3.14.25-rt22

Signed-off-by: Gustavo Bittencourt <gbitten@gmail.com>
---
 kernel/locking/rtmutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660..3f6ef91 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1965,7 +1965,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
 	might_sleep();
 
 	mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 1, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
@@ -1984,7 +1984,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map,
 			_RET_IP_);
-	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
+	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 1, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
 	else if (!ret && ww_ctx->acquired > 1)
-- 
1.9.1

