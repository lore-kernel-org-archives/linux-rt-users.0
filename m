From: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for powerpc machines.
Date: Fri, 21 Sep 2007 09:46:53 +1000
Message-ID: <20070920234653.GW9814@bakeyournoodle.com>
References: <20070919064947.4B5A1399910@thor> <1190216594.11899.3.camel@imap.mvista.com> <18161.50240.599267.768383@cargo.ozlabs.ibm.com> <1190306110.14264.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Daniel Walker <dwalker@mvista.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:57361 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXITXqz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Sep 2007 19:46:55 -0400
Content-Disposition: inline
In-Reply-To: <1190306110.14264.7.camel@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Sep 20, 2007 at 09:35:10AM -0700, john stultz wrote:
 
> I think what Daniel is pointing out is that the clocksource read
> function isn't the place for the __USE_RTC() conditional. 
> 
> It would likely be better instead of the timebase clocksource managing
> multiple type of hardware (timebase and RTC), to have a separate simple
> RTC clocksource, and then conditionally register one or the other at
> init time.

I'll create a seperate clocksource for the RTC case and use that as
appropriate.  I'll resend the patch series after I've booted it :)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
