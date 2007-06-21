From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Two questions about high resolution timers
Date: Thu, 21 Jun 2007 23:37:05 +0200
Message-ID: <1182461825.3316.92.camel@chaos>
References: <1182438374.4726.19.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:50586 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756230AbXFUVhH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jun 2007 17:37:07 -0400
In-Reply-To: <1182438374.4726.19.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-21 at 17:06 +0200, Alessio Igor Bogani wrote:
> Hi to all,
> 
> Sorry for my poor english.

Hey no reason to excuse your self. It's not your fault that you are not
a native speaker and that the computer industry has chosen English as
the preferred language.

I can feel with you :)

> 1) What are reliable clocksources?

Reliable clock sources are devices, which are:

- continuously counting forward
- with a constant frequency
- have a reasonable wrap around time (at least > 100ms) of the counter

> 2) I have a mainboard with a 500 Mhz cpu which works perfectly with RT.
> I suppose that the max resolution is 2 ns for the high resolution timers
> but a "cat /proc/timer_list" reported:
>
>   .resolution: 1 nsecs <----
>
> How it is possible that this mainboard have 1 nsecs resolution?

The internal resolution is set to 1 nsec. This does not reflect the
hardware capabilities and we might have to think about it, but there are
good reasons not to do so, as clock sources and clock event devices -
and with them the resolution - can be exchanged on the fly and we do not
want to expose changing values to the applications.

> Excuse me if it are stupid questions. 

It's a valid question. No excuse necessary.

Thanks,

	tglx
