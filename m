From: Joakim Hernberg <jbh@alchemy.lu>
Subject: kernel/locking/rt.c: add missing EXPORT_SYMBOL for
 rt_down_write_nested_lock() needed by f2fs
Date: Sun, 4 May 2014 19:14:42 +0200
Message-ID: <20140504191442.370fcf4c@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:28781 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaEDRb5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 May 2014 13:31:57 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I found this trying to build 3.14.2-rt3.

Signed-off-by: Joakim Hernberg <jhernberg@alchemy.lu>
---
 kernel/locking/rt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/rt.c b/kernel/locking/rt.c
index 055a3df..3a57b3a 100644
--- a/kernel/locking/rt.c
+++ b/kernel/locking/rt.c
@@ -366,6 +366,7 @@ void rt_down_write_nested_lock(struct rw_semaphore *rwsem,
        rwsem_acquire_nest(&rwsem->dep_map, 0, 0, nest, _RET_IP_);
        rt_mutex_lock(&rwsem->lock);
 }
+EXPORT_SYMBOL(rt_down_write_nested_lock);
 
 int  rt_down_read_trylock(struct rw_semaphore *rwsem)
 {


-- 

   Joakim
