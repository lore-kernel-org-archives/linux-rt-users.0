From: Alexander Fyodorov <halcy@yandex.ru>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 29 Aug 2013 21:26:37 +0400
Message-ID: <143271377797197@web5m.yandex.ru>
References: <102271374683007@web8f.yandex.ru>
 <20130812164145.GJ23040@linutronix.de>
 <393831376342036@web15d.yandex.ru>
 <20130821172431.GD16913@linutronix.de>
 <96171377181398@web13h.yandex.ru> <20130829163300.GC15360@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward6.mail.yandex.net ([77.88.60.125]:57161 "EHLO
	forward6.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab3H2R0k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 13:26:40 -0400
In-Reply-To: <20130829163300.GC15360@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> +static inline bool task_is_traced(struct task_struct *task)
> +{
> + bool traced = false;
> +
> + if (task->state & __TASK_TRACED)
> + return true;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> + /* in case the task is sleeping on tasklist_lock */
> + raw_spin_lock_irq(&task->pi_lock);
> + if (task->state & __TASK_TRACED)
> + traced = true;
> + else if (task->saved_state & __TASK_TRACED)
> + traced = true;
> + raw_spin_unlock_irq(&task->pi_lock);
> +#endif
> + return traced;
> +}

Since this is a low-level function, maybe its better to use raw_spin_lock_irqsave()? In case someone in the future will call task_is_traced() with disabled interrupts. Otherwise looks good.

Still this is only half of the solution because the patch doesn't solve the race in wait_task_inactive() (and all other places which test both state and saved_state without holding pi_lock).
