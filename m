From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: cond_resched_lock and __might_sleep
Date: Tue, 25 Oct 2011 13:45:22 -0700
Message-ID: <4EA71FE2.6010904@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5074 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1JYUtA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Oct 2011 16:49:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am back porting an RT patch from 2.6.33 version to 2.6.32 version and 
this question
is in that context. Thanks in advance for you reply!

cond_resched_lock() calls __might_sleep with PREEMPT_LOCK_OFFSET as 1. 
And  when
preempt count is equal to 0 it would print the warning like below.

Warning
--------
BUG: sleeping function called from invalid context at fs/jbd/commit.c:902
pcnt: 0 1 in_atomic(): 0, irqs_disabled(): 0, pid: 818, name: kjournald


Q1. Why is it ok for preempt_count to be 1 when irqs are disabled but not
when preempt_count is 1?

I am getting the warning above when 
cond_resched_lock(&journal->j_list_lock) is invoked from
journal_commit_transaction(journal_t *journal) in fs/jbd/commit.c:902


cond_resched_lock code
----------------------
#ifdef CONFIG_PREEMPT
#define PREEMPT_LOCK_OFFSET    PREEMPT_OFFSET
#else
#define PREEMPT_LOCK_OFFSET    0
#endif

#define cond_resched_lock(lock) ({                \
     __might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);    \
     __cond_resched_lock(lock);                \
})

__might_sleep code
--------------------

void __might_sleep(char *file, int line, int preempt_offset)
{
#ifdef in_atomic
     static unsigned long prev_jiffy;    /* ratelimiting */

     if ((preempt_count_equals(preempt_offset) && !irqs_disabled()) ||
         system_state != SYSTEM_RUNNING || oops_in_progress)
         return;
     if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
         return;
     prev_jiffy = jiffies;

     printk(KERN_ERR
         "BUG: sleeping function called from invalid context at %s:%d\n",
.......
.......
}

preempt_count_equals() code
----------------------------

#if defined(CONFIG_DEBUG_SPINLOCK_SLEEP) || defined(CONFIG_DEBUG_PREEMPT)
static inline int preempt_count_equals(int preempt_offset)
{
     int nested = (preempt_count() & ~PREEMPT_ACTIVE);

#ifndef CONFIG_PREEMPT_RT
     nested += rcu_preempt_depth();
#endif

     return (nested == preempt_offset);
}
-Venkat



