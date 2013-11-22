From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 1/2] remove recursive call to migrate_disable in
	read_lock_bh
Date: Sat, 23 Nov 2013 00:39:25 +0100
Message-ID: <20131122233925.GA25921@opentech.at>
References: <20131120102107.GA12022@opentech.at> <20131122161234.GG8698@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:52720 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab3KVXja (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 18:39:30 -0500
Content-Disposition: inline
In-Reply-To: <20131122161234.GG8698@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Nov 2013, Sebastian Andrzej Siewior wrote:

> * Nicholas Mc Guire | 2013-11-20 11:21:07 [+0100]:
> 
> >diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
> >index 853ee36..87f5a1d 100644
> >--- a/include/linux/rwlock_rt.h
> >+++ b/include/linux/rwlock_rt.h
> >@@ -53,7 +53,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key
> > #define read_lock_bh(lock)				\
> > 	do {						\
> > 		local_bh_disable();			\
> >-		migrate_disable();			\
> > 		rt_read_lock(lock);			\
> > 	} while (0)
> > 
> 
> local_bh_disable() does only.
> | add_preempt_count()
> 
> Where is that second migrate_disable() comming from?
>
hmmm. am I looking at the wrong code path ?

kernel/softirq.c
void local_bh_disable(void)
{
        migrate_disable();
        current->softirq_nestcnt++;
}

confused... will check again.
hofrat 
