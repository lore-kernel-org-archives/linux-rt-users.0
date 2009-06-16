From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending - More info without need for specific
 code.
Date: Tue, 16 Jun 2009 11:26:49 +0200
Message-ID: <4A376559.5060604@albentia.com>
References: <4A35171C.9090800@albentia.com>	 <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>	 <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>	 <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Iratxo Pichel Ortiz <ipichel@albentia.com>,
	=?ISO-8859-1?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsd409-a04.servidoresdns.net ([82.223.190.34]:50295 "EHLO
	llsd409-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbZFPJ2n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 05:28:43 -0400
In-Reply-To: <4A376450.5020209@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

More info below, I hope it helps.

Iratxo Pichel Ortiz wrote:
> Thomas,
>
> Iratxo Pichel Ortiz wrote:
>>>>  2.6.29-rt16, right ?
>>>>      =20
>>> I have also tried rt18, but as I had thought seeing change-logs, th=
e
>>> behavior is exactly the same.
>>>    =20
> You were right here :) It was 29.
>>> Do you know what could be causing this issue. I have managed to=20
>>> repeat this
>>> traces (NOHZ...) without using my code, using a workqueue and in th=
e=20
>>> work
>>> just by doing something like:
>>>
>>> work_func() {
>>>   mdelay(10);
>>>   msleep(10);
>>>
>>>  queue_work(myqueue, mywork);
>>> }
>>>
>>> And then by heavy loading the box from the outside.
>>>    =20
> I have written a very small module that causes the
> "local_softirq_pending" under not some load. Please find code at the =
end
> of this email. Here is pasted some traces of dmesg (I have increased =
the
> ratelimit of the "NOHZ: local..." trace to 250.
>
> The only strange thing here is that I am calling "set_workqueue_prio"=
 (I
> have hacked source to export this symbol), and I am starting to think
> that this could not be a good idea. Any hints about this?
>
> [  648.954000] NOHZ: local_softirq_pending
> 0e
>
> [  648.955000] NOHZ: local_softirq_pending
> 0e
>
> [  648.956000] NOHZ: local_softirq_pending
> 0e
I have changed the implementation of the module test to use kthreads
instead of workqueues. The behavior is exactly the same. I have tried
with prios from 1 to 99. Please find the code below as before. I have
also atached the differente softirqs codes that had been pending in som=
e
of the tests.
>
>
>>>> Does it work when you disable CONFIG_NOHZ ?
>>>>      =20
> Still pending to test.
>>> I will try this and let the list know.
>>>   =20
>>>> Thanks,
>>>>
>>>>        tglx
>>>>    =20
Thanks a lot again!

    Iratxo.

---- DMESG ----
[4294833.294000] NOHZ: local_softirq_pending
06
[4294833.295000] NOHZ: local_softirq_pending
06
[4294834.246000] NOHZ: local_softirq_pending
02
[4294834.247000] NOHZ: local_softirq_pending
02
[4294834.248000] NOHZ: local_softirq_pending 02

---- Test module code ----

#include <linux/module.h>
#include <linux/kthread.h>
#include <linux/sched.h>
#include <linux/delay.h>

#define LATENCY_PRIO    1

struct task_struct *t;

int LatencyzerWork(void* data)
{
    static int count;

    while(1) {
        /* Busy and normal waiting */
        mdelay(10);
        msleep(1);

    /* Requeue work */
    if(count++ > 400000)
        break;
    }

    printk("LAT: Count reached %d, stopped latencying\n", count);
    return 0;
}

int __init LatencyzerInit(void)
{
    struct sched_param schedp;

    /* Prepare Thread */
    printk("LAT: Initializing latencyzer\n");
    if(!(t =3D kthread_create(LatencyzerWork, NULL, "LATENCY"))) {
        printk("LAT: Error creating thread\n");
        return -1;
    }

    /* Change task prio */
    schedp.sched_priority =3D LATENCY_PRIO;
    sched_setscheduler(t, SCHED_FIFO, &schedp);
    printk("LAT: Task prio set to %u\n", LATENCY_PRIO);

    /* Run thread */
    wake_up_process(t);
    return 0;
}

void __exit LatencyzerExit(void)
{
    printk("LAT: Latencyzer exiting...");

    /* Done here */
    kthread_stop(t);
    printk(" DONE\n");

    return;
}

module_init(LatencyzerInit);
module_exit(LatencyzerExit);
MODULE_LICENSE("GPL");


--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
