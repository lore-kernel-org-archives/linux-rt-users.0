From: Lukasz Majewski <majess1982@gmail.com>
Subject: [RFC][Vortex86] high resolution timer
Date: Sun, 15 May 2011 23:57:24 +0200
Message-ID: <20110515235724.0b4f5216@mig>
References: <4DCD3B43.3060806@greenseainc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Lukasz Majewski <majess1982@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Andy O'Brien <aobrien@greenseainc.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42234 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab1EOV53 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 May 2011 17:57:29 -0400
Received: by eyx24 with SMTP id 24so1106293eyx.19
        for <linux-rt-users@vger.kernel.org>; Sun, 15 May 2011 14:57:28 -0700 (PDT)
In-Reply-To: <4DCD3B43.3060806@greenseainc.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 13 May 2011 10:08:03 -0400
Andy O'Brien <aobrien@greenseainc.com> wrote:

> Lukasz,
> 
> Have you made any headway on supporting the Vortex86's high
> resolution timer?  I'm in the same boat and would very much like to
> support it.
> 
> Are you still planning on implementing support for the other counter? 
> Perhaps we could work together?
> 
> Best,
> Andy
> 

Hi Andy,

The support for the High Resolution Timers on the Vortex86DX shall be
considered as work in progress.

Firstly, I've looked into the "struct clocksource" and try to understand
Vortex's internals:

1. One i8254 timer (0x40 - 0x43) is used by PIT. It has a hardcoded
frequency of 1.19MHz. It is NOT suitable for any "real-time" control
control application (rounding problem and relatively low frequency).

2. Another i8254 timer is the PWM timer (0x44 - 0x48). A programmer
can change the frequency of this timer (IO pins are muxed with COM2). 
So it is possible to connect e.g. 20MHz external oscillator and
provide very stable clock source.

3. TSC - Time Stamp Counter (one of vortex86 features - as seen on
the cat /proc/cpuinfo) allows for reading the internal chip counter
via an assembler instruction - RDTSC (rdtscll). It works on
vortex86DX and it seems, that this timer value is incremented with
each clock tick provided to CPU (e.g. 500MHz). Therefore it is a
preferred clock source for Vortex86 board.

It would be desirable to use this as clocksource with the "struct
hrtimer_cpu_base.clock_base".

I was studying the presentation:
http://www.kernel.org/pub/linux/kernel/people/tglx/hrtimers/ols2006-hrtimers.pdf

And try to "link" the slide 22 with the kernel source (I'm using
2.6.33.7.2-rt30).

In my opinion it is better to use the TSC counter as a clock base
(kernel/hrtimer.c).

To do that I guess, that I need to:
1. Define my own hrtimer_cpu_base with TSC .get_time =get_time()
function, .resolution=1.25 ns and .index = CLOCK_MONOTONIC
2. Define hrtimer struct (with .restart callback function) and use
hrtimer_init function for initialization.

3. .... I don't know if it is sufficient. Hints? Ideas?

Anyway I will investigate this issue in the following days (since
HRtimer subsystem is quite large) and poke for solution at other
architectures. 

Best regards,
Lukasz
