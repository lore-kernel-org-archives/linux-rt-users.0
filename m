From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:53:13 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808291251510.17917@gandalf.stny.rr.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org> <48B82349.1020109@gmail.com> <alpine.DEB.1.10.0808291233280.17917@gandalf.stny.rr.com>
 <48B8254D.1010206@gmail.com> <20080829164551.GY26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:43473 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYH2QxP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:53:15 -0400
In-Reply-To: <20080829164551.GY26610@one.firstfloor.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


The subject forgot to add "RT" in the brackets.

On Fri, 29 Aug 2008, Andi Kleen wrote:

> > I could just force all of the seqbegins to hit the slowpath by hacking
> > the code and see what happens (aside from slowing down, of course ;)
> 
> Only if you don't believe it will really crash? I think it's pretty
> clear even without trying it.
> 
> > Question: Which seqlock_t does userspace use?  I assume it uses
> > seqlock_t and not raw_seqlock_t. 
> 
> > But the only reason that I ask is that
> > I converted raw_seqlock_t to use the new style as well to be consistent,
> 
> There's no raw_seqlock_t anywhere in mainline?

Nope, raw_seqlock_t in -rt is equivelant to seqlock_t in mainline.

> 
> Anyways the variable is declared (in mainline) in asm-x86/vgtod.h 
> 
> > even though it is not strictly necessary for the same reasons.  So if
> > perchance userspace uses the raw variant, I could solve this issue by
> > only re-working the seqlock_t variant.  Kind of a long shot, but figured
> > I would mention it :)
> 
> I guess you could define a new seqlock_t which is explicitely user space
> safe. That might avoid such issues in the future. But then
> that would likely require some code duplication and be ugly.
> 
> On the other hand whatever problem you fixing in the kernel
> (to be honest it's still unclear to me what the problem is)
> needs to be likely fixed for the userland lock too.

I'm not convinced that the raw_seqlocks (mainline normal seqlocks) has a 
problem anyway.

-- Steve

