From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Wed, 18 Jun 2008 12:16:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806181215120.29622@gandalf.stny.rr.com>
References: <200805252108.25011.mitov@issp.bas.bg> <1213791416.16944.222.camel@twins>
 <4858C68C.BA47.005A.0@novell.com> <200806182242.49245.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <andi-suse@firstfloor.org>,
	Clark Williams <clark.williams@gmail.com>,
	Marin Mitov <mitov@issp.bas.bg>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, akpm@osdl.org,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:61522 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbYFRQQZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jun 2008 12:16:25 -0400
In-Reply-To: <200806182242.49245.nickpiggin@yahoo.com.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 18 Jun 2008, Nick Piggin wrote:

> There are _some_ cases where it can be used, but nobody has been
> able to come up with compelling uses really. I don't think this
> case is helped very much either because the logic in there using
> preempt-disable is fine, isn't it?
>
> Except that it should also have a cond_resched in it. Seems like
> an ideal place to put cond_resched because it is not a fastpath.
>

Does it really need a cond_resched? preempt_enable when it goes to zero
will already check to see if it should schedule.

-- Steve

