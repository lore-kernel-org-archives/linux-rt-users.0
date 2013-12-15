From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: bad return value in __mutex_lock_check_stamp
Date: Sun, 15 Dec 2013 15:40:47 +0100
Message-ID: <20131215144047.GB32756@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54458 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3LOOks (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 09:40:48 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Bad return value in _mutex_lock_check_stamp - this problem only would show 
up with 3.12.1 rt4 applied but CONFIG_PREEMPT_RT_FULL not enabled 
currently it would be returning what ever vprintk_emit ended up with 
(atleast on x86), which probably is not the intended behavior. Added a
return 0; as in the case with CONFIG_PREEMPT_RT_FULL enabled.

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/rtmutex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 4e9691f..148eef7 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1007,6 +1007,7 @@ static inline int __sched
 __mutex_lock_check_stamp(struct rt_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	BUG();
+	return 0;
 }
 
 #endif
-- 
1.7.2.5

