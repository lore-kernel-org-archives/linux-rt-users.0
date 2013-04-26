From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 08:13:18 -0400
Message-ID: <1366978398.10248.21.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
	 <20130426091656.GD20927@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27019 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab3DZMNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 08:13:20 -0400
In-Reply-To: <20130426091656.GD20927@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-04-26 at 11:16 +0200, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2013-04-22 22:44:56 [-0400]:
> 
> >When I built with CONFIG_DEBUG_FORCE_WEAK_PER_CPU it had issues with the
> >swap lock. Can you try this patch? What you showed looks different, but
> >did that happen with the updates you made?
> 
> Steven, could you please resend it with a sign-off-by and maybe a little
> description? It seems to fix the same problen in v3.8.
> 

Yeah, I also have to clean it up. I was waiting for confirmation from
Mike (which I got), which means I need to switch gears and get that out.

-- Steve


