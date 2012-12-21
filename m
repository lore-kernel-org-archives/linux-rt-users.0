From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: AW: VirtualBox 4.2.4 freezes PC using RT_PREEMPT kernel
Date: Fri, 21 Dec 2012 10:13:01 -0500
Message-ID: <1356102781.5896.107.camel@gandalf.local.home>
References: <F9467A784CC48947B1D879F07370839E0EBCEA22@fe20099s.ecn.etasgroup.com>
	  <alpine.LFD.2.02.1212201856140.3148@ionos>
	  <F9467A784CC48947B1D879F07370839E0EBCEE96@fe20099s.ecn.etasgroup.com>
	 <1356101745.5896.102.camel@gandalf.local.home>
	 <alpine.LFD.2.02.1212211604060.3148@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	Jan Kiszka <jan.kiszka@web.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:30802 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab2LUPND (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Dec 2012 10:13:03 -0500
In-Reply-To: <alpine.LFD.2.02.1212211604060.3148@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-12-21 at 16:05 +0100, Thomas Gleixner wrote:
> On Fri, 21 Dec 2012, Steven Rostedt wrote:
> > On Fri, 2012-12-21 at 08:23 +0000, Koehrer Mathias (ETAS/ESS2) wrote:
> > >  *** DEADLOCK ***
> > 
> > So this is an obvious bug in virtualbox. No need to send us a config.
> > This bug has nothing to do with RT. It's just that RT can expose bugs in
> > mainline (or anything added to mainline) much easier.
> > 
> > Funny thing is, this deadlock isn't even possible in RT, so there's
> > probably many more bugs in the virtualbox driver.
> 
> It's worse on RT, because that's a smp function call interrupt. Which
> just cannot work on RT with the lock not being a raw lock.
>  

Ah, I just figured it was an normal interrupt thread. I was avoiding eye
cancer by not looking at the code. I guess I could have figured it out
with looking at the rest of the lockdep dump, but was too lazy ;-)

-- Steve


