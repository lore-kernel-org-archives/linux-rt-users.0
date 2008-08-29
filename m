From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 12:34:24 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808291233280.17917@gandalf.stny.rr.com>
References: <20080829154237.1196.66825.stgit@dev.haskins.net> <87abevpzv7.fsf@basil.nowhere.org> <48B81F60.3080409@gmail.com> <20080829162216.GW26610@one.firstfloor.org> <48B82349.1020109@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andi Kleen <andi@firstfloor.org>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:61103 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYH2Qe1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:34:27 -0400
In-Reply-To: <48B82349.1020109@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 29 Aug 2008, Gregory Haskins wrote:

> Andi Kleen wrote:
> >> Im running it on a x86_64 box as we speak.  How can I tell if there is a
> >> certain mode that is permitting this?
> >>     
> >
> > If the boot up says you're running with PMtimer then it uses the fallback
> > (usually happens on pre Fam10h AMD boxes). A typical Intel box
> > would use the faster ring 3 only TSC path and then explode with your
> > change I bet. 
> >
> > Or step with gdb through gettimeofday() and see if it does a syscall.
> >
> > -Andi
> >   
> 
> It seems to be running fine with no indication it has fallen back. 
> Perhaps I need a certain workload to bring out the issue?

Perhaps you never hit the slow path in userland. That's the only place it 
would write. Perhaps add a dummy static variable in the fast path, and 
write to it. See if that crashes you apps.

-- Steve
