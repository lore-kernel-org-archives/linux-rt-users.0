From: Mark Hounschell <markh@compro.net>
Subject: Re: Changing Kernel thread priorities
Date: Mon, 06 Jun 2011 12:49:30 -0400
Message-ID: <4DED051A.6020702@compro.net>
References: <4DEA1BA9.7020303@unican.es><4DEA1F22.6000603@unican.es><4DEA255		B.2050503@unican.es><4DECBE44.2070803@unican.es> 	<BANLkTi=xSJOgY735PE44YtkQmrdhgetGdQ@mail.gmail.com> <4DECC0DF.8070209@unican.es>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:33724 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1FFRDu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 13:03:50 -0400
In-Reply-To: <4DECC0DF.8070209@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/06/2011 07:58 AM, Monica Puig-Pey wrote:
> El 06/06/11 13:54, Rolando Martins escribi=F3:
>> Hi,
>> I use the following:
>>
>> PIDs=3D$(ps -eLo pid,cls,rtprio,pri,nice,cmd | grep -i "irq" | awk '=
{
>> print $1; }' | xargs echo)
>> for i in $PIDs
>> do
>> ret=3D$(chrt -f -p 99 $i)
>> done
>>
>> This will change the kernel thread associated with an irq handler to
>> RT FIFO prio 99.
>> Just change the script to your specific interrupt.
>>
>> Hope it helps,
>> Rolando
>>
>> On Mon, Jun 6, 2011 at 12:47 PM, Monica Puig-Pey<puigpeym@unican.es>
>> wrote:
>>> I am writing a driver which has one kernel thread associated with i=
t.
>>> I want to change the priority of this thread, so that I can specify=
 the
>>> order in which it is scheduled following an interrupt.
>>> I'm using:
>>>
>>> sched_setscheduler(struct task_struct *, int, struct sched_param *)=
;
>>>
>>> but it doesn't work. I tried to change the priority from the
>>> init_module,
>>> and also from the Kernel Thread, but there is no way.
>>>
>>> Kernel version is 2.6.31-11-rt
>>>
>>> What do I call to change a kernel thread priority?
>>>
>>> Thanks you very much
>>>
>>> M=F3nica
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-rt-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>
> I need to change the priority from inside the driver, when creating t=
he
> kernel thread.
> Your script is useful but it is done in user context,
> Any other help please?

What I do is record the PID of the thread in the driver, then create an=
=20
IOCTL for your driver that user land can call that either returns the=20
PID so you can do it in user land, or cause the IOCTL code to do it in=20
the driver.

The same can be done with the affinity of the IRQ if you record the IRQ=
=20
number.

Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
