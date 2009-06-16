From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending - More info without need for specific
 code.
Date: Tue, 16 Jun 2009 10:26:18 +0200
Message-ID: <4A37572A.7040107@albentia.com>
References: <4A35171C.9090800@albentia.com>	 <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>	 <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>	 <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Iratxo Pichel Ortiz <iratxo.pichel@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsc497-a04.servidoresdns.net ([82.223.190.48]:52092 "EHLO
	llsc497-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753005AbZFPI0V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 04:26:21 -0400
In-Reply-To: <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Iratxo Pichel Ortiz wrote:
>>>  2.6.29-rt16, right ?
>>>      =20
>> I have also tried rt18, but as I had thought seeing change-logs, the
>> behavior is exactly the same.
>>    =20
You were right here :) It was 29.
>> Do you know what could be causing this issue. I have managed to repe=
at this
>> traces (NOHZ...) without using my code, using a workqueue and in the=
 work
>> just by doing something like:
>>
>> work_func() {
>>   mdelay(10);
>>   msleep(10);
>>
>>  queue_work(myqueue, mywork);
>> }
>>
>> And then by heavy loading the box from the outside.
>>    =20
I have written a very small module that causes the=20
"local_softirq_pending" under not some load. Please find code at the en=
d=20
of this email. Here is pasted some traces of dmesg (I have increased th=
e=20
ratelimit of the "NOHZ: local..." trace to 250.

The only strange thing here is that I am calling "set_workqueue_prio" (=
I=20
have hacked source to export this symbol), and I am starting to think=20
that this could not be a good idea. Any hints about this?

[  648.954000] NOHZ: local_softirq_pending=20
0e                                                                     =
                                              =20

[  648.955000] NOHZ: local_softirq_pending=20
0e                                                                     =
                                              =20

[  648.956000] NOHZ: local_softirq_pending=20
0e                                                                     =
                                              =20

  =20
>>> Does it work when you disable CONFIG_NOHZ ?
>>>      =20
Still pending to test.
>> I will try this and let the list know.
>>    =20
>>> Thanks,
>>>
>>>        tglx
>>>      =20
#include <linux/module.h>
#include <linux/workqueue.h>
#include <linux/sched.h>
#include <linux/delay.h>

#define LATENCY_PRIO        98

static struct workqueue_struct* wq;
static struct work_struct        w;

void LatencyzerWork(struct work_struct* work)
{
    static int count;

    /* Busy and normal waiting */
    mdelay(10);
    msleep(1);

    /* Requeue work */
    if(count++ < 400000)
        queue_work(wq, &w);
    else
        printk("LAT: Count reached %d, stopped latencying\n", count);
}

int __init LatencyzerInit(void)
{
    /* Prepare workqueue */
    printk("LAT: Initializing latencyzer\n");
    if(!(wq =3D create_singlethread_workqueue("LATENCY"))) {
        printk("LAT: Error creating task\n");
        return -1;
    }

    /* Change workqueue prio */
    set_workqueue_prio(wq, SCHED_FIFO, LATENCY_PRIO, 1);
    printk("LAT: Task prio set to %u\n", LATENCY_PRIO);

    /* Run first iteration */
    INIT_WORK(&w, LatencyzerWork);
    queue_work(wq, &w);
    return 0;
}

void __exit LatencyzerExit(void)
{
    printk("Latencyzer exiting...\n");

    /* Done here */
    cancel_work_sync(&w);
    destroy_workqueue(wq);

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
