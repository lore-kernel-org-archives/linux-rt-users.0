From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 2/2] ftrace: fix elevated preempt_count in
	wakeup-tracer
Date: Tue, 19 Aug 2008 16:07:48 +0200
Message-ID: <1219154869.10800.386.camel@twins>
References: <20080819091817.21725.81831.stgit@dev.haskins.net>
	 <20080819091923.21725.41087.stgit@dev.haskins.net>
	 <1219151556.10800.383.camel@twins> <48AAC8E7.1030506@novell.com>
	 <alpine.DEB.1.10.0808190942070.23667@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54435 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYHSOHn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 10:07:43 -0400
In-Reply-To: <alpine.DEB.1.10.0808190942070.23667@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-08-19 at 09:45 -0400, Steven Rostedt wrote:
> On Tue, 19 Aug 2008, Gregory Haskins wrote:
> > > 
> > > Is preempt_count > 1 at all times here?
> > > 
> > > If not, it might drop to 0 and any interrupt might cause preemption -
> > > and its not obvious to me that that is actually correct.
> > >   
> > According to Steve, we are already in an interrupt-disabled section here, but
> > I will defer to him.  He suggested I try this over an IRC conversation when I
> > noticed a strange wakeup trace, and it seems to have solved the problem.
> 
> Exactly.
> 
> Peter,
> 
> We disable preemption, do a per_cpu check, if we are not nested we grab 
> disable interrupts and grab the spin lock.
> 
> The issue that Gregory brought up, was that the tracer would always show 
> that preemption was disabled, when it really wasn't. It was recording the
> preempt disabled that the trace function itself made. The answer was 
> simply to do as Greg did, and enable preemption (but interrupts are 
> still disabled), call the function tracer, then disable preemption again 
> (to match the outside preemption enabling.

Ok good. 

