From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 2.6.31.2-rt13
Date: Tue, 13 Oct 2009 19:11:04 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910131910030.9428@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>  <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>  <alpine.LFD.2.00.0908261910460.2888@localhost.localdomain>  <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain>
 <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain>  <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain>  <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>  <3efb10970910061123k2b6826bci11f0f42509173b26@mail.gmail.com>
 <alpine.LFD.2.00.0910062122230.5950@localhost.localdomain>  <alpine.LFD.2.00.0910062202590.5950@localhost.localdomain> <3efb10970910130846h2f9d4dbdk755f211fe8d43d4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38139 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760598AbZJMRME (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Oct 2009 13:12:04 -0400
In-Reply-To: <3efb10970910130846h2f9d4dbdk755f211fe8d43d4d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 13 Oct 2009, Remy Bohmer wrote:
> Hi Thomas,
> 
> 2009/10/6 Thomas Gleixner <tglx@linutronix.de>:
> > On Tue, 6 Oct 2009, Thomas Gleixner wrote:
> >
> >> On Tue, 6 Oct 2009, Remy Bohmer wrote:
> >> > But I was wondering if you missed this one:
> >> > http://patchwork.kernel.org/patch/50044/
> >>
> >> Yup, slipped through. Queued for the next release.
> >
> > Correction. I dropped the patch as it is just a sloppy work around.
> > Why creating the thread in the first place ? Real fix below.
> 
> Well, I noticed a few minutes ago that the sirq-hrtimer is
> periodically being scheduled (every 50msec here)
> It does not do much, but it still it does something... (no idea what though)

Yeah, noticed as well. It's due to the deferred handling of signal
based timers.
 
> So, is it really right to prevent it from starting up?

Nope. We just name it unconditionally :)

Thanks,

	tglx
