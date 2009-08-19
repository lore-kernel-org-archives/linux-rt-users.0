From: Remy Bohmer <linux@bohmer.net>
Subject: Re: hrtimer problem on AT91RM9200
Date: Wed, 19 Aug 2009 17:33:51 +0200
Message-ID: <3efb10970908190833o5f8896cbm1989510022f1e1@mail.gmail.com>
References: <4A8BEF09.2080300@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35658 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZHSPdv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Aug 2009 11:33:51 -0400
Received: by bwz19 with SMTP id 19so4836063bwz.37
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Aug 2009 08:33:52 -0700 (PDT)
In-Reply-To: <4A8BEF09.2080300@newtec.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Bo,

> I have tested with different options and the only one making a
> difference is disabling high resolution timers. Whenever this is disabled
> (RT patch or not) the system does not panic. This of course does not
> make the latency as good as I would like it to be.

Reading this I guess you want a timer accuracy better than about 1
millisecond on this processor.(at91rm9200)
Setting the CONFIG_HZ to 1000 and disabling HRT would give you about 1
millisecond accuracy.
But, timers in the order of 1 millisecond magnitude can easily have an
system (interrupt+softirqs) overhead up to 250us while using HRT on
this processor.
So, if you want sub-millisecond timers, then to me it seems that
things are somewhat out of balance here.

But, If you want an accurate period time for your realtime
application, you can also use the TC-library to provide you a periodic
interrupt on which you schedule your RT-task.
This will provide you much better latencies, and a much lower CPU-load.

> A kernel panic from both an RT and non-RT kernel with high resolution
> timer has been attached. The source seems to vary from time to time.
>
> I noticed than when I stress the system I sometimes get the
> following message:
> hrtimer: interrupt too slow, forcing clock min delta to 52482 ns

This is exactly what I would expect, except that these 52us is still
quite fast for this processor...

> And often (but no always) the system panics a little while later. I guess
> it tells the system is too busy? but should it really end in a kernel
> panic? Using the RT patch I understand as we can set the priority
> as we like and stall the system completely, but on a non-RT kernel this
> should not be possible?

But anyway, it should not panic...

Kind regards,

Remy
