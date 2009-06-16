From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Tue, 16 Jun 2009 16:45:40 +0200
Message-ID: <4A37B014.4040104@albentia.com>
References: <4A35171C.9090800@albentia.com>	 <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>	 <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>	 <4A365CCF.2020707@albentia.com> <8e6b7a710906160101x6a8ae9d5qa7638627f513278@mail.gmail.com> <4A376450.5020209@albentia.com> <4A376559.5060604@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	=?ISO-8859-1?Q?Noeli?= =?ISO-8859-1?Q?a_Mor=F3n?=
	<nmoron@albentia.com>,
	'Rodrigo Partearroyo' <rpartearroyo@albentia.com>,
	Iratxo Pichel Ortiz <ipichel@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsc497-a04.servidoresdns.net ([82.223.190.48]:55682 "EHLO
	llsc497-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376AbZFPOpm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 10:45:42 -0400
In-Reply-To: <4A376559.5060604@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Please find below more detailed infor regarding this "NOHZ:=20
local_softirq_pending".

Iratxo Pichel Ortiz wrote:
> Thomas,
>
> More info below, I hope it helps.
>
> Iratxo Pichel Ortiz wrote:
>> Thomas,
>>
>> Iratxo Pichel Ortiz wrote:
>>
>>>> Do you know what could be causing this issue. I have managed to=20
>>>> repeat this
>>>> traces (NOHZ...) without using my code, using a workqueue and in=20
>>>> the work
>>>> just by doing something like:
>>>>
>>>> work_func() {
>>>>   mdelay(10);
>>>>   msleep(10);
>>>>
>>>>  queue_work(myqueue, mywork);
>>>> }
>>>>
>>>> And then by heavy loading the box from the outside.
>>>>    =20
>> I have written a very small module that causes the
>> "local_softirq_pending" under not some load. Please find code at the=
 end
>> of this email. Here is pasted some traces of dmesg (I have increased=
 the
>> ratelimit of the "NOHZ: local..." trace to 250.
>>
>> The only strange thing here is that I am calling "set_workqueue_prio=
" (I
>> have hacked source to export this symbol), and I am starting to thin=
k
>> that this could not be a good idea. Any hints about this?
>>
>> [  648.954000] NOHZ: local_softirq_pending
>> 0e
>>
>> [  648.955000] NOHZ: local_softirq_pending
>> 0e
>>
>> [  648.956000] NOHZ: local_softirq_pending
>> 0e
> I have changed the implementation of the module test to use kthreads
> instead of workqueues. The behavior is exactly the same. I have tried
> with prios from 1 to 99. Please find the code below as before. I have
> also atached the differente softirqs codes that had been pending in s=
ome
> of the tests.
I have even tried this without any system-loader module. Just by bootin=
g=20
the kernel and pinging the box very heavily, there are a lot of NOHZ...=
=20
traces in dmesg. Indeed they follow a very strange pattern that I canno=
t=20
match without any part of the kernel. The pattern is the following (NOH=
Z=20
and HZ=3D1000):
[4294715.247000] NOHZ: local_softirq_pending=20
06                                             =20
[4294715.248000] NOHZ: local_softirq_pending=20
06                                             =20
[4294715.249000] NOHZ: local_softirq_pending=20
06                                             =20
=2E.. It repeats every jiffy ...                                     =20
[4294715.290000] NOHZ: local_softirq_pending=20
06                                             =20
[4294715.291000] NOHZ: local_softirq_pending=20
06                                             =20
[4294715.292000] NOHZ: local_softirq_pending 06     =20

And then back again at some seconds later:
[4294723.246000] NOHZ: local_softirq_pending=20
0e                                             =20
[4294723.246000] NOHZ: local_softirq_pending=20
0e                                             =20
[4294723.247000] NOHZ: local_softirq_pending=20
0e                                             =20
=2E.. It repeats every jiffy ...=20
                                                            =20
[4294723.293000] NOHZ: local_softirq_pending=20
10e                                            =20
[4294723.294000] NOHZ: local_softirq_pending=20
10e                                            =20
[4294723.295000] NOHZ: local_softirq_pending 10e      =20

The patter always starts about X.246/X.248 and always stops at X.295, s=
o=20
I believe that this points to some subsystem, but dont know where to=20
look for.

So it seems that my "RT" tasks is delayed, as you said in your original=
=20
mail, when the 02 SIRQ is delayed, but the rest of the time is correctl=
y=20
running. This problem appears to be a Kernel or RT patch issue, so=20
please let me know which tests would you like me to do, I have a couple=
=20
of boxes here and some time to build and test kernels. Alternatively, i=
f=20
you would like me to look at any part of the system, let me know and I=20
will try my best.

>>
>>
>>>>> Does it work when you disable CONFIG_NOHZ ?
>>>>>      =20
>> Still pending to test.
>>>> I will try this and let the list know.
>>>>  =20
>>>>> Thanks,
>>>>>
>>>>>        tglx
>>>>>    =20
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
