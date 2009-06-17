From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 10:12:21 +0900
Message-ID: <49b7c2350906161812t14784817o4ce71daae9c472cc@mail.gmail.com>
References: <loom.20090615T222836-377@post.gmane.org>
	 <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
	 <loom.20090616T074347-549@post.gmane.org>
	 <20090616182734.GD13048@pengutronix.de>
	 <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Martin Shepherd <mcs@astro.caltech.edu>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:34318 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZFQBMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 21:12:19 -0400
Received: by gxk10 with SMTP id 10so9215gxk.13
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2009 18:12:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/6/17 Thomas Gleixner <tglx@linutronix.de>:
> On Tue, 16 Jun 2009, Uwe Kleine-K=C3=B6nig wrote:
>> On Tue, Jun 16, 2009 at 07:59:28AM +0000, Martin Shepherd wrote:
>> > Suresh Kumar SHUKLA <suresh.shukla <at> st.com> writes:
>> > > =C2=A0 // get IRQ descriptor from IRQ, it contains pid
>> > > =C2=A0 desc =3D &irq_desc[IRQ_BASIC_TIMER_3_1];
>> >
>> > That's a very useful clue. I was thinking that I would have to wal=
k the process
>> > tree to find the thread by name. Following up on this clue, it app=
ears as though
>> > in kernel 2.6.29.4 I should be able to use desc=3Dirq_to_desc(irq)=
 to look up the
>> > IRQ descriptor, then use pid=3Dget_task_pid(desc->thread), to get =
the PID of the
>> > IRQ thread, then use sys_sched_setscheduler(pid,...) to change its=
 priority.
>> > I'll try that out in the morning.
>> I wouldn't recommend calling sys_sched_setscheduler from kernel spac=
e.
>> That's the userspace API and you need to pass a __user pointer as th=
ird
>> argument.
>>
>> The right way is to do this change from userspace.
>
> What a nonsense. Care to look at the code ?
>
> The irq/softirq threads call sys_sched_setscheduler() already to
> change their priorities.
Yes, I agree with your explanation.
> The right way to do this is to have an interface
> set_irq_thread_prio(irq, prio)
You means that we have to utilize wrapper function using
sys_sched_setscheduler()
function for PID setting of IRQ thread. It's right?

Thks,
GeunSik Lim

> Thanks,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx



--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
