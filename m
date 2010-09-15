From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 09:02:46 -0700
Message-ID: <4C90EE26.8060003@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de>	<4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su>	<4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>	<4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com> <87k4mnhv9h.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Kastrup <dak@gnu.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:50412 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561Ab0IOQEd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 12:04:33 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FFjuYu017904
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 11:45:56 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8FG4WhW470372
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 12:04:32 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8FG4VGK025154
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 10:04:31 -0600
In-Reply-To: <87k4mnhv9h.fsf@lola.goethe.zz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David Kastrup wrote:
> Nivedita Singhvi <niv@us.ibm.com> writes:
> 
>> At some stage this might have been a pretty good response time.  But
>> HW improves by leaps and bounds, and what was considered "fast" or
>> "real-time" 25 years ago might be your average vanilla desktop box
>> speed of today.
> 
> I think you are confused.  "fast" and "realtime" are quite unrelated.

Sorry, yes, I know, but was sloppy. And because the whole point
of this thread was to make exactly these things clear, I'll add to
this already monstrously long thread. That was the point of the "or",
that if you have a faster system by several orders of magnititude, you
can effectively put together a box that will meet some application's
"hard" deadlines (which would not have been possible before). As others
commented before in this thread, failing the deadline becomes very,
very, very low probability.

> The computers used aboard ancient space craft are abysmally slow
> compared to today's desktop computers, but certainly operate in
> realtime.
> 
> It does not matter whether one system can run circles around the other
> one as long as any given circle can't be guaranteed to complete in a
> specified amount of time.

Right -- but the point was, any HW system can fail, too (very, very
low statistically speaking, but still not 0%). So no system is
impervious to all sources of breakage.

> Realtime recording systems, for example, can't actually be writing to
> high performance file systems unless they can work with preallocation.
> 
> Hard realtime is not reasonably possible for a lot of tasks on a general
> purpose computing device.  But there is often a lot you can do to help
> it give a better shot at things.

Yep.

thanks,
Nivedita
