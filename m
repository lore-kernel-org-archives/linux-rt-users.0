From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: AW: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Fri, 21 Dec 2012 16:05:39 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212211604060.3148@ionos>
References: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>  <alpine.LFD.2.02.1212201856140.3148@ionos>  <F9467A784CC48947B1D879F07370839E0EBCEE96@fe20099s.ecn.etasgroup.com> <1356101745.5896.102.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	Jan Kiszka <jan.kiszka@web.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53017 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2LUPFm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 10:05:42 -0500
In-Reply-To: <1356101745.5896.102.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 21 Dec 2012, Steven Rostedt wrote:
> On Fri, 2012-12-21 at 08:23 +0000, Koehrer Mathias (ETAS/ESS2) wrote:
> >  *** DEADLOCK ***
> 
> So this is an obvious bug in virtualbox. No need to send us a config.
> This bug has nothing to do with RT. It's just that RT can expose bugs in
> mainline (or anything added to mainline) much easier.
> 
> Funny thing is, this deadlock isn't even possible in RT, so there's
> probably many more bugs in the virtualbox driver.

It's worse on RT, because that's a smp function call interrupt. Which
just cannot work on RT with the lock not being a raw lock.
 
Thanks,

	tglx
