From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/2] list_bl.h: make list head locking RT safe
Date: Fri, 21 Jun 2013 11:25:28 -0400
Message-ID: <20130621152528.GB19624@windriver.com>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
 <1370900209-40769-2-git-send-email-paul.gortmaker@windriver.com>
 <20130621122305.GC21228@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<paulmck@linux.vnet.ibm.com>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45921 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161519Ab3FUP0O (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 11:26:14 -0400
Content-Disposition: inline
In-Reply-To: <20130621122305.GC21228@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [PATCH 1/2] list_bl.h: make list head locking RT safe] On 21/06/2013 (Fri 14:23) Sebastian Andrzej Siewior wrote:

> * Paul Gortmaker | 2013-06-10 17:36:48 [-0400]:
> 
> >--- a/include/linux/list_bl.h
> >+++ b/include/linux/list_bl.h
> >@@ -17,7 +18,7 @@
> >  * some fast and compact auxiliary data.
> >  */
> > 
> >-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> >+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)
> > #define LIST_BL_LOCKMASK	1UL
> > #else
> > #define LIST_BL_LOCKMASK	0UL
> 
> On RT we don't have the lock mask anymore and those LIST_BL_BUG_ON()
> check don't do anything. It would be nice if you could check if the lock
> in that given entry is taken or not.
> 
> All in all it looks good.

I guess the easiest way to make use of the existing checks is to
simply set/clear the bit inside the lock.  That will allow the
existing code to check if the list got smashed by something.

If the incremental patch below is what you had in mind, then I'll
resend a v2 with this change incorporated.

Thanks,
Paul.
--


diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 64ba33b..a3ff8d7 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -18,7 +18,7 @@
  * some fast and compact auxiliary data.
  */
 
-#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)
+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK))
 #define LIST_BL_LOCKMASK	1UL
 #else
 #define LIST_BL_LOCKMASK	0UL
@@ -131,6 +131,7 @@ static inline void hlist_bl_lock(struct hlist_bl_head *b)
 	bit_spin_lock(0, (unsigned long *)b);
 #else
 	raw_spin_lock(&b->lock);
+	__set_bit(0, (unsigned long *)b);
 #endif
 }
 
@@ -139,6 +140,7 @@ static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 #ifndef CONFIG_PREEMPT_RT_BASE
 	__bit_spin_unlock(0, (unsigned long *)b);
 #else
+	__clear_bit(0, (unsigned long *)b);
 	raw_spin_unlock(&b->lock);
 #endif
 }
