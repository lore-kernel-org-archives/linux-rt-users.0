From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] drop recursive migrate_disable in rt_write_trylock_irqsave
	- the right one this time...
Date: Fri, 22 Nov 2013 06:09:34 +0100
Message-ID: <20131122050934.GA11938@opentech.at>
References: <20131120102107.GA12022@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:33578 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3KVFJg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 00:09:36 -0500
Content-Disposition: inline
In-Reply-To: <20131120102107.GA12022@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


sorry - sent out the wrong file before

thx!
hofrat

>From f7702e3f2077b29b51172662fb988ce7fec9a985 Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 22 Nov 2013 00:04:51 -0500
Subject: [PATCH] drop recursive migrate_disable in rt_write_trylock_irqsave

 rt_write_trylock_irqsave unconditionally calls rt_write_trylock which will     
 disable migration if the lock was sucessfully acquired.                        
 This patch drops the recursive migrate_disable/enable in                       
 rt_write_trylock_irqsave and rt_write_unlock_irq respecttively                 

 patch is on top of 3.12-rt2
                                                                                
 No change of functionality

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/rwlock_rt.h |    1 -
 kernel/rt.c               |    4 +---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 9a5fe26..2dbabe2 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -113,7 +113,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
 		typecheck(unsigned long, flags);	\
 		(void) flags;				\
 		rt_write_unlock(lock);			\
-		migrate_enable();			\
 	} while (0)
 
 #endif
diff --git a/kernel/rt.c b/kernel/rt.c
index 4b2c4a9..71d26a4 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -196,10 +196,8 @@ int __lockfunc rt_write_trylock_irqsave(rwlock_t *rwlock, unsigned long *flags)
 	int ret;
 
 	*flags = 0;
-	migrate_disable();
 	ret = rt_write_trylock(rwlock);
-	if (!ret)
-		migrate_enable();
+
 	return ret;
 }
 EXPORT_SYMBOL(rt_write_trylock_irqsave);
-- 
1.7.2.5

