From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 10:44:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806241043070.32368@gandalf.stny.rr.com>
References: <4860CD0B0200005A0003944C@sinclair.provo.novell.com>
 <4860CD140200005A0003944F@sinclair.provo.novell.com>
 <4860CD140200005A0003944F@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jbe@pengutronix.de, linux-rt-users@vger.kernel.org, mingo@elte.hu,
	tglx@linutronix.de, linux-kernel@vger.kernel.org
To: Gregory Haskins <GHaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:62018 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYFXOoe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 10:44:34 -0400
In-Reply-To: <4860CD140200005A0003944F@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 24 Jun 2008, Gregory Haskins wrote:

>
> (Sorry for toppost)
>
> I believe this is my fault.  You must be building for uniprocessor?  Ingo has a fix for this issue in sched-devel that should be pulled into -rt.
>
> Sorry for the inconvenience.  I will pull the patch myself and submit it when I get home (if someone doesn't beat me to it)
>

I'm looking forward to it ;-)

>
> This occurs when I try to build a PowerPC (MPC5200) kernel:
>
> [...]
> In file included from kernel/sched.c:1318:
> kernel/sched.c: In function 'sched_init':
> kernel/sched.c:7702: error: implicit declaration of function 'global_rt_runtime'
> [...]

I'm waiting on a Signed-off-by to include the patch. If I don't get it
soon then I'll just sign it off my self and leave the "From" line intact.
But I would feel much more comfortable with an actual SOB.

-- Steve

