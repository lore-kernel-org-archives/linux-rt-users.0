From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 16:56:23 +0200
Message-ID: <4C8F8D17.2090004@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeff Angielski <jeff@theptrgroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54140 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab0INOyi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 10:54:38 -0400
In-Reply-To: <4C8F8500.5070002@theptrgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Jeff Angielski wrote:
> On 09/14/2010 05:44 AM, Robert Schwebel wrote:
>> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>>> anyone can say preempt rt is hard real time?
>>
>> Hard realtime has something to do with how you define "missing the
>> deadline". If somebody cuts the cable of your roboter controller in the
>> factory hall, the system misses the deadline. So it is all about
>> probabilities: hard realtime systems have a very, very low probability
>> of missing the deadline. However, in real life systems, it is>  0%.
>>
>> So yes, if you talk about real world, it is hard realtime.
>
> No.  Preempt rt it's not hard realtime.

   True. But show me a single RTOS which provides a real "hard 
real-time" operation.  They all suffer by the SMI functions, cache 
problems or other
   resource constrains at hardware level ... specially when they run on 
x86 hardware.

>
> But most people/companies who think they need hard realtime really don't.

  Missing a deadline by 5us is not a problem for most control 
applications ... e.g. the fastes bus cycle of Profinet is today 250us.

>   They can live with soft realtime and have a really low probability 
> of missing deadlines and having long latencies.  For these people, the 
> preempt rt is adequate

   Yes, more important is an extended range of priorities (up to 99) and 
a clean event oriented real-time scheduling.

   What we really don't need is the dual kernel concept of RT-LINUX :)

--Armin





