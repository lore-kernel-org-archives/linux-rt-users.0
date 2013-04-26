From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 10:15:48 -0400
Message-ID: <1366985748.16752.16.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
	  <1366685096.9609.145.camel@gandalf.local.home>
	  <20130426091656.GD20927@linutronix.de>
	  <1366978398.10248.21.camel@gandalf.local.home>
	  <20130426133855.GG20927@linutronix.de>
	 <1366984320.16752.7.camel@gandalf.local.home>
	 <517A8957.1060908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10713 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3DZOPt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 10:15:49 -0400
In-Reply-To: <517A8957.1060908@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-04-26 at 16:04 +0200, Sebastian Andrzej Siewior wrote:
> On 04/26/2013 03:52 PM, Steven Rostedt wrote:
> > Oops, and I was thinking this was about the mce patch. Hmm, I think I
> > sent that out too. But I think it still needs to be cleaned up.
> 
> This is what I have so far:
> 
> https://git.kernel.org/cgit/linux/kernel/git/bigeasy/rt-v3.8-devel.git/tree/x86-mce-Defer-mce-wakeups-to-threads-for-PREEMPT_RT.patch
> 

Ah, you did the clean up for me.

Looks good.

-- Steve


