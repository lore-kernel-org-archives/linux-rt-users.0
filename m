From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: [PATCH 1/2] [RT] hrtimers stuck in waitqueue
Date: Mon, 25 Aug 2008 15:09:04 +0200
Message-ID: <48B2AEF0.4020809@bull.net>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-2-git-send-email-gilles.carry@bull.net> <alpine.LFD.1.10.0808221619080.3243@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, tinytim@us.ibm.com,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43302 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbYHYNJQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2008 09:09:16 -0400
In-Reply-To: <alpine.LFD.1.10.0808221619080.3243@apollo.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Mon, 18 Aug 2008, Gilles Carry wrote:
> 
>>This patch makes hrtimers initialized with hrtimer_init_sleeper
>>to use another mode and then not be stuck in waitqueues when
>>hrtimer_interrupt is very busy.
>>
>>The new mode is HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
>>The above-mentionned timers have been moved from
>>HRTIMER_CB_IRQSAFE_NO_SOFTIRQ to
>>HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ.
>>
>>HRTIMER_CB_IRQSAFE_NO_RESTART_NO_SOFIRQ timers use a slightly different
>>state machine from HRTIMER_CB_IRQSAFE_NO_SOFTIRQ's as when removing the
>>timer, __run_hrtimer sets the status to INACTIVE _then_
>>wakes up the thread. This way, an awakened thread cannot enter
>>hrtimer_cancel before the timer's status has changed.
> 
> 
> NAK. That solution is racy.
> 
>      CPU 0                        CPU 1
> 
>      timer interrupt runs         signal wakeup for task which sleeps
>      timer->state = INACTIVE;
> 
> -> Race window start
>      base->lock is dropped
> 				  hrtimer_cancel()
> 				  data structure on stack is destroyed
> 
>      timer function called
>      	   data structure access --> POOOF
> 
> -> Race window end
> 
>      base->lock is locked
> 
> The race is extremly narrow and requires an SMI or some other delay
> (bus stall, cache miss ...) on CPU 0, but it exists.
> 
> Fix below.
> 
> Thanks,
> 	tglx
> 

Ooops! I did not think of that.
A so narrow window that my tests did not reveal.

Thank-you Thomas.

Gilles.
