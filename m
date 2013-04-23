From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Mon, 22 Apr 2013 22:47:37 -0400
Message-ID: <1366685257.9609.147.camel@gandalf.local.home>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21846 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3DWCri (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 22:47:38 -0400
In-Reply-To: <1366685096.9609.145.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-04-22 at 22:44 -0400, Steven Rostedt wrote:

> When I built with CONFIG_DEBUG_FORCE_WEAK_PER_CPU it had issues with the
> swap lock. Can you try this patch? What you showed looks different, but
> did that happen with the updates you made?
> 

Ah, in your email you mentioned the swap_lock. I was just looking at
your dump (I read this email before going to Collab and didn't fully
"re-read" it after).

Yeah, the bug is with the swap_lock not being unique (do a git grep
swap_lock), and it being weak made that per_cpu swap_lock the same lock
as the other locks.

Apply my patch and your bug should go away.

Thanks,

-- Steve


