From: Sam Kappen <skappen@mvista.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Mon, 27 Nov 2017 12:16:36 +0530
Message-ID: <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de> <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru> <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com> <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
 <20171124093724.GB2564@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38805 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdK0Gqh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Nov 2017 01:46:37 -0500
Received: by mail-ua0-f194.google.com with SMTP id f14so18307252uaa.5
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Nov 2017 22:46:37 -0800 (PST)
In-Reply-To: <20171124093724.GB2564@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Many thanks for your kind response.
I will put it for long run test and update.

Could you please look at my below queries?

1.)
I had derived and tried a patch based on the below analysis.
( I referred below open source commit, to derive on this patch.
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.9.47-rt37-rebase&id=7a347757f027190c95a363a491c18156a926a370
)

In some cases pi_lock in rt_spin_lock_slowlock does not retain the
irqs state while exiting function, this causes
issue in migrate_disable() + enable as they are not symmetrical in
regard to the status of interrupts.
To fix pi_lock & pi_unlock in rt_spin_lock_slowlock, it has been
modified to retain irq state by using
raw_spin_lock and raw_spin_unlock and also modified wait_lock in
rt_spin_lock_slowlock with raw_spin_lock_irqsave & *_restore.



kernel/rtmutex.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 7cf4b8b..9c67d80 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1191,8 +1191,6 @@ static int adaptive_wait(struct rt_mutex *lock,
 }
 #endif

-# define pi_lock(lock) raw_spin_lock_irq(lock)
-# define pi_unlock(lock) raw_spin_unlock_irq(lock)

 /*
  * Slow path lock function spin_lock style: this variant is very
@@ -1206,14 +1204,15 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
  struct task_struct *lock_owner, *self = current;
  struct rt_mutex_waiter waiter, *top_waiter;
  int ret;
+ unsigned long flags;

  rt_mutex_init_waiter(&waiter, true);

- raw_spin_lock(&lock->wait_lock);
+ raw_spin_lock_irqsave(&lock->wait_lock, flags);
  init_lists(lock);

  if (__try_to_take_rt_mutex(lock, self, NULL, STEAL_LATERAL)) {
- raw_spin_unlock(&lock->wait_lock);
+ raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
  return;
  }

@@ -1225,10 +1224,10 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
  * as well. We are serialized via pi_lock against wakeups. See
  * try_to_wake_up().
  */
- pi_lock(&self->pi_lock);
+ raw_spin_lock(&self->pi_lock);
  self->saved_state = self->state;
  __set_current_state(TASK_UNINTERRUPTIBLE);
- pi_unlock(&self->pi_lock);
+ raw_spin_unlock(&self->pi_lock);

  ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
  BUG_ON(ret);
@@ -1241,18 +1240,18 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
  top_waiter = rt_mutex_top_waiter(lock);
  lock_owner = rt_mutex_owner(lock);

- raw_spin_unlock(&lock->wait_lock);
+ raw_spin_unlock_irqrestore(&lock->wait_lock, flags);

  debug_rt_mutex_print_deadlock(&waiter);

  if (top_waiter != &waiter || adaptive_wait(lock, lock_owner))
  schedule_rt_mutex(lock);

- raw_spin_lock(&lock->wait_lock);
+ raw_spin_lock_irqsave(&lock->wait_lock, flags);

- pi_lock(&self->pi_lock);
+ raw_spin_lock(&self->pi_lock);
  __set_current_state(TASK_UNINTERRUPTIBLE);
- pi_unlock(&self->pi_lock);
+ raw_spin_unlock(&self->pi_lock);
  }

  /*
@@ -1262,10 +1261,10 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
  * happened while we were blocked. Clear saved_state so
  * try_to_wakeup() does not get confused.
  */
- pi_lock(&self->pi_lock);
+ raw_spin_lock(&self->pi_lock);
  __set_current_state(self->saved_state);
  self->saved_state = TASK_RUNNING;
- pi_unlock(&self->pi_lock);
+ raw_spin_unlock(&self->pi_lock);

  /*
  * try_to_take_rt_mutex() sets the waiter bit
@@ -1276,7 +1275,7 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
  BUG_ON(rt_mutex_has_waiters(lock) && &waiter == rt_mutex_top_waiter(lock));
  BUG_ON(!plist_node_empty(&waiter.list_entry));

- raw_spin_unlock(&lock->wait_lock);
+ raw_spin_unlock_irqrestore(&lock->wait_lock, flags);

  debug_rt_mutex_free_waiter(&waiter);
 }
-- 
2.7.4

We were testing above patch on multiple targets we could experience
some stuck issue on some remote target after 2 days. I am not
sure what really happens there, may be the issue when try for
scheduling with irq in disabled state.
The systems I have tested found to be worked 7 days after that I
stopped the test.


2.) With your patch during the slab allocations irqs will be in enabled state.
So if we enable irqs in early stage will there be any side effects? I
am sorry if my question doesn't seem
to be logical.



Regards,
Sam






On Fri, Nov 24, 2017 at 3:07 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-11-24 12:09:16 [+0530], Sam Kappen wrote:
>> Hi,
> Hi,
>
>> I am also faces a similar kind of issue on X86 target, while testing
>> 3.10.105-rt119.
>> The issue is seen during boot-up when USB/SCSI enumeration starts.
>>
>> Below is the log from my console
>
> Can you try if the patch I posted solves that? From the callchain it
> looks like the same thing.
>
> Sebastian
