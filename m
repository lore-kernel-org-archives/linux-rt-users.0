From: John Stultz <johnstul@us.ibm.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Thu, 15 Nov 2012 14:25:50 -0800
Message-ID: <50A56BEE.3030001@us.ibm.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <alpine.LFD.2.02.1211152158160.2701@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scot Salmon <scot.salmon@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:58725 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab2KOW00 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2012 17:26:26 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <johnstul@us.ibm.com>;
	Thu, 15 Nov 2012 15:26:26 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EDEED19D8048
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 15:25:54 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qAFMPsoL215146
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 15:25:54 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qAFMPrh8030926
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 15:25:53 -0700
In-Reply-To: <alpine.LFD.2.02.1211152158160.2701@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/15/2012 01:01 PM, Thomas Gleixner wrote:
> On Thu, 15 Nov 2012, John Stultz wrote:
>> On 11/15/2012 11:28 AM, Scot Salmon wrote:
>>> Thomas Gleixner <tglx@linutronix.de> wrote on 10/31/2012 03:08:45 PM:
>>>> What you are concerned about is keeping the machines in sync on a
>>>> common global timeline. Though your more fundamental requirement is
>>>> that you get the wakeup on each machine in the given cycle time. The
>>>> global synchronization mechanism just adjusts that local periodic
>>>> schedule.
>>> [...]
>>>> What you really want is an atomic readout facility for CLOCK_MONOTONIC
>>>> and CLOCK_REALTIME. That allows you to align the CLOCK_MONOTONIC based
>>>> timer with the global CLOCK_REALTIME based time line and in the event
>>>> that the CLOCK_REALTIME clock was set and jumped forward/backward you
>>>> have full software control over the aligning mechanism including the
>>>> ability to do sanity checking.
>>> This works for me.  We discussed it on IRC and agreed on "something
>>> like clock_gettime2(id, id, *t1, *t2) with a sanity check on the ids,
>>> that allows us other combinations than MONO/REAL as well".
>> Yea, there's been a few times that folks have brought up the need, and this
>> sort of interface is probably the best way to go.
>>
>> I suspect clock_gettime3 isn't far behind though :)
> I guess you are talking about MONO/MONORAW/REAL.
Or MONO/BOOT/REAL  or eventually MONO/TAI/REAL, etc..

But there's probably someone out there who will want all kernel state 
exported atomically, and its just not reasonable.

The real problem is that figuring out the relationship between clocks 
has required the three read interpoloation, which isn't something easily 
or quickly done with good accuracy. If we provide clock_gettime2(), that 
will allow the relationship between clockid pairs to be accurately 
determined. And if folks need to calculate the relationship between 
three clockids, they can do a similar three read and bound the output.
ie:
do {
     clock_gettime2(MONO, REAL, mon1,real1);
     clock_gettime2(MONO,BOOT, mon2,boot2);
     clock_gettime2(MONO,REAL, mon3, real3);
} while( real1-mon1 != real3-mon3);

So it might be over-designing to provide a clock_gettime3 from the start 
(since then folks will want clock_gettime5.. :)

>   So if you already
> know about such requirements we should go for that, but we should try
> to restrict it to combinations which can be easily supported in the
> VDSO as well.
Other then the cputime clockids, I'm not sure I see what combinations 
wouldn't work with the vdso.
As long as the clocksource is accessible, everything else is exportable.


thanks
-john

