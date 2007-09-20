From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] Implement generic time of day clocksource for
	powerpc machines.
Date: Thu, 20 Sep 2007 10:52:16 +1000
Message-ID: <18161.50240.599267.768383@cargo.ozlabs.ibm.com>
References: <20070919064947.4B5A1399910@thor>
	<1190216594.11899.3.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	johnstul@us.ibm.com
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:54091 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbXITBTD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 21:19:03 -0400
In-Reply-To: <1190216594.11899.3.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Daniel Walker writes:

> If you switch to the rtc do the shift and mult need to change?

You can't switch; any given CPU chip will have either the RTC or the
timebase but not both.

> > +       /* XXX this assumes clock->shift == 22 */
> > +       /* 4611686018 ~= 2^(20+64-22) / 1e9 */
> > +       t2x = (u64) clock->mult * 4611686018ULL;
> 
> It might make the code more readable if you put that constant into a
> macro that gives it a name.

The comment already gives more information than some arbitrary name
would.

Paul.
