From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 4/6] Preempt-RCU: Implementation
Date: Fri, 29 Feb 2008 08:55:09 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802290853560.8804@gandalf.stny.rr.com>
References: <20071213170348.GA25981@in.ibm.com> <20071213171658.GE25981@in.ibm.com>
 <200802290534.57040.zippel@linux-m68k.org> <20080229045328.GA18687@linux.vnet.ibm.com>
 <Pine.LNX.4.64.0802291330590.2723@scrub.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, ego@in.ibm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:55023 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbYB2NzL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Feb 2008 08:55:11 -0500
In-Reply-To: <Pine.LNX.4.64.0802291330590.2723@scrub.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 29 Feb 2008, Roman Zippel wrote:
>
> I'd suggest to move PREEMPT_RCU back to Kconfig.preempt and if you really
> need the second symbol leave this behind (maybe with a comment):
>
> config CLASSIC_RCU
> 	def_bool !PREEMPT_RCU

Ah, OK, you are saying that we should only show the option for
PREEMPT_RCU? If selected, we use that and if not, we default to
CLASSIC_RCU.

I guess that can work.

-- Steve

>
> Once there are more options, we can still look for a better place...
