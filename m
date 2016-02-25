From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Large latencies with 4.4.1-rt6
Date: Thu, 25 Feb 2016 16:29:30 +0100
Message-ID: <20160225152930.GC16161@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54023 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760202AbcBYP3e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 10:29:34 -0500
Content-Disposition: inline
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Martin.Wirth@dlr.de | 2016-02-19 17:02:20 [+0000]:

>Hi,
Hi,

>I today switched from 4.1.15-rt17 to 4.4.1-rt6.
>Now I'm seeing large latencies of more than 1 ms.
>They occur sporadic ( every few minutes) and show up for example running 
>
>cyclictest -l10000000 -m -Sp99 -i200
>
>I tried to catch a trace and got the following: 
>
>
>   <...>-3709    2d...2..    2us : set_next_entity <-pick_next_task_fair
>   <...>-3709    2d...2..    2us : update_stats_wait_end <-set_next_entity
> firefox-3736    2d...2..    3us : finish_task_switch <-__schedule
> firefox-3736    2d...2..    3us#: _raw_spin_unlock_irq <-finish_task_switch
> firefox-3736    2d...... 1091us : smp_apic_timer_interrupt <-apic_timer_interrupt
> firefox-3736    2d...... 1092us : irq_enter <-smp_apic_timer_interrupt
>Does the above trace ring a bell or is it useless?

This does not ring a bell. According to the trace your CPU took a break
after the unlock until the next interrupt. If this a fucntion trace I
would expect some functions after that.
You could try the v4.4 line as of:
 v4.4-rt2
 v4.4-rt3
 v4.4.1-rt5

to see if I introduced this somewhere by accident. However I haven't seen
this on any of my boxes.

>Thanks,
>
>Martin

Sebastian
