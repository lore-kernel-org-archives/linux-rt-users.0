From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [announce] split-up -rt patch-queue, v2.6.22.1-rt2
Date: Thu, 12 Jul 2007 19:01:29 +0200
Message-ID: <1184259689.12353.236.camel@chaos>
References: <20070712153717.GA7442@elte.hu>
	 <1184257998.7974.44.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:58406 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763368AbXGLRBb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 13:01:31 -0400
In-Reply-To: <1184257998.7974.44.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Daniel,

On Thu, 2007-07-12 at 09:33 -0700, Daniel Walker wrote:
> On Thu, 2007-07-12 at 17:37 +0200, Ingo Molnar wrote:
> > We are pleased to announce something we've been working on for some 
> > time: a finegrained, split-up patch queue of the -rt kernel patch. From 
> > now on (as of 2.6.22.1-rt2) it will be part of every upstream -rt 
> > release and it is available from the -rt download site:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > the -rt patch-queue consists of 374 patches at the moment, which do:
> > 
> >    698 files changed, 27920 insertions(+), 9603 deletions(-)
> 
> Is the number of patches relevant to you ? It seems like some patches
> could be boken out more. For instance there could be a per-architecture
> patch dedicated to converting spinlocks to raw spinlocks .. I was
> looking at preempt-realtime-i386.patch ..

We know very well and Ingo nowhere said, that this is not a perfect
queue, but it was and still is _our_ work base and we opened it up for
the reasons explained.

What we definitely not need is platitude advise, how we should manage
the queue and what could be improved as well as hysteric shuffling in
the queue right now.

There are enough problems to work on, cleanups to do and the least one
is to worry about how the queue is organized.

	tglx
