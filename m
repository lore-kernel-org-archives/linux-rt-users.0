From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Tue, 23 Apr 2013 12:00:55 -0400
Message-ID: <1366732855.9609.158.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
	 <1366685257.9609.147.camel@gandalf.local.home>
	 <1366686791.4731.16.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24597 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab3DWQA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Apr 2013 12:00:56 -0400
In-Reply-To: <1366686791.4731.16.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-04-23 at 05:13 +0200, Mike Galbraith wrote:
> On Mon, 2013-04-22 at 22:47 -0400, Steven Rostedt wrote:
> 
> > Yeah, the bug is with the swap_lock not being unique (do a git grep
> > swap_lock), and it being weak made that per_cpu swap_lock the same lock
> > as the other locks.
> > 
> > Apply my patch and your bug should go away.
> 
> Aha, so the bug is certainly dead.  I'll test anyway, but you can take
> no news as confirmation that it's dead.
> 

Actually, I would feel more comfortable if I heard news that confirms
its dead ;-)

/me hopes to hear "It's dead Jim".

-- Steve


