From: Jeff Angielski <jeff@theptrgroup.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 10:49:29 -0400
Message-ID: <4C8F8B79.1010300@theptrgroup.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.theptrgroup.com ([71.178.251.9]:38427 "EHLO
	mail.theptrgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab0INOtd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 10:49:33 -0400
In-Reply-To: <201009141830.03206@zigzag.lvk.cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/14/2010 10:30 AM, Nikita V. Youshchenko wrote:
>>>> anyone can say preempt rt is hard real time?
>>>
>>> Hard realtime has something to do with how you define "missing the
>>> deadline". If somebody cuts the cable of your roboter controller in
>>> the factory hall, the system misses the deadline. So it is all about
>>> probabilities: hard realtime systems have a very, very low probability
>>> of missing the deadline. However, in real life systems, it is>   0%.
>>>
>>> So yes, if you talk about real world, it is hard realtime.
>>
>> No.  Preempt rt it's not hard realtime.
>>
>> But most people/companies who think they need hard realtime really
>> don't.  They can live with soft realtime and have a really low
>> probability of missing deadlines and having long latencies.  For these
>> people, the preempt rt is adequate.
>
> Isn't any case where preempt-rt does not behave as hard reatlime a bug in
> preempt-rt, that should be reported to this list and eventually fixed?

That is a philosophical question for the preempt-rt maintainers.

I *believe* that the design goal for the preempt rt code is to minimize 
kernel latency.  It's not to make the kernel deterministic to support 
hard realtime.

So I don't know if I'd call it a bug, but rather on the wish list for 
future enhancements.

-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
