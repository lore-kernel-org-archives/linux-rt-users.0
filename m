From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
Date: Wed, 19 Sep 2007 20:38:32 -0700
Message-ID: <1190259512.11899.75.camel@imap.mvista.com>
References: <20070919064947.4B5A1399910@thor>
	 <1190216594.11899.3.camel@imap.mvista.com>
	 <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
	 <1190252151.11899.66.camel@imap.mvista.com>
	 <18161.53509.342082.588911@cargo.ozlabs.ibm.com>
	 <1190253281.11899.74.camel@imap.mvista.com>
	 <20070920032935.GC18991@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: David Gibson <dwg@au1.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:36809 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbXITDlm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 23:41:42 -0400
In-Reply-To: <20070920032935.GC18991@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-09-20 at 13:29 +1000, David Gibson wrote:

> > Maybe say "It a constant" up front .. The value that is output from the
> > clocksource read is converted to nanoseconds .. This clocksource is only
> > designed to work with the timebase, so it doesn't make sense to output
> > an rtc value.
> 
> I believe "rtc" in a 601 context means something different to "rtc" in
> a general context...

What's a 601 context?

Daniel
