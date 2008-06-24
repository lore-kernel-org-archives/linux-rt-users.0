From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 13:13:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806241312460.4608@gandalf.stny.rr.com>
References: <4860CD0B0200005A0003944C@sinclair.provo.novell.com>
 <4860CD140200005A0003944F@sinclair.provo.novell.com>
 <4860CD140200005A0003944F@sinclair.provo.novell.com> <200806241646.08335.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <GHaskins@novell.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:61712 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbYFXRNV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 13:13:21 -0400
In-Reply-To: <200806241646.08335.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 24 Jun 2008, Juergen Beisert wrote:

>
> On Tuesday 24 June 2008 16:31, Gregory Haskins wrote:
> > I believe this is my fault.  You must be building for uniprocessor?  Ingo
> > has a fix for this issue in sched-devel that should be pulled into -rt.
>
> I can avoid this failure, when I disable the "Group scheduling for
> SCHED_RR/FIFO" menu entry. Don't know the impact.
>

Disabling that shouldn't effect you. [ CC'd Peter who can tell you better]

-- Steve

