From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 29 Aug 2013 20:28:41 +0200
Message-ID: <521F92D9.5090701@linutronix.de>
References: <102271374683007@web8f.yandex.ru> <20130812164145.GJ23040@linutronix.de> <393831376342036@web15d.yandex.ru> <20130821172431.GD16913@linutronix.de> <96171377181398@web13h.yandex.ru> <20130829163300.GC15360@linutronix.de> <143271377797197@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Alexander Fyodorov <halcy@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52040 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3H2S2o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 14:28:44 -0400
In-Reply-To: <143271377797197@web5m.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/29/2013 07:26 PM, Alexander Fyodorov wrote:
>> +static inline bool task_is_traced(struct task_struct *task)
>> +{
>> + bool traced = false;
>> +
>> + if (task->state & __TASK_TRACED)
>> + return true;
>> +#ifdef CONFIG_PREEMPT_RT_FULL
>> + /* in case the task is sleeping on tasklist_lock */
>> + raw_spin_lock_irq(&task->pi_lock);
>> + if (task->state & __TASK_TRACED)
>> + traced = true;
>> + else if (task->saved_state & __TASK_TRACED)
>> + traced = true;
>> + raw_spin_unlock_irq(&task->pi_lock);
>> +#endif
>> + return traced;
>> +}
> 
> Since this is a low-level function, maybe its better to use raw_spin_lock_irqsave()? In case someone in the future will call task_is_traced() with disabled interrupts. Otherwise looks good.

The other function around don't do this and excpect it process context.
Thanks so far.

> 
> Still this is only half of the solution because the patch doesn't solve the race in wait_task_inactive() (and all other places which test both state and saved_state without holding pi_lock).

So you are concerned that missing pi_lock in wait_task_inactive(). This
is a problem if the task wakes up from sleeping on the lock while its
state is beeing checked. Hmm it indeed looks legal.
I keep that patch in queue but disabled and take another look once I
get back.
Does this missing pi_lock() affects you or is just a precaution?

> 

Sebastian
