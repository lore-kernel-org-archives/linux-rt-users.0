From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 14:32:22 +0200
Message-ID: <4BED42D6.3090303@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de> <20100514114625.GA6055@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64748 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757792Ab0ENNVU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 09:21:20 -0400
In-Reply-To: <20100514114625.GA6055@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> On Fri, May 14, 2010 at 11:34:47AM +0200, Armin Steinhoff wrote:
>   
>>> The Linux CAN interface is SocketCAN. Do you see a usecase where
>>> this doesn't fit?
>>>       
>> IMHO, the SocketCAN interface is simply an overkill for the handling
>> of small CAN messages. I estimate that the amount of executed code
>> for handling of a single CAN frame is much bigger as the frame itself
>> :) Every read and write action creates context switches ...
>>
>> This is not the case with the user space based driver. Same story
>> with our PROFIBUS-DP drivers ...
>>     
>
> Do you see a use case which shows that a reasonably modern CPU has
> performance problems with SocketCAN, while it works fine with your
> userspace driver? My impression from previous projects is that, for all
> real life scenarios, the advantage of having a standard hardware
> abstraction in the kernel 

How many "hardware abstractions" do you want in the kernel ?

>>> Realtime != fast.
>>>       
>> But a small response time is a technological requirement in order to
>> meet deadlines. The standard kernel is a _good base_ in order to
>> implement predictive behavior ... this would not the case if the
>> response time would be in the range of 100us. OK ... you can have
>> real-time behavior with a response time of 100us .. but this would be
>> useless for most real-time applications.
>>     
>
> Above you state that you send "1000 frames per second", but that has
> nothing to do with response times. 

The response time of the whole real-time application 
(hardware/driver/application) is the point.
If Linux wouldn't able to handle every 100us a CAN frame ... the whole 
real-time application would be useless.

> Sending lots of frames works also if
> you have for example a CAN chip with a long FIFO, push the frames in and
> wait forever.

But every so called "long FIFO" is limited and can reach the overun state.

>  "Repsonse time" does involve some kind of round trip,
> which one do you mean? 

Responses of an real-time application to external events ...

> Can you elaborate where you see the need for us
> response times?
>
> As the minimum reaction time is limited by hardware constraints on
> modern cpus anyway, I think that for most applications which require sub
> 100 us response times, a hardware solution (microcontroller, fpga) is a
> better way to achive things.
>   

Why should we use FPGAs when a CPU has multiple cores ?
Every fast fieldbus ( e.g. EtherCAT) needs a reaction time with less 
than 100us.

--Armin

---
Armin Steinhoff   <as@Steinhoff-Automation.com> 
STEINHOFF Automation &  Fieldbus-Systems
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TEL +49-6431 -529366  or  -570 99 70
FAX +49-6431 - 57454  or  -570 99 80
http://www.steinhoff-automation.com

