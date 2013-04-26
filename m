From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 09:52:00 -0400
Message-ID: <1366984320.16752.7.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
	 <20130426091656.GD20927@linutronix.de>
	 <1366978398.10248.21.camel@gandalf.local.home>
	 <20130426133855.GG20927@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4935 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab3DZNwB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 09:52:01 -0400
In-Reply-To: <20130426133855.GG20927@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-04-26 at 15:38 +0200, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2013-04-26 08:13:18 [-0400]:
> 
> >> Steven, could you please resend it with a sign-off-by and maybe a little
> >> description? It seems to fix the same problen in v3.8.
> >> 
> >
> >Yeah, I also have to clean it up. I was waiting for confirmation from
> >Mike (which I got), which means I need to switch gears and get that out.
> 
> I'm sorry, you actually did it, I just overlooked it.

Oops, and I was thinking this was about the mce patch. Hmm, I think I
sent that out too. But I think it still needs to be cleaned up.

-- Steve

> 
> |23.04.13 22:10  Steven Rostedt    (3.3K) ( 100) [PATCH RT] swap: Use unique local lock name for swap_lock
> 
> I take this one :)
> 
> >-- Steve
> 
> Sebastian


