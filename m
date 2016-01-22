From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Fri, 22 Jan 2016 13:58:38 +0200
Message-ID: <56A2196E.1020101@ti.com>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36299 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbcAVL6s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 06:58:48 -0500
In-Reply-To: <20160118201828.GE12309@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/18/2016 10:18 PM, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-01-18 10:08:23 [+0100]:
>
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -220,14 +220,14 @@ long syscall_trace_enter(struct pt_regs
>>
>> #define EXIT_TO_USERMODE_LOOP_FLAGS				\
>> 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
>> -	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY)
>> +	 _TIF_NEED_RESCHED_MASK | _TIF_USER_RETURN_NOTIFY)
>
> If I read this right, the loop where this define is used
> _TIF_ALLWORK_MASK in v4.1 of which _TIF_NEED_RESCHED_MASK was part of=
=2E
> Adding this will reassmeble the old behaviour.
> =E2=80=A6

Just a question (sorry if dumb). ARM has _TIF_WORK_MASK defined:
#define _TIF_WORK_MASK (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
	_TIF_NOTIFY_RESUME | _TIF_UPROBE)

which is used to calculate loop exit condition in
  do_work_pending() (arch/arm/kernel/signal.c).

Should _TIF_WORK_MASK also contain _TIF_NEED_RESCHED_LAZY?

--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
