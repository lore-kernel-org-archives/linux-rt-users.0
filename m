From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RESEND -rt] mm: perform lru_add_drain_all() remotely
Date: Thu, 12 May 2016 11:21:51 +0200
Message-ID: <20160512092151.GC19035@linutronix.de>
References: <20160509105037.1555d0e0@redhat.com>
 <20160512084230.GA19035@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52439 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcELJVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2016 05:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20160512084230.GA19035@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2016-05-12 10:42:30 [+0200]:

>>diff --git a/mm/swap.c b/mm/swap.c
>>index ca194ae..84c3c21 100644
>>--- a/mm/swap.c
>>+++ b/mm/swap.c
>>@@ -821,9 +821,9 @@ void lru_add_drain_cpu(int cpu)
>> 		unsigned long flags;
>>=20
>> 		/* No harm done if a racing interrupt already did this */
>>-		local_lock_irqsave(rotate_lock, flags);
>>+		local_lock_irqsave_other_cpu(rotate_lock, flags, cpu);
>> 		pagevec_move_tail(pvec);
>>-		local_unlock_irqrestore(rotate_lock, flags);
>>+		local_unlock_irqrestore_other_cpu(rotate_lock, flags, cpu);
>
>This piece might be required independently of this patch. It would be
>nice to have it in page_alloc_cpu_notify() :) I take care of this=E2=80=
=A6

no, I won't :)
It looks halfway like an upstream bug. Vanila has here local_irq_save()
which always matches the local CPU except when it is invoked from
page_alloc_cpu_notify() CPU_DEAD notifier. Here it does not matter
because the CPU is gone and won't take the locks anymore.
Unless, we start taking them cross-CPU which is only possible with this
patch.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
