From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking_selftest: Save/restore migrate_disable_atomic in
 locking selftest
Date: Fri, 11 Dec 2015 18:24:33 +0100
Message-ID: <20151211172433.GJ6720@linutronix.de>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de, yang.shi@windriver.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: jianchuan.wang@windriver.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* jianchuan.wang@windriver.com | 2015-11-23 15:19:38 [+0800]:

>From: Jianchuan Wang <jianchuan.wang@windriver.com>
>
>System will hang when enabling the kernel option
>CONFIG_DEBUG_LOCKING_API_SELFTESTS and CONFIG_SCHED_CONFIG
>in the preempt-rt kernel.
>
>In the preempt-rt kernel, migrate_enable()/migrage_disable() are called
>in the spinlock and read/write lock; The lock()/unlock() aren't used
>in pairs in the selftest processing changes the migrate_disable_atomic
>so that the system will hang in the dotest(), the calltrace is :
>printk() ..-> vprintk_emit() -> migrage_disable()
>-> WARN_ON_ONCE() ..-> warn_slowpath_common() ..-> printk()
>
>For fixing it, we need save the migrate_disable_atomic before self-testing
>and restore migrate_disable_atomic after self-testing.

So this is similar to saved_preempt_count. This needs to compile with
!CONFIG_PREEMPT_RT_FULL which I believe is not the case.

>Signed-off-by: Jianchuan Wang <jianchuan.wang@windriver.com>
>---
> lib/locking-selftest.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
>index b93a610..61798da 100644
>--- a/lib/locking-selftest.c
>+++ b/lib/locking-selftest.c
>@@ -997,10 +997,23 @@ static int unexpected_testcase_failures;
> static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
> {
> 	unsigned long saved_preempt_count = preempt_count();
>+#ifdef CONFIG_SCHED_DEBUG
>+	struct task_struct *p = current;
>+	int save_migrate_atomic;
>+#endif
> 
> 	WARN_ON(irqs_disabled());
> 
>+#ifdef CONFIG_SCHED_DEBUG
>+	save_migrate_atomic = p->migrate_disable_atomic;
>+#endif

Shouldn't we save  p->migrate_disable as well?

Sebastian
