From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Fri, 12 Aug 2016 14:37:35 +0200
Message-ID: <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
 <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jens Koehler <jenskxxx@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57201 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcHLMhi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2016 08:37:38 -0400
Content-Disposition: inline
In-Reply-To: <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-08-12 11:47:31 [+0200], Jens Koehler wrote:
> Hello Sebastian,
Hi Jens,

> During test we noticed the *hrtimer: interrupt took xxxx ns* message
> and got following log.
> 
> >          <idle>-0     [000] d..h2.. 45070.884077: hrtimer_interrupt: entry: 45069158989509
> >          <idle>-0     [000] d..h2.. 45070.884079: hrtimer_cancel: hrtimer=f717fab8
> >          <idle>-0     [000] d..h1.. 45070.884082: hrtimer_expire_entry: hrtimer=f717fab8 function=hrtimer_wakeup now=45069158989509
> >          <idle>-0     [000] d..h2.. 45070.884084: sched_waking: comm=mlmodbus pid=824 prio=120 target_cpu=000
> >          <idle>-0     [000] dN.h3.. 45070.884088: sched_wakeup: comm=mlmodbus pid=824 prio=120 target_cpu=000
> >          <idle>-0     [000] dN.h1.. 45070.884089: hrtimer_expire_exit: hrtimer=f717fab8
> >          <idle>-0     [000] dN.h2.. 45070.884093: hrtimer_cancel: hrtimer=c1653500
> >          <idle>-0     [000] dN.h1.. 45070.884095: hrtimer_expire_entry: hrtimer=c1653500 function=tick_sched_timer now=45069159007328
> >          <idle>-0     [000] dN.h2.. 45070.884105: sched_waking: comm=rcuc/0 pid=14 prio=98 target_cpu=000
> >          <idle>-0     [000] dN.h3.. 45070.884108: sched_wakeup: comm=rcuc/0 pid=14 prio=98 target_cpu=000
> >          <idle>-0     [000] dN.h1.. 45070.884111: hrtimer_expire_exit: hrtimer=c1653500
> >          <idle>-0     [000] dN.h2.. 45070.884113: hrtimer_start: hrtimer=c1653500 function=tick_sched_timer expires=45069160000000 softexpires=45069160000000
> >          <idle>-0     [000] dN.h2.. 45070.884116: hrtimer_cancel: hrtimer=e7923f08
> >          <idle>-0     [000] dN.h1.. 45070.884118: hrtimer_expire_entry: hrtimer=e7923f08 function=hrtimer_wakeup now=45069159031133
> >          <idle>-0     [000] dN.h2.. 45070.884120: sched_waking: comm=PreemptTestApp pid=813 prio=19 target_cpu=000
> >          <idle>-0     [000] dN.h3.. 45070.884122: sched_wakeup: comm=PreempTestApp pid=813 prio=19 target_cpu=000
> >          <idle>-0     [000] dN.h1.. 45070.884124: hrtimer_expire_exit: hrtimer=e7923f08
> >          <idle>-0     [000] dN.h1.. 45070.884137: hrtimer_interrupt: time took: 51718
.000002
.000003
.000002
.000004
.000001
.000004
.000002
.000010
.000003
.000003
.000002
.000003
.000002
.000002
.000002
.000002
.000013
> 
> What could be reason that the timer looped 3 times through the code
> before leaving it?

So we talk here about ~50us. Your initial report was about 9us.
Tracepoint to tracepoint takes approx. 3us except one that needs 10us.
All in all I would say this is okay and you don't have a 3GHz x86 box
here.
You had one timer which expired (hrtimer_wakeup). So you programmed a
new timer via tick_program_event() and this has failed. Probably because
the next event was in the past. This is the second loop where
tick_sched_timer expired. You also failed to program next timer here and
here you have your third loop.
You would have to figure out why programming of the next timer failed.
Maybe min delta is too low. 

> Jens

Sebastian
