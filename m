From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Tue, 16 Jun 2009 20:39:13 +0200
Message-ID: <4A37E6D1.5010207@albentia.com>
References: <4A35171C.9090800@albentia.com>	 <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>	 <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>	 <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com> <4A37B014.4040104@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Noeli?= =?ISO-8859-1?Q?a_Mor=F3n?=
	<nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsd410-a04.servidoresdns.net ([82.223.190.35]:55606 "EHLO
	llsd410-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485AbZFPSjO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 14:39:14 -0400
In-Reply-To: <4A37B014.4040104@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Please find below experiment results of disabling CONFIG_NOHZ.

Iratxo Pichel Ortiz wrote:
> Please find below more detailed infor regarding this "NOHZ:=20
> local_softirq_pending".
>
> Iratxo Pichel Ortiz wrote:
>> Thomas,
>>
>> More info below, I hope it helps.
>>
>> Iratxo Pichel Ortiz wrote:
>>> Thomas,
>>>
>>> Iratxo Pichel Ortiz wrote:
>>>
>>>>> Do you know what could be causing this issue. I have managed to=20
>>>>> repeat this
>>>>> traces (NOHZ...) without using my code, using a workqueue and in=20
>>>>> the work
>>>>> just by doing something like:
>>>>>
>>>>> work_func() {
>>>>>   mdelay(10);
>>>>>   msleep(10);
>>>>>
>>>>>  queue_work(myqueue, mywork);
>>>>> }
>>>>>
>>>>> And then by heavy loading the box from the outside.
>>>>>    =20
>>> I have written a very small module that causes the
>>> "local_softirq_pending" under not some load. Please find code at th=
e=20
>>> end
>>> of this email. Here is pasted some traces of dmesg (I have increase=
d=20
>>> the
>>> ratelimit of the "NOHZ: local..." trace to 250.
>>>
>>> The only strange thing here is that I am calling=20
>>> "set_workqueue_prio" (I
>>> have hacked source to export this symbol), and I am starting to thi=
nk
>>> that this could not be a good idea. Any hints about this?
>>>
>>> [  648.954000] NOHZ: local_softirq_pending
>>> 0e
>>>
>>> [  648.955000] NOHZ: local_softirq_pending
>>> 0e
>>>
>>> [  648.956000] NOHZ: local_softirq_pending
>>> 0e
>> I have changed the implementation of the module test to use kthreads
>> instead of workqueues. The behavior is exactly the same. I have trie=
d
>> with prios from 1 to 99. Please find the code below as before. I hav=
e
>> also atached the differente softirqs codes that had been pending in =
some
>> of the tests.
> I have even tried this without any system-loader module. Just by=20
> booting the kernel and pinging the box very heavily, there are a lot=20
> of NOHZ... traces in dmesg. Indeed they follow a very strange pattern=
=20
> that I cannot match without any part of the kernel. The pattern is th=
e=20
> following (NOHZ and HZ=3D1000):
> [...]
> So it seems that my "RT" tasks is delayed, as you said in your=20
> original mail, when the 02 SIRQ is delayed, but the rest of the time=20
> is correctly running. This problem appears to be a Kernel or RT patch=
=20
> issue, so please let me know which tests would you like me to do, I=20
> have a couple of boxes here and some time to build and test kernels.=20
> Alternatively, if you would like me to look at any part of the system=
,=20
> let me know and I will try my best.
>
>>>
>>>
>>>>>> Does it work when you disable CONFIG_NOHZ ?
>>>>>>      =20
>>> Still pending to test.
I have tried disabling the CONFIG_NOHZ kernel option. Of course the=20
trace is gone, but the weird behavior is still there. When I run my=20
software without load from the network, the main task of the system=20
experiences runtimes of about 700us. When I load the system, there are=20
latencies of 50700us, so the 50ms delay is again there, and again the=20
time when the task finishes is always X.296, 1 jiffy after the "NOHZ:=20
pending..." was shown with CONFIG_NOHZ enabled.

Please let me know what tests would you like me to do.
>>>>> I will try this and let the list know.
>>>>> =20
>>>>>> Thanks,
>>>>>>
>>>>>>        tglx
>>>>>>    =20
> Thanks,
>
>    Iratxo.
>
Thanks,

    Iratxo.



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
