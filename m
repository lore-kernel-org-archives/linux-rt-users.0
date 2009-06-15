From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: NOHZ: local_softirq_pending
Date: Mon, 15 Jun 2009 16:38:07 +0200
Message-ID: <4A365CCF.2020707@albentia.com>
References: <4A35171C.9090800@albentia.com> <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com> <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Iratxo Pichel Ortiz <iratxo.pichel@gmail.com>,
	linux-rt-users@vger.kernel.org,
	=?ISO-8859-1?Q?Noelia_Mor=F3n?= <nmoron@albentia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsd410-a04.servidoresdns.net ([82.223.190.35]:47715 "EHLO
	llsd410-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbZFOOiI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2009 10:38:08 -0400
In-Reply-To: <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Thomas Gleixner wrote:
> Iratxo,
>
> please do not top post.
>  =20
Thanks for you answer and sorry for my top-posting.
>   2.6.29-rt16, right ?
>  =20
I have also tried rt18, but as I had thought seeing change-logs, the=20
behavior is exactly the same.
>
> Hmm, so something is marking the timer softirq pending, but does not
> wake the timer softirq.
>
>  =20
>>> [42949422.940000] NOHZ: local_softirq_pending 02
>>> [42949422.950000] NOHZ: local_softirq_pending 02
>>> [42949422.960000] ISR HIHG LATENCY 30073
>>> [42949596.920000] NOHZ: local_softirq_pending 02
>>> [42949596.930000] NOHZ: local_softirq_pending 02
>>> [42949596.940000] NOHZ: local_softirq_pending 02
>>> [42949596.950000] NOHZ: local_softirq_pending 02
>>>      =20
>
> So this repeats itself roughly every 3min and stays that way for a
> couple of jiffies. Does your code fiddle with timers ?
>
>  =20

There are some timers in the system, but I believe that those are quite=
=20
out of the main path, but there could be some problem with delayed=20
works, as they use also timers there.

And, well, I have managed to avoid this 180s dependency, and make it=20
happen only under very heavy load. To do do this I have changed HZ from=
=20
100 to 1000. Once I do this the problem arises only when the load, for=20
example heavy pinging the ethernet interface.
>>> [42949596.960000] ISR HIHG LATENCY 40066
>>>      =20
>
> The latency is exaclty the number of NOHZ messages * 10ms. I assume
> you have HZ=3D100. Looks like your code is waiting for a timer, which
> does not fire due to the local_softirq_pending 02 problem.
>  =20
You are right, I hadn't noticed this. This pattern also repeats with HZ=
=20
1000, (see dmesg excerpt below), but I only see the first 10 NOHZ=20
because of the ratelimit in that function. Is this right? At least the=20
time in the printks summed all-together sum up the aprox 50msec delay.=20
In this case is not the ISR that gets delayed, but a RT task, it depend=
s=20
on the moment.

[4294750.246000] NOHZ: local_softirq_pending 06
[4294750.246000] NOHZ: local_softirq_pending 06
[4294750.247000] NOHZ: local_softirq_pending 06
[4294750.248000] NOHZ: local_softirq_pending 06
[4294750.249000] NOHZ: local_softirq_pending 06
[4294750.250000] NOHZ: local_softirq_pending 06
[4294750.251000] NOHZ: local_softirq_pending 06
[4294750.252000] NOHZ: local_softirq_pending 06
[4294750.253000] NOHZ: local_softirq_pending 06
[4294750.254000] NOHZ: local_softirq_pending 06
[4294750.296000] SCHED Max time reached 51368
[4294750.296000] SCHED Hi time reached 51368

Do you know what could be causing this issue. I have managed to repeat=20
this traces (NOHZ...) without using my code, using a workqueue and in=20
the work just by doing something like:

work_func() {
    mdelay(10);
    msleep(10);

   queue_work(myqueue, mywork);
}

And then by heavy loading the box from the outside.
> Does it work when you disable CONFIG_NOHZ ?
>  =20
I will try this and let the list know.
> Thanks,
>
> 	tglx
>
>  =20
Thanks a really lot.

BR,

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
