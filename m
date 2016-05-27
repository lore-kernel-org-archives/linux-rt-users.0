From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] kernel/printk: Don't try to print from IRQ/NMI region
Date: Fri, 27 May 2016 16:56:01 +0200
Message-ID: <20160527145601.GC24120@linutronix.de>
References: <20160527135812.GB24120@linutronix.de>
 <20160527101251.0ae36e23@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47473 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbcE0O4F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 May 2016 10:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20160527101251.0ae36e23@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2016-05-27 10:12:51 [-0400]:

>On Fri, 27 May 2016 15:58:12 +0200
>Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> On -RT we try to acquire sleeping locks which might lead to warnings
>> from lockdep or a warn_on() from spin_try_lock() (which is a rtmutex=
 on
>> RT).
>> We don't print in general from a IRQ off region so we should not try
>> this via console_unblank() / bust_spinlocks() as well.
>>=20
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  kernel/printk/printk.c |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>=20
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1502,6 +1502,11 @@ static void call_console_drivers(int lev
>>  	if (!console_drivers)
>>  		return;
>> =20
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
>> +		if (in_irq() || in_nmi())
>> +			return;
>> +	}
>> +
>
>We use to have a patch where a console could flag itself as atomic.
>That is, that it doesn't call any sleeping locks. What happened to tha=
t.
>
>IIRC, the video console was one such console. Otherwise, we lose out o=
n
>backtraces in irq context.

video, like VT?
The call_console_drivers() does not check such a flag and I don't
remember about removing something like that. I was actually thinking
about adding such a flag=E2=80=A6 I remember you had something in your =
tree to
print from IRQ off regions via UART.

We don't print from a context with interrupts disabled or even a preemp=
t
disabled region. In such cases we just wake_up_klogd() and print it
later.
The reason for the patch was the HW/SW lockup detector which comes with
interrupts disabled or NMI context and gets to the console(s). Usually
we defer everything until later except in this case. And I got busted
later in the VT code (and the problem was that one sleeping while atomi=
c
warning which led to more stuff to be printed).

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
