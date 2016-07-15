From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.6.4-rt8
Date: Fri, 15 Jul 2016 11:22:44 -0400
Message-ID: <20160715112244.4ff6ecab@gandalf.local.home>
References: <20160715114803.GA11606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:36822 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751000AbcGOPWr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 11:22:47 -0400
In-Reply-To: <20160715114803.GA11606@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 15 Jul 2016 13:48:04 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
> 
> I'm pleased to announce the v4.6.4-rt8 patch set. 
> 
> Changes since v4.6.4-rt8:
> 
>   - Import Thomas' timer rework known as "timer: Refactor the timer
>     wheel" patch set which made its way into the -TIP tree. With this
>     changes we get NOHZ_FULL working. Finally.

Does this mean that there's no more 1 second tick?

> 
>   - Avoid warning of an unused symbol in the !RT case
>     (preemptible_lazy())
> 
>   - Replace the "trace event preempt count" fixup with Steven's version.
> 
> Known issues
> 	- CPU hotplug got a little better but can deadlock.

Hmm, better but can deadlock.

-- Steve
