From: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
Date: Thu, 20 Sep 2007 09:35:10 -0700
Message-ID: <1190306110.14264.7.camel@localhost>
References: <20070919064947.4B5A1399910@thor>
	 <1190216594.11899.3.camel@imap.mvista.com>
	 <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>,
	Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39365 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756636AbXITQdm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Sep 2007 12:33:42 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KGXgZR022046
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 12:33:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8KGXfLc568720
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 12:33:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8KGXerK016602
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 12:33:41 -0400
In-Reply-To: <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-09-20 at 10:52 +1000, Paul Mackerras wrote:
> Daniel Walker writes:
> 
> > If you switch to the rtc do the shift and mult need to change?
> 
> You can't switch; any given CPU chip will have either the RTC or the
> timebase but not both.

I think what Daniel is pointing out is that the clocksource read
function isn't the place for the __USE_RTC() conditional. 

It would likely be better instead of the timebase clocksource managing
multiple type of hardware (timebase and RTC), to have a separate simple
RTC clocksource, and then conditionally register one or the other at
init time.

thanks
-john
