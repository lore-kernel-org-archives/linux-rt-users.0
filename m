From: Yimin Deng <yimin11.deng@gmail.com>
Subject: kernel BUG at kernel/rtmutex_common.h:75
Date: Wed, 4 Nov 2015 22:35:57 +0800
Message-ID: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33646 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbbKDOf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2015 09:35:59 -0500
Received: by lfgh9 with SMTP id h9so3958737lfg.0
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Nov 2015 06:35:58 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I encountered =E2=80=9Ckernel BUG=E2=80=9D which was reported in the
rt_mutex_top_waiter() at kernel/rtmutex_common.h:75.

Linux version: 3.12.37-rt51; CONFIG_PREEMPT_RT_FULL is disabled.
Architecture: PowerPC

We ported an application from pSOS RTOS to Linux using the
Xenomai-Mercury (=3Dlibrary to map pSOS task to POSIX threads). And We
have several threads running in the real-time priority domain.
ThreadA: running at prio -59. pthread_mutex_lock() +
pthread_cond_timedwait() + pthread_mutex_unlock()
ThreadB: running at prio -84. pthread_mutex_lock() +
pthread_cond_signal() + pthread_mutex_unlock()

ThreadA:
------ ------
futex_wait_requeue_pi()
    futex_wait_queue_me()
    <timed out>

    raw_spin_lock_irq(&current->pi_lock);
    if (current->pi_blocked_on) {
        raw_spin_unlock_irq(&current->pi_lock);
    } else {
        current->pi_blocked_on =3D PI_WAKEUP_INPROGRESS;
        raw_spin_unlock_irq(&current->pi_lock);
            <-- ThreadA was interrupted and preempted!
        spin_lock(&hb->lock);


ThreadB:
------ ------
rt_mutex_start_proxy_lock();
    task_blocks_on_rt_mutex();  <-- return "-EAGAIN" due to
"task->pi_blocked_on =3D=3D PI_WAKEUP_INPROGRESS"
    ...
    if (unlikely(ret))
        remove_waiter(lock, waiter);
            int first =3D (waiter =3D=3D rt_mutex_top_waiter(lock));  <=
--
BUG_ON(w->lock !=3D lock);

It seems that the purpose to call the remove_waiter() is to remove the
waiter added by =E2=80=9Cplist_add(&waiter->list_entry, &lock->wait_lis=
t);=E2=80=9D in
the task_blocks_on_rt_mutex(). But in the scenario above there's no
waiter on the lock yet and
the waiter has not been added into the wait list of the lock in the
task_blocks_on_rt_mutex() due to the failure =E2=80=9C-EAGAIN=E2=80=9D.=
 So it reported
kernel BUG in the rt_mutex_top_waiter().

I modified it as below and the issue seems disappear.
- if (unlikely(ret))
+ if (unlikely(ret && (-EAGAIN !=3D ret)))
       remove_waiter(lock, waiter);

Could the scenario above be possible? If so, how to resolve this issue?
Thanks!

B.R.
Yimin Deng
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
