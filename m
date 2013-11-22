From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] remove recursive call to migrate_disable in
 read_lock_bh
Date: Fri, 22 Nov 2013 17:12:34 +0100
Message-ID: <20131122161234.GG8698@linutronix.de>
References: <20131120102107.GA12022@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45750 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KVQMf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 11:12:35 -0500
Content-Disposition: inline
In-Reply-To: <20131120102107.GA12022@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-20 11:21:07 [+0100]:

>diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
>index 853ee36..87f5a1d 100644
>--- a/include/linux/rwlock_rt.h
>+++ b/include/linux/rwlock_rt.h
>@@ -53,7 +53,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
> #define read_lock_bh(lock)				\
> 	do {						\
> 		local_bh_disable();			\
>-		migrate_disable();			\
> 		rt_read_lock(lock);			\
> 	} while (0)
> 

local_bh_disable() does only.
| add_preempt_count()

Where is that second migrate_disable() comming from?

Sebastian
