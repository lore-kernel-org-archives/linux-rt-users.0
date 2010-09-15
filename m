From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 07:09:22 -0700
Message-ID: <4C90D392.8040808@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su> <4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com> <4C907A51.1050305@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:60849 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab0IOOJj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 10:09:39 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FE0PmF011131
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:00:25 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8FE9UPQ066018
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:09:31 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8FE9TIZ003346
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 08:09:30 -0600
In-Reply-To: <4C907A51.1050305@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin Steinhoff wrote:

>> Determinism = capping max latencies.
> 
>   Capping max latencies doesn't help without a good real-time, event 
> driven scheduler.
> 
>   But it helps to classify real-time operatings systems as so called 
> hard or soft real-time operating systems.
> 
>   IMHO ... there is a common understanding that a RTOS can be considered 
> as a hard-reatime OS if the
>   max latency is < 15us  because it is able to server 80% (?) of all 
> hard real-time applications in the field.

At some stage this might have been a pretty good response time.
But HW improves by leaps and bounds, and what was considered "fast"
or "real-time" 25 years ago might be your average vanilla desktop
box speed of today.

So, you'd have to define _exactly_ what operation completes
in under 15us? Again, it's these kinds of ambiguities that make
this a very woollen and fuzzy way to talk about subjects and needs
which are usually very precise and critical.

If your OS can support sub-us response times for some required
operation, I expect you wnat to say that, rather than a generic
"hard RT".


>   All others are considered as soft real-time operating systems. From 
> this point of view is PREEMPT_RT Linux
>   a hard real-time OS ... if the hardware base is appropriate.

Right. Regardless of what you call it, I would want the user to
understand very clearly what the OS is capable of, and what it
is not. And whether that meets their application's needs or not.

>   BTW ... we use PREEMPT_RT Linux  as a base for our commercial 
> solft-PLC called DACHSview: http://steinhoff-automation.com/Programming.htm

Very interesting! Thanks for sharing that...

thanks,
Nivedita
