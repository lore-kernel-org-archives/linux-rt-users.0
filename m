From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 4/6] Preempt-RCU: Implementation
Date: Fri, 29 Feb 2008 08:53:18 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802290852060.8804@gandalf.stny.rr.com>
References: <20071213170348.GA25981@in.ibm.com> <20071213171658.GE25981@in.ibm.com>
 <200802290534.57040.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ego@in.ibm.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:40184 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbYB2NxV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Feb 2008 08:53:21 -0500
In-Reply-To: <200802290534.57040.zippel@linux-m68k.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Fri, 29 Feb 2008, Roman Zippel wrote:
>
> Also why is this a choice? Are more RCU types planned?

Why shouldn't it be a choice? You can have CLASSIC_RCU or PREEMPT_RCU, one
or the other and not both. Sounds perfect for being a choice.

-- Steve

