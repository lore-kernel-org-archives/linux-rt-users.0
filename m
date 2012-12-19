From: John Stultz <john.stultz@linaro.org>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Wed, 19 Dec 2012 12:57:37 -0800
Message-ID: <50D22A41.2070503@linaro.org>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com> <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52643 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2LSVDj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 16:03:39 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so3595900ieb.31
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Dec 2012 13:03:39 -0800 (PST)
In-Reply-To: <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/19/2012 12:43 PM, Scot Salmon wrote:
> John Stultz wrote on 11/15/2012 02:53:56 PM:
>> On 11/15/2012 11:28 AM, Scot Salmon wrote:
>>> Thomas Gleixner wrote on 10/31/2012 03:08:45 PM:
>>>> What you are concerned about is keeping the machines in sync on a
>>>> common global timeline. Though your more fundamental requirement is
>>>> that you get the wakeup on each machine in the given cycle time. The
>>>> global synchronization mechanism just adjusts that local periodic
>>>> schedule.
>>> [...]
>>>> What you really want is an atomic readout facility for
>>>> CLOCK_MONOTONIC and CLOCK_REALTIME. That allows you to align the
>>>> CLOCK_MONOTONIC based timer with the global CLOCK_REALTIME based
>>>> time line and in the event that the CLOCK_REALTIME clock was set
>>>> and jumped forward/backward you have full software control over
>>>> the aligning mechanism including the ability to do sanity checking.
>>> This works for me.  We discussed it on IRC and agreed on "something
>>> like clock_gettime2(id, id, *t1, *t2) with a sanity check on the ids,
>>> that allows us other combinations than MONO/REAL as well".
>> Yea, there's been a few times that folks have brought up the need, and
>> this sort of interface is probably the best way to go.
> I spent a few days working on clock_gettime2 this week, and I've hit a
> snag.  I tried an implementation where I look up the two kclocks from
> their clockid and call kc1->clock_get() and kc2->clock_get() with the
> timekeeping data locked.  The problem is, if id1 and id2 are the obvious
> choices of MONO and REAL, their clock_get's end up calling
> timekeeping_get_ns which samples the clock source synchronously, so I
> get two discrete samples of the underlying clock even if I have locked
> out any changes to the timekeeping data.
>
> This implementation does work for the _COARSE clockid variants, but it
> seems from some quick checks that those aren't going to be suitable for
> my needs (too coarse).
>
> Since there's nothing I can do to keep the underlying hardware clock
> source from ticking, it seems like my options are pretty limited.  I
> can't do anything that will lead to two samples of the clock source.
> All I can think of is to sample it for the first clockid, then derive
> the value for the second from the first, for example by offsetting a
> CLOCK_MONOTONIC read with tk->offs_real and returning that as the
> synchronized value for CLOCK_REALTIME.  Which isn't incredibly horrible
> for those two, but making it general would get very ugly.
>
> Any thoughts?

Likely this will require some refactoring of the current timekeeping 
accessor functions.

Basically you need to split the current accsessor functions into two parts:
1) The clocksource hardware read
2) The time calculation, given the clocksource value

Then for the gettime2() implementation, do a *single* read of the 
hardware, and pass that clocksource value into the different specified 
clockid functions.

Another important thing to consider here, is that if we are considering 
adding a new syscall, we should avoid the 2038 issue, and specify a new 
time64_t and timespec64 types, and use them in the new interface. This 
way we can provide a 64bit time interface for 32bit systems.

thanks
-john
