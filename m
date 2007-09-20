From: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for powerpc machines.
Date: Thu, 20 Sep 2007 13:29:35 +1000
Message-ID: <20070920032935.GC18991@localhost.localdomain>
References: <20070919064947.4B5A1399910@thor> <1190216594.11899.3.camel@imap.mvista.com> <18161.50240.599267.768383@cargo.ozlabs.ibm.com> <1190252151.11899.66.camel@imap.mvista.com> <18161.53509.342082.588911@cargo.ozlabs.ibm.com> <1190253281.11899.74.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:50478 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbXITD3l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 23:29:41 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8K3TcB3008551
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 13:29:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8K3TcFh4780044
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 13:29:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8K3TcER017532
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Sep 2007 13:29:38 +1000
Content-Disposition: inline
In-Reply-To: <1190253281.11899.74.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 19, 2007 at 06:54:41PM -0700, Daniel Walker wrote:
> On Thu, 2007-09-20 at 11:46 +1000, Paul Mackerras wrote:
> > Daniel Walker writes:
> > 
> > > On Thu, 2007-09-20 at 10:52 +1000, Paul Mackerras wrote:
> > > > Daniel Walker writes:
> > > > 
> > > > > If you switch to the rtc do the shift and mult need to change?
> > > > 
> > > > You can't switch; any given CPU chip will have either the RTC or the
> > > > timebase but not both.
> > > 
> > > The code is switching between to clock read functions .. If they are
> > 
> > What part of "you can't switch" wasn't clear?  __USE_RTC() is a
> > constant on any given machine.
> 
> Maybe say "It a constant" up front .. The value that is output from the
> clocksource read is converted to nanoseconds .. This clocksource is only
> designed to work with the timebase, so it doesn't make sense to output
> an rtc value.

I believe "rtc" in a 601 context means something different to "rtc" in
a general context...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
