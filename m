From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Fri, 3 Jun 2016 17:59:21 +0200
Message-ID: <20160603155921.GB4496@linutronix.de>
References: <CAL7_A_Vs5F5nJM68-TJVUZpOu7pE7=9MkSLggA2c6TML9UM-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jens Koehler <jenskxxx@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52668 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcFCP7X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jun 2016 11:59:23 -0400
Content-Disposition: inline
In-Reply-To: <CAL7_A_Vs5F5nJM68-TJVUZpOu7pE7=9MkSLggA2c6TML9UM-Mw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Jens Koehler | 2016-06-01 09:46:56 [+0200]:

>Hi,
Hi,

>I am running a linux kernel with rt preempt patch and made also a  rt
>application. Application works good but sometimes I a get a message
>like "hrtimer: interrupt took 10252 ns" or "NOHZ:
>local_softirq_pending 102". What does it mean and is it a problem?

The hrtimer message tries to inform you that for some reasons you had
one or more hrtimers which expired and processing them to around 10us.
At a single point. This means either you had a lot of them or one in
particular took a very long time to finish. This might be problem
because you had a window of 10us in which you were not able to react to
external interrupts.

The NOHZ message means that you had a TIMER_SOFTIRQ and HRTIMER_SOFTIRQ
event pending but you rather went idle than process them. I've seen that
with network on an (almost) idle machine that the softirq was blocked
due to CPU pinning and so there was nothing else to do then to go idle.
There was one report around v3.8-RT I think and back the the debug code
didn't cover the scenario.

>Thanks and regards,
>Jens

Sebastian
