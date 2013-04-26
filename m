From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING + CONFIG_DEBUG_FORCE_WEAK_PER_CPU
 = boot time swap_lock deadlock
Date: Fri, 26 Apr 2013 16:04:07 +0200
Message-ID: <517A8957.1060908@linutronix.de>
References: <1365937652.4717.25.camel@marge.simpson.net>  <1366685096.9609.145.camel@gandalf.local.home>  <20130426091656.GD20927@linutronix.de>  <1366978398.10248.21.camel@gandalf.local.home>  <20130426133855.GG20927@linutronix.de> <1366984320.16752.7.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49098 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3DZOEK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 10:04:10 -0400
In-Reply-To: <1366984320.16752.7.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/26/2013 03:52 PM, Steven Rostedt wrote:
> Oops, and I was thinking this was about the mce patch. Hmm, I think I
> sent that out too. But I think it still needs to be cleaned up.

This is what I have so far:

https://git.kernel.org/cgit/linux/kernel/git/bigeasy/rt-v3.8-devel.git/tree/x86-mce-Defer-mce-wakeups-to-threads-for-PREEMPT_RT.patch

> -- Steve

Sebastian
