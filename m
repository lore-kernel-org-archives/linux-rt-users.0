From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Mon, 7 Aug 2017 15:19:37 +0200
Message-ID: <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGNTj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Aug 2017 09:19:39 -0400
Content-Disposition: inline
In-Reply-To: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-07-15 19:43:11 [+0200], Jacek Konieczny wrote:
> Hello,
Hi,

> Most of the information I could find online is quite outdated or
> incomplete, so I have really little idea what the proper configuration
> of the RT kernel is or how to debug it.

usually people take their local distro's config (make localyesconfig),
patch RT, enable PREEMPT-FULL (via make oldconfig) and tweak the config
in what they think is best for them.

> Sometimes it would just lock up hard with no warning and nothing would
> work – not even magic sysrq.
> Other times it would gradually slow down until it is not usable at all.
> Sometimes I would be able to see some 'BUG' in dmesg, but rarely I would
> be able to restart the system cleanly.
> Sometimes only some subsystems would fail, while otherwise the system
> still seems to work. It could be sound, mouse, keyboard or network that
> doesn't work.
> 
> System logs would contain some kernel BUGs/WARNINGs, but they would
> often look generic and would not point to a specific problem (not for me).

one would need a BUG/WARNING error report of some kind to start
somewhere.

> Today I have tried kernel 4.9.37 with the 4.9.35-rt25 patch. It failed
> again, here are the kernel error logs:
> 
> https://gist.github.com/Jajcus/494b79062b537269b49265ff3c50ee78

Is this reproducible or do you so each time something else?

> I have no idea how to properly debug the problem, even what data should
> I collect to prepare a reasonable bug report.

This is probably -EDEADLK coming from task_blocks_on_rt_mutex(). I
suspect that the following patch

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 78a6c4a223c1..59430ede6e89 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -524,6 +524,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		}
 		put_task_struct(task);
 
+		pr_err("EDEADLK #1\n");
 		return -EDEADLK;
 	}
 
@@ -639,6 +640,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
+		pr_err("EDEADLK #2\n");
 		goto out_unlock_pi;
 	}
 
@@ -1081,6 +1083,8 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
 	raw_spin_unlock(&self->pi_lock);
 
 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
+	if (ret )
+		pr_err("Crashing soon on %d (%p %p)\n", ret, rt_mutex_owner(lock), self);
 	BUG_ON(ret);
 
 	for (;;) {

will return "EDEADLK #2". And we got rid of two instances of this error
before v4.9 went into maintain mode.

> Any idea what is the problem?
> Any hints how to debug it?

The patch should confirm the origin of the return error code, not the
reason. The backtrace comes from networking so with networking disabled,
it should not get into this particular problem.
One thing you could try, is to see if the latest v4.11 based RT kernel
works more reliable.

> Greets,
> Jacek

Sebastian
