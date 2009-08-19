From: "Bo Hansen" <bh@newtec.dk>
Subject: Re[2]: hrtimer problem on AT91RM9200
Date: Wed, 19 Aug 2009 18:40:28 +0200
Message-ID: <e420e28bcde8a6aa151902eb0f798c63@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "rt-users" <linux-rt-users@vger.kernel.org>
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail03.dandomain.dk ([194.150.112.203]:4074 "EHLO
	mail03.dandomain.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZHSQws (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Aug 2009 12:52:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi Remy,


> -----Original Besked----- 
> Fra: Remy Bohmer <linux@bohmer.net> 
> Til: Bo Hansen <bh@newtec.dk> 
> Cc: rt-users <linux-rt-users@vger.kernel.org> 
> Dato: 19-08-2009 17:33 
> Emne: Re: hrtimer problem on AT91RM9200 
> 
> Hi Bo,
> 
> > I have tested with different options and the only one making a
> > difference is disabling high resolution timers. Whenever this is disabled
> > (RT patch or not) the system does not panic. This of course does not
> > make the latency as good as I would like it to be.
> 
> Reading this I guess you want a timer accuracy better than about 1
> millisecond on this processor.(at91rm9200)
> Setting the CONFIG_HZ to 1000 and disabling HRT would give you about 1
> millisecond accuracy.
> But, timers in the order of 1 millisecond magnitude can easily have an
> system (interrupt+softirqs) overhead up to 250us while using HRT on
> this processor.
> So, if you want sub-millisecond timers, then to me it seems that
> things are somewhat out of balance here.
> 

I actually only want an accurate 10ms periodic time. If possible it would be 
nice with 1ms or even submillisecond in rare circumstances, but I know we 
are kind of limited with this CPU. 
CONFIG_HZ is set to 128, but there seems to be quite some jitter
e.g. on the execution of a thread based on the ordinary timers. That's why
I turned to HRT to get the periodic time correct. But maybe I should try
setting CONFIG_HZ to 1000 and set the timer to 10 jiffies in stead.


> But, If you want an accurate period time for your realtime
> application, you can also use the TC-library to provide you a periodic
> interrupt on which you schedule your RT-task.
> This will provide you much better latencies, and a much lower CPU-load.

The Timer counter library sounds interesting - I previously took a look
at the source, but I miss some examples of how to use it. Do you know
anywhere I can find some beside tcb_clksrc.c?
Correct me if I'm wrong but using TC you still have the RT patch applied,
but just disabled HRT/dynticks? 
Do you have any idea of the overhead of TC@1ms compared with 
CONFIG_HZ=1000?

> 
> > A kernel panic from both an RT and non-RT kernel with high resolution
> > timer has been attached. The source seems to vary from time to time.
> >
> > I noticed than when I stress the system I sometimes get the
> > following message:
> > hrtimer: interrupt too slow, forcing clock min delta to 52482 ns
> 
> This is exactly what I would expect, except that these 52us is still
> quite fast for this processor...
> 
> > And often (but no always) the system panics a little while later. I guess
> > it tells the system is too busy? but should it really end in a kernel
> > panic? Using the RT patch I understand as we can set the priority
> > as we like and stall the system completely, but on a non-RT kernel this
> > should not be possible?
> 
> But anyway, it should not panic...
> 
> Kind regards,
> 
> Remy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards,
Bo

