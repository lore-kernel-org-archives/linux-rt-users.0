From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Mon, 9 Jun 2008 18:16:06 +0200
Message-ID: <20080609161606.GA24841@elte.hu>
References: <200805252108.25011.mitov@issp.bas.bg> <200806011901.23619.mitov@issp.bas.bg> <20080609121309.GA13610@elte.hu> <200806091911.21850.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi-suse@firstfloor.org>
To: Marin Mitov <mitov@issp.bas.bg>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60147 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYFIQQk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 12:16:40 -0400
Content-Disposition: inline
In-Reply-To: <200806091911.21850.mitov@issp.bas.bg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Marin Mitov <mitov@issp.bas.bg> wrote:

> > i think Thomas had a concern with the original fix - forgot the 
> > details.
> 
> Here they are:
> 
> http://lkml.org/lkml/2008/5/25/251
> 
> but see my comment to it.
> 
> There is no principal difference between both patches. I have seen 
> Steven's one as merged in linux-2.6.26-rc5. The only difference (if it 
> matters of all) is that in mine patch 
> preempt_disable()/preempt_enable() sections are shorter and protect 
> only the code that must be protected:
> 
> preempt_disable()
> rdtscl()
> smp_processor_id()
> preempt_enable()
> 
> As far as Steven's patch is already merged - let it be :-)

we could still merge your enhancements as well ontop of Steven's, if you 
would like to pursue it. If so then please send a patch against -rc5 or 
against -tip. Reducing the length of preempt-off sections is a fair 
goal.

	Ingo
