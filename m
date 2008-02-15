From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH -rt] ARM: compile fix for event tracing
Date: Fri, 15 Feb 2008 16:27:39 +0000 (UTC)
Message-ID: <loom.20080215T162609-808@post.gmane.org>
References: <87fxyjruy8.fsf@vence.hilman.org> <Pine.LNX.4.58.0712041003230.9066@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38451 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798AbYBOQ1u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Feb 2008 11:27:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JQ3Pd-00028h-1O
	for linux-rt-users@vger.kernel.org; Fri, 15 Feb 2008 16:27:45 +0000
Received: from 6.177.115-78.rev.gaoland.net ([6.177.115-78.rev.gaoland.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2008 16:27:45 +0000
Received: from matthieu.castet by 6.177.115-78.rev.gaoland.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2008 16:27:45 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt <rostedt <at> goodmis.org> writes:


> On Mon, 3 Dec 2007, Kevin Hilman wrote:
> 
> > The cycles/usecs conversion macros should be dependent on
> > CONFIG_EVENT_TRACE instead of CONFIG_LATENCY_TIMING.
> >
> Hi, thanks I'll apply this.
> 
> But please, in the future, state which version of the -rt patch you
> applied this to.
> 
But now this berak when CONFIG_LATENCY_TIMING. is selected but not
CONFIG_EVENT_TRACE


Matthieu
