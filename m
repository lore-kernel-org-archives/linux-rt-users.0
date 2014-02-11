From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: Cyclictest results on Sparc64 with PREEMPT_RT
Date: Wed, 12 Feb 2014 01:44:31 +0400
Message-ID: <193151392155071@web21h.yandex.ru>
References: <52E616DB.2040202@oracle.com> <20140207123529.GA2382@linutronix.de> <52F4D474.6080107@oracle.com> <52F4DED2.3010800@linutronix.de> <52F4E00F.9010009@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"davem@davemloft.net" <davem@davemloft.net>
To: Allen Pais <allen.pais@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward3h.mail.yandex.net ([84.201.187.148]:39784 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbaBKVwE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Feb 2014 16:52:04 -0500
In-Reply-To: <52F4E00F.9010009@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



07.02.2014, 17:31, "Allen Pais" <allen.pais@oracle.com>:
> Sebastian,
>
>> =9AThis is a dead lock. Whatever lock you go after, you are already
>> =9Aholding it in this context / hackbench. I don't know how you got =
from
>> =9Aperfctr_irq() to do_exit() but you shouldn't do this in hardirq
>> =9Acontext.
>>
>> =9ABut calling do_exit() is probably error recovery since it would k=
ill
>> =9Ahackbench and I assume it wasn't done yet.
>> =9AI see also tl0_irq15() in your stack trace. This is that evil NMI=
 that
>> =9Achecks if the system is stalling. I think that you stuck in
>> =9Aflush_tsb_user() on that raw_lock and somebody is not letting it =
go and
>> =9Aso you spin for ever. Maybe full lockdep shows you some informati=
ons
>> =9Aabout wrong context locking etc.
>
> Yes, there's someone's holding the lock and not releasing it in
> flush_tsb_user(). I'll check with lockdep.

I'm looking at arch_enter_lazy_mmu_mode()/arch_leave_lazy_mmu_mode().
It looks like it's assumed they are called with preemption disabled.
In !RT case they are called after spin_lock() which gives preemption
disabled. In RT the spinlocks are mutexes and there is preemption.
I think we need something like migrate_disable() here.

I have no sparc right now and did not check this carefully. Check if
you are interested :)

Kirill

> Thanks,
> Allen
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
