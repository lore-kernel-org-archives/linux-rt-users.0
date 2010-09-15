From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 09:48:33 +0200
Message-ID: <4C907A51.1050305@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su> <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64294 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0IOHqy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 03:46:54 -0400
In-Reply-To: <4C8FF52E.1030407@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Nivedita Singhvi wrote:
> On 09/14/2010 07:49 AM, Jeff Angielski wrote:
>
>>> Isn't any case where preempt-rt does not behave as hard reatlime a 
>>> bug in
>>> preempt-rt, that should be reported to this list and eventually fixed?
>>
>> That is a philosophical question for the preempt-rt maintainers.
>>
>> I *believe* that the design goal for the preempt rt code is to minimize
>> kernel latency. It's not to make the kernel deterministic to support
>> hard realtime.
>
> Er, sort of, not quite.
>
> The design goal of the real-time kernel is most certainly to make the
> kernel more deterministic, to the extent we can in a general-purpose way.
>
> Determinism = capping max latencies.

   Capping max latencies doesn't help without a good real-time, event 
driven scheduler.

   But it helps to classify real-time operatings systems as so called 
hard or soft real-time operating systems.

   IMHO ... there is a common understanding that a RTOS can be 
considered as a hard-reatime OS if the
   max latency is < 15us  because it is able to server 80% (?) of all 
hard real-time applications in the field.
   All others are considered as soft real-time operating systems. From 
this point of view is PREEMPT_RT Linux
   a hard real-time OS ... if the hardware base is appropriate.

   BTW ... we use PREEMPT_RT Linux  as a base for our commercial 
solft-PLC called DACHSview: http://steinhoff-automation.com/Programming.htm

>
> It's better to have all hundred iterations of an operation take
> 45us each than to have 95 iterations take 30us and 5 iterations
> take 75us. You want to be able to say, "this operation will take
> at _most_ 50us" and have that be as true as possible.

   All these numbers have no meaning if you don't specify the hardware 
environment.

   --Armin

   http://www.steinhoff-automation.com



>
> We sacrifice overall throughput (ave latency) for determinism
> (low max latency).
>
> Not sure if that's what you intended to say, but hope that helps.
>
> thanks,
> Nivedita
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

