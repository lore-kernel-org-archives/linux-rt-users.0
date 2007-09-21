From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
Date: Thu, 20 Sep 2007 21:05:46 -0700
Message-ID: <1190347546.15347.27.camel@imap.mvista.com>
References: <20070921032603.07AF232C889@thor>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:49472 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXIUEJ2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 00:09:28 -0400
In-Reply-To: <20070921032603.07AF232C889@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-09-21 at 13:26 +1000, Tony Breeds wrote:
> +
> +       if (__USE_RTC())
> +               clock = &clocksource_rtc;
> +       else
> +               clock = &clocksource_timebase;
> +
> +       clock->mult = clocksource_hz2mult(tb_ticks_per_sec,
> clock->shift);

I don't think the RTC frequency isn't the same as the timebase? Seems
like the RTC only case about seconds at the lowest level. If that's the
case then the jiffies clock might be better to use .. The other thing I
wonder is if the __USE_RTC boards might have lower level clocks that
could be used instead ..

Daniel
