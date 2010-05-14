From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 18:29:41 +0200
Message-ID: <4BED7A75.9030508@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de> <20100514114625.GA6055@pengutronix.de> <4BED42D6.3090303@steinhoff.de> <20100514163613.GE6055@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab0ENRSh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 13:18:37 -0400
In-Reply-To: <20100514163613.GE6055@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robert Schwebel wrote:
> On Fri, May 14, 2010 at 02:32:22PM +0200, Armin Steinhoff wrote:
>   
>>> Do you see a use case which shows that a reasonably modern CPU has
>>> performance problems with SocketCAN, while it works fine with your
>>> userspace driver? My impression from previous projects is that, for
>>> all real life scenarios, the advantage of having a standard hardware
>>> abstraction in the kernel
>>>       
>> How many "hardware abstractions" do you want in the kernel?
>>     
>
> The kernel policy is to offer only one abstraction model for one sort of
> hardware; SocketCAN is a native Linux implementation and has no
> additional HAL.
>   

And how many different kinds of hardware do we have ??

>> The response time of the whole real-time application
>> (hardware/driver/application) is the point. If Linux wouldn't able to
>> handle every 100us a CAN frame ... the whole real-time application
>> would be useless.
>>     
>
> I still don't understand your setup, can you elaborate?
>   

When you send every 100us a CAN frame  and the response time of the 
real-time application to external  events is 200us ... what would be 
happen ?  Hard to understand ??

>>> Sending lots of frames works also if you have for example a CAN chip
>>> with a long FIFO, push the frames in and wait forever.
>>>       
>> But every so called "long FIFO" is limited and can reach the overun
>> state.
>>     
>
> My point is to find out where you see a relation to "latency". Latency
> has nothing to do with CAN frames per second. 

I never did such a statement ... you are barking on the wrong tree :)

> If you have a FIFO which
> is long enough, feeding it every let's say 1 second with 1k messages is
> enough to get 1k messages/s. So a system latency of 1 s would fulfill
> your throughput requirements.
>   

Well ... and if the latency to receive events is too high (e.g. 2s) ... 
the FIFO  will be overloaded.
That was my initial statement ...

>> Why should we use FPGAs when a CPU has multiple cores? Every fast
>> fieldbus (e.g. EtherCAT) needs a reaction time with less than 100us.
>>     
>
> Reaction time between *which events*? Sorry, I didn't understand your
> use case yet.
>   

Never heard about bus scan cycles ?  In a range of  e.g. 50us ?
Such bus cycles can't be handled with a latency of 100us  ...  isn't it  ?

Cheers

--Armin

PS:  so langsam  wird die Diskussion  nun doch ein wenig albern  ...

