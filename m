From: Reagan Thomas <thomasraz@gmail.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 12:29:00 -0500
Message-ID: <4C91025C.6050503@gmail.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com> <201009151059.23039.klaas.van.gend@mvista.com> <4C90D225.1080902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63617 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0IOR3F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 13:29:05 -0400
Received: by iwn5 with SMTP id 5so282731iwn.19
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:29:04 -0700 (PDT)
In-Reply-To: <4C90D225.1080902@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  On 9/15/2010 9:03 AM, Nivedita Singhvi wrote:
> Klaas van Gend wrote:
>> On Wednesday 15 September 2010 05:38:49 jordan wrote:
>>> Which leads me to my last example. Most people are aware that since
>>> about 1999-2000, Linux has dominated the movie industry. Beginning
>>> with Titanic and even today with say, Avatar.
>>>
>>> I would be willing to bet, that all of those wonderful rendering farms
>>> and production suites, are
>>> in fact using rt-linux.
>>
>>
>> Please put a lot of money on that bet, because I'd like to win it :-)
>>
>> Why would those rendering farms use rt-linux?
>>
>> Rendering is not done in real-time - far from it actually. It can 
>> take minutes of the entire farm to render a single frame. So 
>> rendering is nothing but CPU-
>> intensive (calculating how all those lightbeams are reflected by each 
>> surface) - and everything I/O bound is about throughput: writing the 
>> rendered pixels to disk and getting more surfaces from disk.
>>
>> There are no deadlines for rendering, there are no penalties if a 
>> frame is late by seconds - if the farm cannot complete its job 
>> overnight, they'll add more CPU power.
>
> While all of the above is true, I'll add that it's worth testing
> RT because certain applications which have lock-step operations,
> can be very negatively impacted in throughput by severe lack of
> determinism.  If all of a set of operations need to complete before
> they can do the next set of operations, and one of the threads takes
> very long, the others all idle as a result. If this happens frequently,
> you're better off trying to cap max latencies.
>
> So RT actually provides improved *throughput* as well, despite the
> increased overhead.
>
> I don't know if these rendering type applications necessarily
> fall into that bucket, but I would at least take a look.
>
>
> thanks,
> Nivedita 

I haven't messed with rendering much since the Amiga days, but my 
understanding is that a given CPU could render anywhere from just a 
single pixel to entire frames independent of the work on any other 
processor.  Raw CPU, cache hits and fast memory win.  High bus/network 
bandwidth and storage sweep up the pieces. I would try to use the 
lightest kernel I could get by with, boot from network and run from RAM 
with only the services necessary to get scene info in and rendered 
pixels out.  In my mind, a render box should be single purposed with few 
competing processes. I suspect that determinism is much less important 
than efficiency here.

Then again, it may still be cheaper to "add more CPU" than to give more 
than cursory attention to the kernel or OS.  It may be the case where 
Linux or *BSD have been used in render farms because of license cost, 
not for any particular technical merit!

/ducks

-Reagan
