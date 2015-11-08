From: Yimin Deng <yimin11.deng@gmail.com>
Subject: Re: kernel BUG at kernel/rtmutex_common.h:75
Date: Sun, 8 Nov 2015 11:31:53 +0800
Message-ID: <CAAh1qt=9nrxxHdWyk_TwjqfF=qiMU2=AJwpXN6NE4sFjGaJeFA@mail.gmail.com>
References: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com>
	<alpine.DEB.2.11.1511061215400.4032@nanos>
	<alpine.DEB.2.11.1511071908340.4032@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35922 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbKHDbz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Nov 2015 22:31:55 -0500
Received: by lfs39 with SMTP id 39so5438977lfs.3
        for <linux-rt-users@vger.kernel.org>; Sat, 07 Nov 2015 19:31:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1511071908340.4032@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2015-11-08 2:09 GMT+08:00 Thomas Gleixner <tglx@linutronix.de>:
> On Fri, 6 Nov 2015, Thomas Gleixner wrote:
> Btw, please update to 3.12.48-rt66. It contains quite some bugfixes in
> the area of futex/rtmutex.
>
> Thanks,
>
>         tglx
On Fri, 6 Nov 2015, Thomas Gleixner wrote:
>> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
>> index 7601c1332a88..0e6505d5ce4a 100644
>> --- a/kernel/rtmutex.c
>> +++ b/kernel/rtmutex.c
>> @@ -1003,11 +1003,18 @@ static void wakeup_next_waiter(struct rt_mutex *lock)
>>  static void remove_waiter(struct rt_mutex *lock,
>>                           struct rt_mutex_waiter *waiter)
>>  {
>> -       bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
>>         struct task_struct *owner = rt_mutex_owner(lock);
>>         struct rt_mutex *next_lock = NULL;
>> +       bool is_top_waiter = false;
>>         unsigned long flags;
>>
>> +       /*
>> +        * @waiter might be not queued when task_blocks_on_rt_mutex()
>> +        * returned early so @lock might not have any waiters.
>> +        */
>> +       if (rt_mutex_has_waiters())
>> +               is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
>> +
>>         raw_spin_lock_irqsave(&current->pi_lock, flags);
>>         rt_mutex_dequeue(lock, waiter);
>>         current->pi_blocked_on = NULL;

Sincerely appreciate for your answers!

Could it be modified as below? It seems not necessary to call
rt_mutex_dequeue() and clear the current->pi_blocked_on if there's no
waiter on the lock. And the waiter->task is not the 'current' when the
remove_waiter() is called in the function rt_mutex_start_proxy_lock().

 static void remove_waiter(struct rt_mutex *lock,
                          struct rt_mutex_waiter *waiter)
 {
-       bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
        struct task_struct *owner = rt_mutex_owner(lock);
        struct rt_mutex *next_lock = NULL;
+       bool is_top_waiter;
+ struct task_struct *task = waiter->task;
        unsigned long flags;

+       /*
+        * @waiter might be not queued when task_blocks_on_rt_mutex()
+        * returned early so @lock might not have any waiters.
+        */
+       if (unlikely(!rt_mutex_has_waiters()))
+ return;
+
+       is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
+
-       raw_spin_lock_irqsave(&current->pi_lock, flags);
-       rt_mutex_dequeue(lock, waiter);
-       current->pi_blocked_on = NULL;
- raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+ raw_spin_lock_irqsave(&task->pi_lock, flags);
+       rt_mutex_dequeue(lock, waiter);
+       task->pi_blocked_on = NULL;
+ __rt_mutex_adjust_prio(task);    <-- I'm not sure if it is necessary.
+ raw_spin_unlock_irqrestore(&task->pi_lock, flags);

......
- rt_mutex_adjust_prio_chain(owner, 0, lock, next_lock, NULL, current);
+ rt_mutex_adjust_prio_chain(owner, 0, lock, next_lock, NULL, task);
......
 }

I'm sorry for so many questions.
Thanks ahead!

B.R.
Yimin Deng
