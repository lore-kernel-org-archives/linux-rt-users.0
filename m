From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
Date: Fri, 21 Sep 2007 14:59:31 +1000
Message-ID: <18163.20403.967082.774118@cargo.ozlabs.ibm.com>
References: <20070921032603.07AF232C889@thor>
	<1190347546.15347.27.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52476 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXIUE7j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 00:59:39 -0400
In-Reply-To: <1190347546.15347.27.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Daniel Walker writes:

> I don't think the RTC frequency isn't the same as the timebase? Seems
> like the RTC only case about seconds at the lowest level. If that's the
> case then the jiffies clock might be better to use .. The other thing I
> wonder is if the __USE_RTC boards might have lower level clocks that
> could be used instead ..

It's OK, the RTC isn't what you think it is, it's a pair of
CPU-internal registers which count seconds and nanoseconds.  On
processors with the RTC, tb_ticks_per_sec is initialized to
1000000000.  Trust me, this code is OK. :)

Paul.
