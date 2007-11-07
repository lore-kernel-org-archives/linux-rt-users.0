From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 7 Nov 2007 10:41:53 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711071040210.8572@gandalf.stny.rr.com>
References: <1194413959.8827.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754802AbXKGPmg@vger.kernel.org>
In-Reply-To: <1194413959.8827.66.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 7 Nov 2007, Steven Rostedt wrote:

> This is a special announcement for the latest -rt patches. This is
> actually announcing more than one tree (pay close attention to the
> differences between -rt7, -rt8 and -rt9).
>

[...]

>   2.6.23.1-rt9
>
>    - RT balancing by CPU priorities (Gregory Haskins)

-rt9 has been found to break UP compilation, so -rt10 has been released
with the fix.

>
>
> Now benchmarks against 2.6.23.1-rt7 -rt8 and -rt9 would be greatly
> appreciated.  These three are all present in

So please compare -rt7, -rt8 and -rt10.

-- Steve

>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/
>
