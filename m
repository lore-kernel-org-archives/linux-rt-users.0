From: Alexander Fyodorov <halcy@yandex.ru>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 22 Aug 2013 18:23:18 +0400
Message-ID: <96171377181398@web13h.yandex.ru>
References: <102271374683007@web8f.yandex.ru>
 <20130812164145.GJ23040@linutronix.de>
 <393831376342036@web15d.yandex.ru> <20130821172431.GD16913@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward3h.mail.yandex.net ([84.201.187.148]:43681 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3HVO3D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Aug 2013 10:29:03 -0400
In-Reply-To: <20130821172431.GD16913@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

21.08.2013, 21:24, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>:
> Now that I looked at it for a while, would this fix your trouble?
>
> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
> --- a/kernel/rtmutex.c
> +++ b/kernel/rtmutex.c
> @@ -724,6 +724,7 @@ static void =9Anoinline __sched rt_spin_lock_slow=
lock(struct rt_mutex *lock)
> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct task_struct *lock_owner, *self =3D =
current;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct rt_mutex_waiter waiter, *top_waiter=
;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aint ret;
> + int new_state;
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Art_mutex_init_waiter(&waiter, true);
>
> @@ -744,8 +745,11 @@ static void =9Anoinline __sched rt_spin_lock_slo=
wlock(struct rt_mutex *lock)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* try_to_wake_up().
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
> =9A=9A=9A=9A=9A=9A=9A=9A=9Api_lock(&self->pi_lock);
> + new_state =3D TASK_UNINTERRUPTIBLE;
> + if (task_is_traced(self))
> + new_state |=3D __TASK_TRACED;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aself->saved_state =3D self->state;
> - __set_current_state(TASK_UNINTERRUPTIBLE);
> + __set_current_state(new_state);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Api_unlock(&self->pi_lock);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aret =3D task_blocks_on_rt_mutex(lock, &wai=
ter, self, 0);
>
> This should avoid that the trace state is lost while waiting on that
> mutex and the checks for "is traced" may remain the same.

This was the first thing I tried but it did not work. ptrace_check_atta=
ch() passes TASK_TRACED to wait_task_inactive() which tests for equalit=
y:

unsigned long wait_task_inactive(struct task_struct *p, long match_stat=
e)
< ... >
                        if (match_state && unlikely(p->state !=3D match=
_state)
                            && unlikely(p->saved_state !=3D match_state=
)) {

But this test will fail because we've added TASK_UNINTERRUPTIBLE and po=
ssibly removed some other bits from p->state. So I decided to add pi_lo=
ck locking instead - it is slower but it works with 100% guarantee.

Also adding __TASK_TRACED does not help with all the other places where=
 saved_state is checked and more races might still be hidden.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
