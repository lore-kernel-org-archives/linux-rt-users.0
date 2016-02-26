From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/12] rtmutex: Handle non enqueued waiters gracefully
Date: Fri, 26 Feb 2016 16:32:39 -0500
Message-ID: <20160226213340.609345335@goodmis.org>
References: <20160226213235.253312067@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48210 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158AbcBZVdp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 16:33:45 -0500
Content-Disposition: inline; filename=0004-rtmutex-Handle-non-enqueued-waiters-gracefully.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.27-rt26-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Yimin debugged that in case of a PI wakeup in progress when
rt_mutex_start_proxy_lock() calls task_blocks_on_rt_mutex() the latter
returns -EAGAIN and in consequence the remove_waiter() call runs into
a BUG_ON() because there is nothing to remove.

Guard it with rt_mutex_has_waiters(). This is a quick fix which is
easy to backport. The proper fix is to have a central check in
remove_waiter() so we can call it unconditionally.

Reported-and-debugged-by: Yimin Deng <yimin11.deng@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 64973df0c686..c1b7d5b1be7e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2144,7 +2144,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
+	if (ret && rt_mutex_has_waiters(lock))
 		remove_waiter(lock, waiter);
 
 	raw_spin_unlock(&lock->wait_lock);
-- 
2.7.0


