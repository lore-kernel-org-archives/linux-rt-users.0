From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
Date: Wed, 19 Sep 2007 18:54:41 -0700
Message-ID: <1190253281.11899.74.camel@imap.mvista.com>
References: <20070919064947.4B5A1399910@thor>
	 <1190216594.11899.3.camel@imap.mvista.com>
	 <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
	 <1190252151.11899.66.camel@imap.mvista.com>
	 <18161.53509.342082.588911@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	johnstul@us.ibm.com
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:21724 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbXITB5t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 21:57:49 -0400
In-Reply-To: <18161.53509.342082.588911@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-09-20 at 11:46 +1000, Paul Mackerras wrote:
> Daniel Walker writes:
> 
> > On Thu, 2007-09-20 at 10:52 +1000, Paul Mackerras wrote:
> > > Daniel Walker writes:
> > > 
> > > > If you switch to the rtc do the shift and mult need to change?
> > > 
> > > You can't switch; any given CPU chip will have either the RTC or the
> > > timebase but not both.
> > 
> > The code is switching between to clock read functions .. If they are
> 
> What part of "you can't switch" wasn't clear?  __USE_RTC() is a
> constant on any given machine.

Maybe say "It a constant" up front .. The value that is output from the
clocksource read is converted to nanoseconds .. This clocksource is only
designed to work with the timebase, so it doesn't make sense to output
an rtc value.

Daniel
