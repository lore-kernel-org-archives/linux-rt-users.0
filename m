From: Denis Richard <denis.richard@alcatel-lucent.fr>
Subject: Re: SCHED_RR preempted by SCHED_OTHER
Date: Mon, 27 Jul 2009 15:31:34 +0200
Message-ID: <4A6DAC36.3040304@alcatel-lucent.fr>
References: <4A6D962B.20408@alcatel-lucent.fr> <20090727123609.GA26176@pengutronix.de>
Reply-To: denis.richard@alcatel-lucent.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smail6.alcatel.fr ([64.208.49.42]:50158 "EHLO smail6.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbZG0Nbg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 09:31:36 -0400
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail6.alcatel.fr (8.13.8/8.13.8/ICT) with ESMTP id n6RDVYsj028131
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 15:31:35 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id PAA19151
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 15:31:34 +0200 (MET DST)
Received: from [172.25.51.2] (frilln0l015383.emea.lucent.com [172.25.51.2])
	by mail (8.8.8p2+Sun/) with ESMTP id PAA19146
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 15:31:34 +0200 (MET DST)
In-Reply-To: <20090727123609.GA26176@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=F6nig a =E9crit :
> On Mon, Jul 27, 2009 at 01:57:31PM +0200, Denis Richard wrote:
>  =20
>> Hi all,
>> We work on powerpc board with kernel 2.6.29.6-rt23.
>> The kernel is configured with  "Complete Preemption (Real-Time)".
>> Working on our software, we have a strange behavior.
>> A real time thread (SCHED_RR) can be preempted by non real time one =
=20
>> (SCHED_OTHER).
>>
>> We wrote a little test program (at the end of  this mail).
>> This program creates 2 threads, a SCHED_RR one which processes durin=
g =20
>> about 12s
>> (long for a real time, but just for test), and a SCHED_OTHER one, =20
>> started after the first one,
>> which just modifies a global variable. The second one should not run=
 =20
>> during the execution of
>> the first one. But it appends, the global variable is modified.
>>
>>    =20
>>> rr_other
>>>      =20
>> Create thread
>> OTHER ran during RR
>> The end
>>    =20
>> Is it normal, a non real time thread preempts a real time one ? (we =
=20
>> think, it is not)
>> Or is there something wrong in the test program, the kernel =20
>> configuration, ... ?
>>    =20
> Does
>
> 	# echo -1 > /proc/sys/kernel/sched_rt_runtime_us
>
> help?
>  =20
Yes, it solves the problem.
Thanks Uwe.

Regards

Denis
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
