From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rtmutex: Use raw_spin_trylock() in
 rt_mutex_slowlock() to ease possible live locks
Date: Thu, 20 Dec 2012 16:02:03 -0500
Message-ID: <1356037323.5896.64.camel@gandalf.local.home>
References: <1355967118.5896.52.camel@gandalf.local.home>
	 <1356026521.5896.55.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <cbe@osadl.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21123 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab2LTVCE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 16:02:04 -0500
In-Reply-To: <1356026521.5896.55.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-12-20 at 13:02 -0500, Steven Rostedt wrote:
> On Wed, 2012-12-19 at 20:31 -0500, Steven Rostedt wrote:
> 
> Talking with Thomas, the proper solution is:
> 
> > Then we have this lovely code:
> > 
> > block/blk-ioc.c: put_io_context_active()
> > 
> > retry:
> >         spin_lock_irqsave_nested(&ioc->lock, flags, 1);
> >         hlist_for_each_entry(icq, n, &ioc->icq_list, ioc_node) {
> >                 if (icq->flags & ICQ_EXITED)
> >                         continue;
> >                 if (spin_trylock(icq->q->queue_lock)) {
> >                         ioc_exit_icq(icq);
> >                         spin_unlock(icq->q->queue_lock);
> >                 } else {
> >                         spin_unlock_irqrestore(&ioc->lock, flags);
> >                         cpu_relax();
> 
> s/cpu_relax/cpu_chill/
> 
> -- Steve
> 
> >                         goto retry;
> >                 }
> >         }
> > 

Thomas,

As you hate the cpu_chill() as all it does is to do a msleep, what about
adding a cpu_chill_on_lock(), that, instead of doing a sleep, grabs and
releases the lock it wants. This is only safe for those locations that
are just trying to do a reverse lock grab:

-- Steve


diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index fab4cdd..263e021 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -110,7 +110,7 @@ static void ioc_release_fn(struct work_struct *work)
 			spin_unlock(q->queue_lock);
 		} else {
 			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
+			cpu_chill_on_lock(ioc->icq_list);
 			spin_lock_irqsave_nested(&ioc->lock, flags, 1);
 		}
 	}
@@ -188,7 +188,7 @@ retry:
 			spin_unlock(icq->q->queue_lock);
 		} else {
 			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
+			cpu_chill_on_lock(ioc->q->queue_lock);
 			goto retry;
 		}
 	}
diff --git a/include/linux/delay.h b/include/linux/delay.h
index e23a7c0..40d8db8 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -54,8 +54,20 @@ static inline void ssleep(unsigned int seconds)
 
 #ifdef CONFIG_PREEMPT_RT_FULL
 # define cpu_chill()	msleep(1)
+/*
+ * Use cpu_chill_on_lock() when trying to grab a lock in
+ * reverse order, and you have already released all locks
+ * that may cause a deadlock with the given lock.
+ */
+# define cpu_chill_on_lock(lock)		\
+	do {					\
+		spin_lock(&(lock));		\
+		spin_unlock(&(lock));		\
+		cpu_relax();			\
+	} while (0)
 #else
-# define cpu_chill()	cpu_relax()
+# define cpu_chill()			cpu_relax()
+# define cpu_chill_on_lock(lock)	cpu_relax()
 #endif
 
 #endif /* defined(_LINUX_DELAY_H) */


