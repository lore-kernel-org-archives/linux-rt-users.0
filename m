From: Mark Hounschell <markh@compro.net>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 07 Jun 2011 14:55:17 -0400
Message-ID: <4DEE7415.8000606@compro.net>
References: <4DEA1BA9.7020303@unican.es><4DEA1F22.6000603@unican.es><4DEA255						B.2050503@unican.es><4DECBE44.2070803@unican.es> 					<BANLkTi=xSJOgY735PE44YtkQmrdhgetGdQ@mail.gmail.com> 				<4DECC0DF.8070209@unican.es> <4DED051A.6020702@compro.net> 		<4DEDE411.6010807@unican.es> <4DEDEBFF.10907@cfl.rr.com> 	<4DEDF366.6000706@cfl.rr.com> <4DEE6F4E.1030107@unican.es>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dmarkh@cfl.rr.com, Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([12.186.155.4]:2922 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab1FGSzT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jun 2011 14:55:19 -0400
In-Reply-To: <4DEE6F4E.1030107@unican.es>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/07/2011 02:34 PM, Monica Puig-Pey wrote:
> El 07/06/11 11:46, Mark Hounschell escribi=F3:
>> On 06/07/2011 05:14 AM, Mark Hounschell wrote:
>>> On 06/07/2011 04:40 AM, Monica Puig-Pey wrote:
>>>> El 06/06/11 18:49, Mark Hounschell escribi=F3:
>>>>> On 06/06/2011 07:58 AM, Monica Puig-Pey wrote:
>>>>>> El 06/06/11 13:54, Rolando Martins escribi=F3:
>>>>>>> Hi,
>>>>>>> I use the following:
>>>>>>>
>>>>>>> PIDs=3D$(ps -eLo pid,cls,rtprio,pri,nice,cmd | grep -i "irq" | =
awk '{
>>>>>>> print $1; }' | xargs echo)
>>>>>>> for i in $PIDs
>>>>>>> do
>>>>>>> ret=3D$(chrt -f -p 99 $i)
>>>>>>> done
>>>>>>>
>>>>>>> This will change the kernel thread associated with an irq handl=
er to
>>>>>>> RT FIFO prio 99.
>>>>>>> Just change the script to your specific interrupt.
>>>>>>>
>>>>>>> Hope it helps,
>>>>>>> Rolando
>>>>>>>
>>>>>>> On Mon, Jun 6, 2011 at 12:47 PM, Monica Puig-Pey
>>>>>>> wrote:
>>>>>>>> I am writing a driver which has one kernel thread associated w=
ith
>>>>>>>> it.
>>>>>>>> I want to change the priority of this thread, so that I can
>>>>>>>> specify the
>>>>>>>> order in which it is scheduled following an interrupt.
>>>>>>>> I'm using:
>>>>>>>>
>>>>>>>> sched_setscheduler(struct task_struct *, int, struct sched_par=
am
>>>>>>>> *);
>>>>>>>>
>>>>>>>> but it doesn't work. I tried to change the priority from the
>>>>>>>> init_module,
>>>>>>>> and also from the Kernel Thread, but there is no way.
>>>>>>>>
>>>>>>>> Kernel version is 2.6.31-11-rt
>>>>>>>>
>>>>>>>> What do I call to change a kernel thread priority?
>>>>>>>>
>>>>>>>> Thanks you very much
>>>>>>>>
>>>>>>>> M=F3nica
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> linux-rt-users" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>>
>>>>>>
>>>>>> I need to change the priority from inside the driver, when creat=
ing
>>>>>> the
>>>>>> kernel thread.
>>>>>> Your script is useful but it is done in user context,
>>>>>> Any other help please?
>>>>>
>>>>> What I do is record the PID of the thread in the driver, then
>>>>> create an
>>>>> IOCTL for your driver that user land can call that either returns=
 the
>>>>> PID so you can do it in user land, or cause the IOCTL code to do =
it in
>>>>> the driver.
>>>>>
>>>>> The same can be done with the affinity of the IRQ if you record t=
he
>>>>> IRQ
>>>>> number.
>>>>>
>>>>> Mark
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-rt-users" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>> But I don't have de PID of my Kthread, I only have the task_struc =
*
>>>> that
>>>> gives me the function:
>>>>
>>>> struct task_struct *kthread_create(int (*threadfn)(void *data),
>>>> void *data,
>>>> const char namefmt[], ...)
>>>>
>>>> How could I get the PID, and which function should I use in the IO=
CTL
>>>> (kernel context) for changing its priority?
>>>>
>>>
>>> The PID can be obtained from within the interrupt handler its self =
via
>>> current->pid.
>>> Obviously an interrupt has to occur first but after one interrupt y=
ou
>>> have it.
>>>
>>> Actually I had forgot how I handled this. Where I change the RT pri=
ority
>>> and cpu affinity is in what used to be called the Bottom Half and t=
he
>>> IOCTL
>>> referred to above simply tells the BH to do it and with what values=
=2E
>>>
>>
>> In interrupt handler code snippet:
>>
>> struct task_struct *TSK;
>> struct sched_param PARAM =3D {.sched_priority =3D MAX_RT_PRIO };
>>
>> TSK =3D current;
>>
>> Code snippet from BH:
>>
>> if (((rtom_rtprio !=3D 0) &&
>> (rtom_rtprio !=3D PARAM.sched_priority)) ||
>> (my_rtom_rtprio[BOARD] !=3D rtom_rtprio)) {
>>
>> PARAM.sched_priority =3D rtom_rtprio;
>> my_rtom_rtprio[COUNT] =3D rtom_rtprio;
>> sched_setscheduler(TSK, SCHED_FIFO, &PARAM);
>>
>> set_cpus_allowed(TSK, rtom_devices[BOARD].irq_cpu_mask);
>> rtom_devices[BOARD].irq_task_pid =3D TSK->pid;
>> }
>>
>> rtom_rtprio and irq_cpu_mask are set by userland via an IOCTL. An
>> interrupt must occur for this to happen and my BOARD never shares IR=
Qs.
>>
>> Mark
>>
>
> Thanks, your idea seems to be very useful to me. I was doing it very
> similar, but I didn't use the "current" variable to know the task_str=
uct *.
>
> I have tried your suggestion on an easy example, but it didn't work.
> Insmod returns through the kernel
>
> [11334.895499] kthread: Unknown symbol sched_setscheduler
>
> Code shown below:
>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/ioport.h>
>
> #include <linux/wait.h>
> #include <linux/kthread.h>
> #include <asm/io.h>
> #include <linux/sched.h>
>
>
> struct task_struct *ts;
>
> int thread(void *data)
> {
> struct task_struct *TSK;
> struct sched_param PARAM =3D {.sched_priority =3D MAX_RT_PRIO };
> TSK =3D current;
>
> PARAM.sched_priority =3D 50;
> sched_setscheduler(TSK, SCHED_FIFO, &PARAM); // <-- unknown symbol??
>
> while(1){
> printk("Hi I am kernel thread!\n");
> msleep(100);
> if (kthread_should_stop())
> break;
> }
> return 0;
> }
>
>
> int init_module(void)
> {
> printk(KERN_INFO "init_module() called\n");
> ts=3Dkthread_run(thread,NULL,"kthread");
> return 0;
> }
>
> void cleanup_module(void)
> {
> printk(KERN_INFO "cleanup_module() called\n");
> kthread_stop(ts);
> }
> .
>

In kernel/sched.c

EXPORT_SYMBOL_GPL(sched_setscheduler);

If your driver is not GPL, you can't use it.

Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
