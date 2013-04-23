From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Tue, 23 Apr 2013 05:13:11 +0200
Message-ID: <1366686791.4731.16.camel@marge.simpson.net>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
	 <1366685257.9609.147.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59282 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab3DWDNO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Apr 2013 23:13:14 -0400
In-Reply-To: <1366685257.9609.147.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-04-22 at 22:47 -0400, Steven Rostedt wrote:

> Yeah, the bug is with the swap_lock not being unique (do a git grep
> swap_lock), and it being weak made that per_cpu swap_lock the same lock
> as the other locks.
> 
> Apply my patch and your bug should go away.

Aha, so the bug is certainly dead.  I'll test anyway, but you can take
no news as confirmation that it's dead.

-Mike

