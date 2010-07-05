From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: fast interprocess communication ?
Date: Mon, 05 Jul 2010 18:48:49 +0200
Message-ID: <4C320CF1.7080803@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>	<1273680443.27703.33.camel@gandalf.stny.rr.com>	<4BEBB1C8.90606@steinhoff.de>	<20100513175842.GN6055@pengutronix.de>	<4BED1937.6080907@steinhoff.de>	<20100514114625.GA6055@pengutronix.de>	<4C2B2BA0.8080108@steinhoff.de> <AANLkTikM-AhROT6GJULLhzNZUVfdFEGt6VoZHC-86wEf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55091 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0GEQpx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Jul 2010 12:45:53 -0400
In-Reply-To: <AANLkTikM-AhROT6GJULLhzNZUVfdFEGt6VoZHC-86wEf@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Prady,

Pradyumna Sampath wrote:
> Hi Armin,
>
> On Wed, Jun 30, 2010 at 1:33 PM, Armin Steinhoff <armin@steinhoff.de> wrote:
>
>   
>> what are you using if you need a "real fast"  interprocess communication ?
>>     
>
> Does the posix mqueue's not fit your need ? 

The mqueue system is based on the file system and isn't the fastest.
The concept of mqueue is OK ...

> Have you tried them ? Do
> have some kind of numbers about your definition of fast ?
>   

Local message exchange between lokal processes in less than 10us.

> For me, the POSIX mqueues seemed to work, though with some initial
> trouble which was fixed with a patch to the kernel follow this thread
> ( http://lkml.org/lkml/2010/4/2/293 ) , this patch is now queued for
> mainline inclusion for 2.6.35.
>
> There is also a new test suite to measure message queue perf in the
> rt-tests. Its called pmqtest.
>   

Interesting ... I will give it a try.

I plan do some conceptual work for a UIO based message passing solution.
It should be possible to use read and write (triggering 
uio_event_notify() ) and a UIO device memory to implement a non-copy 
data exchange.

Regards

--Armin


