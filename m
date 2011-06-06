From: Monica Puig-Pey <puigpeym@unican.es>
Subject: Re: Changing Kernel thread priorities
Date: Mon, 6 Jun 2011 13:58:23 +0200
Message-ID: <4DECC0DF.8070209@unican.es>
References: <4DEA1BA9.7020303@unican.es><4DEA1F22.6000603@unican.es><4DEA255
		B.2050503@unican.es><4DECBE44.2070803@unican.es>
	<BANLkTi=xSJOgY735PE44YtkQmrdhgetGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Rolando Martins <rolando.martins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver2.unican.es ([130.206.5.101]:48567 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab1FFL6b (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 07:58:31 -0400
In-Reply-To: <BANLkTi=xSJOgY735PE44YtkQmrdhgetGdQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

El 06/06/11 13:54, Rolando Martins escribi=F3:
> Hi,
> I use the following:
>
> PIDs=3D$(ps -eLo pid,cls,rtprio,pri,nice,cmd | grep -i "irq" | awk '{
> print $1; }' | xargs echo)
> for i in $PIDs
> do
>      ret=3D$(chrt -f -p 99 $i)
> done
>
> This will change the kernel thread associated with an irq handler to
> RT FIFO prio 99.
> Just change the script to your specific interrupt.
>
> Hope it helps,
> Rolando
>
> On Mon, Jun 6, 2011 at 12:47 PM, Monica Puig-Pey<puigpeym@unican.es> =
 wrote:
>> I am writing a driver which has one kernel thread associated with it=
=2E
>> I want to change the priority of this thread, so that I can specify =
the
>> order in which it is scheduled following an interrupt.
>> I'm using:
>>
>>   sched_setscheduler(struct task_struct *, int, struct sched_param *=
);
>>
>> but it doesn't work. I tried to change the priority from the init_mo=
dule,
>> and also from the Kernel Thread, but there is no way.
>>
>> Kernel version is 2.6.31-11-rt
>>
>> What do I call to change a kernel thread priority?
>>
>> Thanks you very much
>>
>> M=F3nica
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

I need to change the priority from inside the driver, when creating the=
=20
kernel thread.
Your script is useful but it is done in user context,
Any other help please?

M=F3nica


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
